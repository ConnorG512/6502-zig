// 6502-zig, emulation of the 6502 microprocessor in Zig.
//Copyright (C) <2024>  <Connor Garey>

//This program is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with this program.  If not, see <https://www.gnu.org/licenses/>.

const cpu = @import("cpu.zig").CPU;
const memory_module = @import("memory.zig").Memory;
const logging = @import("logging.zig");

const AddressingModes = struct {

    pub const addressingMode = enum {
        accumulator,
        immediate, 
        zero_page, 
        zero_page_x,
        zero_page_y,
        relative, 
        absolute, 
        absolute_x, 
        absolute_y, 
        indirect,
        indirect_x, 
        indirect_y,
        implied 
    };

    const addressingModeFn = *const fn(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16;

    pub const ADDRESSING_MODE_SET = [_]addressingModeFn{
        accumulatorAddressingMode,     // 0x0
        immediateAddressingMode,       // 0x1
        zeroPageAddressingMode,        // 0x2
        zeroPageXAddressingMode,       // 0x3
        zeroPageYAddressingMode,       // 0x4
        relativeAddressingMode,        // 0x5
        absoluteAddressingMode,        // 0x6
        absoluteXAddressingMode,       // 0x7 
        absoluteYAddressingMode,       // 0x8 
        indirectAddressingMode,        // 0x9 
        indirectIndexedAddressingMode, // 0xA
        indexedIndirectAddressingMode, // 0xB
        impliedAddressingMode,         // 0xC
        illegalAddressingMode,         // 0xD
    };

    pub fn callAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8, addressingModeIndex: addressingMode) void {
        const selectedAddressingMode = ADDRESSING_MODE_SET[@intFromEnum(addressingModeIndex)];
        selectedAddressingMode(CPU_inst, memory, byte_length);
    }

    //////////////////////////////////////////
    /// ADDRESSING MODES
    //////////////////////////////////////////


    fn accumulatorAddressingMode(_: *cpu, _: *const []u8, _: *u8) u16 {
        logging.infoLog("cpu_addressingModes: accumulator addressing mode finished!");
    }

    fn immediateAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        const operand: u8 = memory.readByte(CPU_inst.RPC + 1); // Dereferencing the value in the array 
        CPU_inst.RPC += 2; // Move the program counter forward by 2 bytes to vover the opcode and the operand
        byte_length = 2;    
        logging.infoLog("cpu_addressingModes: immediate addressing mode finished!");
        return operand;
    }

    fn zeroPageAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        const address: u16 = memory.readByte(CPU_inst.RPC); // Read address from counter
        const value: u8 = memory.readByte(address); // Read value from zero page address
        CPU_inst.RPC += 1; // Increment program counter by 1, zero-page only uses 1 byte
        byte_length = 2;
        logging.infoLog("cpu_addressingModes: zero page addressing mode finished!");
        return value; 
    }

    fn zeroPageXAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        const base_address: u8 = memory.readByte(CPU_inst.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + CPU_inst.RX) & 0xFF; // Adding and wrapping X to 8 bits
        byte_length = 2;
        logging.infoLog("cpu_addressingModes: zero page x addressing mode finished!");
        return address;
    }

    fn zeroPageYAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        const base_address: u8 = memory.readByte(CPU_inst.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + CPU_inst.RY) & 0xFF; // Adding and wrapping X to 8 bits
        byte_length = 2;
        logging.infoLog("cpu_addressingModes: zero page y addressing mode finished!");
        return address;
    }

    fn relativeAddressingMode(CPU_inst: *cpu, memory: *const []u8, _: *u8) u16{
        // Getting the relative offset from the bute that is relative to the operand. 
        const offset: i8 = i8(memory.readByte((CPU_inst.RPC + 1))); // casting as an signed 8 bit integer
        const new_address: u16 = u16(CPU_inst.RPC + 2) + u16(offset);
        logging.infoLog("cpu_addressingModes: relative addressing mode finished!");
        return new_address; // return the calculated address
    }
    
    fn absoluteAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        // Instructions using absolute addressing contain a full 16 bit address to identify the target location.
        const low_byte: u8 = memory.readByte(CPU_inst.RPC + 1); // Fetching the low byte
        const high_byte: u8 = memory.readByte(CPU_inst.RPC + 2); // Fetching the high byte
        CPU_inst.RPC += 3; // Moving the program counter 3 spaces forward
        const result: u16 = (high_byte << 8 | low_byte);
        byte_length = 3;
        logging.infoLog("cpu_addressingModes: absolute addressing mode finished!");
        return result;
    }

    fn absoluteXAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        const base_address: u16 = memory.readWord(CPU_inst.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + CPU_inst.RY; // Add Y Register
        byte_length = 3;
        logging.infoLog("cpu_addressingModes: absolute x addressing mode finished!");
        return address;
    }

    fn absoluteYAddressingMode(CPU_inst: *cpu, memory: *const []u8, byte_length: *u8) u16 {
        const base_address: u16 = memory.readWord(CPU_inst.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + CPU_inst.RX; // Add X Register
        logging.infoLog("cpu_addressingModes: absolute y addressing mode finished!");
        byte_length = 3;
        return address;
    }

    fn indirectAddressingMode(_: *cpu, _: *const []u8, _: *u8) u16 {
        logging.infoLog("cpu_addressingModes: indirect addressing mode finished!");
    }

    fn indexedIndirectAddressingMode(_: *cpu, _: *const []u8, _: *u8) u16 {
        logging.infoLog("cpu_addressingModes: indexed indirect addressing mode finished!");
    }

    fn indirectIndexedAddressingMode(_: *cpu, _: *const []u8, _: *u8) u16 {
        logging.infoLog("cpu_addressingModes: indirect indexed addressing mode finished!");
    }
    
    fn impliedAddressingMode(_: *cpu, _: *const []u8, _: *u8) u16 {
        logging.infoLog("cpu_addressingModes: implied addressing mode finished!");
    }

    fn illegalAddressingMode(_: *cpu, _: *const []u8, _: *u8) u16 {
        logging.infoLog("cpu_addressingModes: illegal addressing mode finished!");
    }
};