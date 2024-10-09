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

const std = @import("std");
const logging = @import("logging.zig");
const memory_module = @import("memory.zig").Memory;

// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502
// http://www.6502.org/users/obelisk/6502/instructions.html
// https://www.ahl27.com/posts/2023/01/6502-emu1/
// https://archive.org/details/mos_microcomputers_programming_manual
// http://www.6502.org/tutorials/65c02opcodes.html
// http://www.6502.org/users/obelisk/6502/reference.html

const CPUError = error {
    null_byte,
    null_cpu_ref,
    unimplemented_address_pipe,
    unimplemented_op_code,
    invalid_addressing_mode,
    invalid_op_code,
    cpu_flag_overflow,
};

const CPU = struct {
    // Registers 
    RA: u8, // Accumulator register
    RP: u8, // Status register - Only 7 bits are used, bit 5 is always 1. 0C, 1Z, 2I, 3D, 4B, 5 Unused, 6V, 7N
    RS: u8, // Stack Pointer 
    RX: u8, // index register
    RY: u8, // index register
    RPC: u16, // Program counter

    const addressingMode = enum {
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
        implied };

    pub fn assignInstruction(self: *CPU, memory: []*u8) !void {
        const instruction = memory[self.RPC]; // Instructions can be multiple bytes and will need to be stored to understand the full instruction.

        if (instruction == null) { // Error handling
            logging.errorLog("Error, Byte is null!");
            return CPUError.nullByte;
        }   
        
        switch (instruction) {
            // 6502 instruction set
            0x00 => { // BRK
                self.RP = 0b00001100;
            },
            0x01 => { 

            }
        }
        
    }

    fn addWithCarry(self: *CPU, memory: []*u8, mode:addressingMode) !void {
        var operand: u16 = 0;
        
        switch (mode) {
            addressingMode.immediate => {
                operand = immediateAddressingMode(self, memory);
            },
            addressingMode.zero_page => {
                operand = zeroPageAddressingMode(self, memory);
            },
            addressingMode.zero_page_x => {
                operand = zeroPageXAddressingMode(self, memory)
            },
            addressingMode.absolute => {
                operand = absoluteAddressingMode(CPU, memory);
            },
            addressingMode.absolute_x => {
                operand = absoluteXAddressingMode(self, memory);
            },
            addressingMode.absolute_y => {
                operand = absoluteYAddressingMode(self, memory);
            },
            addressingMode.indirect_x => {
                return CPUError.unimplemented_op_code;
            },
            addressingMode.indirect_y => {
                return CPUError.unimplemented_op_code;
            },
            _ => {
                return CPUError.invalid_op_code;
            },

        }

            // The carry flag is set if an overflow occurs
            // If the flag is set to 1 then set carry as 1 otherwise 0
            const carry: u8 = if (self.RP & 0b00000001 != 0) {
                1;
            } else {
                0;
            };
            
            // Sum all of the registers together including the carry flag.
            const result: u16 =  @as(u16, self.RA) + @as(u16, operand) + @as(u16, carry);

            // if there is an overflow, the carry flag will need to be set to 1
            if (result > 0xFF) {
                setFlag(0b0_0_0_0_0_0_0_1);
            } else {
                clearFlag(0b0_0_0_0_0_0_0_1);
            }

            // Storing the lower bit value back in the accumulator
            self.RA = u8(result & 0xFF); 

    }

    // Set flags for functions
    // flag 5 is unused in 6502 and will always be set to the value of 1
    fn setAllFlags(self: *CPU) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in setAllFlags() !");
            return CPUError.null_cpu_ref;
        }
        
        self.RP = 0b1_1_1_1_1_1_1_1;
    }

    fn setFlag(self: *CPU, flag:u8) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in setFlag() !");
            return CPUError.null_cpu_ref;
        }

        if (flag > 0b1_1_1_1_1_1_1_1) {
            logging.errorLog("Error: Flag overflow in setFlag() !");
            return CPUError.cpu_flag_overflow;
        }

        // bitwise or (|) operation to set the respective bits to 1
        self.RP |= flag;
    }
    
    fn clearAllFlags (self: *CPU) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in clearAllFlags() !");
            return CPUError.null_cpu_ref;
        }

        self.RP = 0b0_0_0_0_1_0_0_0;
    }

    fn clearFlag(self: *CPU, flag:u8) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in clearFlag() !");
            return CPUError.null_cpu_ref;
        }
        
        if (flag > 0b1_1_1_1_1_1_1_1) {
            logging.errorLog("Error: Flag overflow in clearFlag() !");
            return CPUError.cpu_flag_overflow;
        }

        // bitwise and (&) not (~) operation to set the respective bits to 0
        self.RP &= ~flag;
    }

    /////////////////////////////////////////////////////////////////////////
    // ADDRESSING MODES
    /////////////////////////////////////////////////////////////////////////
    
    fn accumulatorAddressingMode() u16 {
        logging.errorLog("Uninplemented Instruction!");
    }

    fn immediateAddressingMode(self: *CPU, memory: *memory_module) u8 {
        const operand: u8 = memory.readByte(self.RPC + 1); // Dereferencing the value in the array 
        self.RPC += 2; // Move the program counter forward by 2 bytes to vover the opcode and the operand
        return operand;
    }

    fn zeroPageAddressingMode(self: *CPU, memory: *memory_module) u16 {
        const address: u16 = memory.readByte(self.RPC); // Read address from counter
        const value: u8 = memory.readByte(address); // Read value from zero page address

        self.RPC += 1; // Increment program counter by 1, zero-page only uses 1 byte

        return value; 
    }

    fn zeroPageXAddressingMode(self: *CPU, memory: *memory_module) u16 {
        const base_address: u8 = memory.readByte(self.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + self.RX) & 0xFF; // Adding and wrapping X to 8 bits
        return address;
    }

    fn zeroPageYAddressingMode(self: *CPU, memory: *memory_module) u16 {
        const base_address: u8 = memory.readByte(self.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + self.RY) & 0xFF; // Adding and wrapping X to 8 bits
        return address;
    }

    fn relativeAddressingMode() u16 {
        logging.errorLog("Uninplemented Instruction!");
    }
    
    fn absoluteAddressingMode(self: *CPU, memory: *memory_module) u16 {
        // Instructions using absolute addressing contain a full 16 bit address to identify the target location.
        const low_byte: u8 = memory.readByte(self.RPC + 1); // Fetching the low byte
        const high_byte: u8 = memory.readByte(self.RPC + 2); // Fetching the high byte
        self.RPC += 3; // Moving the program counter 3 spaces forward
        const result: u16 = (high_byte << 8 | low_byte);
        return result;
    }

    fn absoluteXAddressingMode(self: *CPU, memory: *memory_module) u16 {
        const base_address: u16 = memory.readWord(self.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + self.RY; // Add Y Register
        return address;
    }

    fn absoluteYAddressingMode(self: *CPU, memory: *memory_module) u16 {
        const base_address: u16 = memory.readWord(self.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + self.RX; // Add X Register
        return address;
    }

    fn indirectAddressingMode() u16 {
        logging.errorLog("Uninplemented Instruction!");
    }

    fn indexedIndirectAddressingMode() u16 {
        logging.errorLog("Uninplemented Instruction!");
    }

    fn indirectIndexedAddressingMode() u16 {
        logging.errorLog("Uninplemented Instruction!");
    }
};