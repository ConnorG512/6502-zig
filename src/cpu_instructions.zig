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

// http://www.6502.org/users/obelisk/6502/instructions.html
// http://www.6502.org/users/obelisk/6502/reference.html

const CPU = @import("cpu.zig").CPU;
const logging = @import("logging.zig");
const std = @import("std");
const cpu_flag = @import("cpu_flag.zig").CPU_flag;
const memory_module = @import("memory.zig").Memory;

pub const CPU_Instruction = struct {

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

    ///////////////////////////////////////
    // Load / Store Operations
    ///////////////////////////////////////
    
    pub fn LDA(cpu: *CPU, memory: *const [65536]u8, addressing_mode: addressingMode) void {
        logging.infoLog("cpu_instructions: LDA Called!");
        // Fetching the next byte in memory so it is not collecting the opcode
        const address: u16 = cpu.RPC + 1;

        // Reading a byte of memory and putting it into the A register.
        cpu.RA = memory_module.readByte(memory, address);
        // Moving the skipping over the current instruction on the the next depending on the instructions size
        cpu.RPC += 2;
    }

    pub fn LDX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: LDX Called!");
    }

    pub fn LDY(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: LDY Called!");
    }

    pub fn STA(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: STA Called!");
    }

    pub fn STX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: STX Called!");
    }

    pub fn STY(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: STY Called!");
    }

    ///////////////////////////////////////
    // Register transfers
    ///////////////////////////////////////
    
    pub fn TAX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: TAX Called!");
    }

    pub fn TAY(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: TAY Called!");
    }

    pub fn TXA(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: TXA Called!");
    }

    pub fn TYA(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: TYA Called!");
    }

    ///////////////////////////////////////
    // Stack Operations
    ///////////////////////////////////////

    pub fn TSX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: TSX Called!");
    }

    pub fn TXS(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: TXS Called!");
    }

    pub fn PHA(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: PHA Called!");
    }

    pub fn PHP(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: PHP Called!");
    }

    pub fn PLA(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: PLA Called!");
    }

    pub fn PLP(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: PLP Called!");
    }

    ///////////////////////////////////////
    // Logical
    ///////////////////////////////////////
     
    pub fn AND(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: AND Called!");
    }

    pub fn EOR(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: EOR Called!");
    }

    pub fn ORA(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: ORA Called!");
    }

    pub fn BIT(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BIT Called!");
    } 
    
    ///////////////////////////////////////
    // Arithmetic
    ///////////////////////////////////////

    pub fn ADC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: ADC Called!");
    } 

    pub fn SBC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: SBC Called!");
    } 

    pub fn CMP(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CMP Called!");
    } 

    pub fn CPX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CPX Called!");
    } 

    pub fn CPY(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CPY Called!");
    } 

    ///////////////////////////////////////
    // Increments & Decrements
    ///////////////////////////////////////

    pub fn INC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: INC Called!");
    } 

    pub fn INX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: INX Called!");
    } 

    pub fn INY(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: INY Called!");
    } 

    pub fn DEC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: DEC Called!");
    } 

    pub fn DEX(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: DEX Called!");
    } 

    pub fn DEY(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: DEY Called!");
    } 

    ///////////////////////////////////////
    // Shifts
    ///////////////////////////////////////

    pub fn ASL(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: ASL Called!");
    } 
    
    pub fn LSR(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: LSR Called!");
    }

    pub fn ROL(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: ROL Called!");
    } 

    pub fn ROR(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: ROR Called!");
    }  

    ///////////////////////////////////////
    // Jumps & Calls
    ///////////////////////////////////////

    pub fn JMP(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: JMP Called!");
    } 

    pub fn JSR(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: JSR Called!");
    } 

    pub fn RTS(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: RTS Called!");
    } 

    ///////////////////////////////////////
    // Branches
    ///////////////////////////////////////

    pub fn BCC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BCC Called!");
    } 

    pub fn BCS(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BCS Called!");
    } 

    pub fn BEQ(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BEQ Called!");
    } 

    pub fn BMI(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BMI Called!");
    } 

    pub fn BNE(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BNE Called!");
    } 

    pub fn BPL(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BPL Called!");
    } 

    pub fn BVC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BVC Called!");
    } 

    pub fn BVS(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: BVS Called!");
    } 

    ///////////////////////////////////////
    // Status Flag Changes
    ///////////////////////////////////////

    pub fn CLC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CLC Called!");
    } 

    pub fn CLD(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CLD Called!");
    } 

    pub fn CLI(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CLI Called!");
    } 

    pub fn CLV(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: CLV Called!");
    } 

    pub fn SEC(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: SEC Called!");
    } 

    pub fn SED(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: SED Called!");
    } 

    pub fn SEI(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: SEI Called!");
    } 

    ///////////////////////////////////////
    // System Functions
    ///////////////////////////////////////
    
    pub fn BRK(CPU_inst: *CPU, memory: *const [65536]u8, addressing_mode: addressingMode) void {
        logging.infoLog("cpu_instructions: BRK Called!");
        
        if (addressing_mode == addressingMode.implied) {

        } else {

        }

        cpu_flag.setFlag(cpu_flag.flagEnum.interrupt_f, &CPU_inst.RP);
        CPU_inst.RPC = memory[CPU_inst.RPC + 1];
    } 

    pub fn NOP(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: NOP Called!");
    } 

    pub fn RTI(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.infoLog("cpu_instructions: RTI Called!");
    }

    ///////////////////////////////////////
    // Illegal instruction
    ///////////////////////////////////////

    pub fn illegalInstruction(_: *CPU, _: *const [65536]u8, _: addressingMode) void {
        logging.errorLog("Illegal instruction called!");
    }

    ///////////////////////////////////////
    // ADDRESSING MODES
    ///////////////////////////////////////
    
    // Not to be called from outide the module. Only called internally.

    fn accumulatorAddressingMode() u16 {

    }

    fn immediateAddressingMode(CPU_inst: *CPU, memory: *const []u8) u8 {
        const operand: u8 = memory.readByte(CPU_inst.RPC + 1); // Dereferencing the value in the array 
        CPU_inst.RPC += 2; // Move the program counter forward by 2 bytes to vover the opcode and the operand
        logging.infoLog("cpu_instructions: immediate addressing mode finished!");
        return operand;
    }

    fn zeroPageAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        const address: u16 = memory.readByte(CPU_inst.RPC); // Read address from counter
        const value: u8 = memory.readByte(address); // Read value from zero page address
        CPU_inst.RPC += 1; // Increment program counter by 1, zero-page only uses 1 byte
        logging.infoLog("cpu_instructions: zero page addressing mode finished!");
        return value; 
    }

    fn zeroPageXAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        const base_address: u8 = memory.readByte(CPU_inst.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + CPU_inst.RX) & 0xFF; // Adding and wrapping X to 8 bits
        logging.infoLog("cpu_instructions: zero page x addressing mode finished!");
        return address;
    }

    fn zeroPageYAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        const base_address: u8 = memory.readByte(CPU_inst.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + CPU_inst.RY) & 0xFF; // Adding and wrapping X to 8 bits
        logging.infoLog("cpu_instructions: zero page y addressing mode finished!");
        return address;
    }

    fn relativeAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        // Getting the relative offset from the bute that is relative to the operand. 
        const offset: i8 = i8(memory.readByte((CPU_inst.RPC + 1))); // casting as an signed 8 bit integer
        const new_address: u16 = u16(CPU_inst.RPC + 2) + u16(offset);
        logging.infoLog("cpu_instructions: relative addressing mode finished!");
        return new_address; // return the calculated address
    }
    
    fn absoluteAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        // Instructions using absolute addressing contain a full 16 bit address to identify the target location.
        const low_byte: u8 = memory.readByte(CPU_inst.RPC + 1); // Fetching the low byte
        const high_byte: u8 = memory.readByte(CPU_inst.RPC + 2); // Fetching the high byte
        CPU_inst.RPC += 3; // Moving the program counter 3 spaces forward
        const result: u16 = (high_byte << 8 | low_byte);
        logging.infoLog("cpu_instructions: absolute addressing mode finished!");
        return result;
    }

    fn absoluteXAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        const base_address: u16 = memory.readWord(CPU_inst.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + CPU_inst.RY; // Add Y Register
        logging.infoLog("cpu_instructions: absolute x addressing mode finished!");
        return address;
    }

    fn absoluteYAddressingMode(CPU_inst: *CPU, memory: *const []u8) u16 {
        const base_address: u16 = memory.readWord(CPU_inst.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + CPU_inst.RX; // Add X Register
        logging.infoLog("cpu_instructions: absolute y addressing mode finished!");
        return address;
    }

    fn indirectAddressingMode() u16 {
        logging.infoLog("cpu_instructions: indirect addressing mode finished!");
    }

    fn indexedIndirectAddressingMode() u16 {
        logging.infoLog("cpu_instructions: indexed indirect addressing mode finished!");
    }

    fn indirectIndexedAddressingMode() u16 {
        logging.infoLog("cpu_instructions: indirect indexed addressing mode finished!");
    }
};