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
const cpu_flag_module = @import("cpu_flag.zig").CPU_flag;

// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502
// http://www.6502.org/users/obelisk/6502/instructions.html
// https://www.ahl27.com/posts/2023/01/6502-emu1/
// https://archive.org/details/mos_microcomputers_programming_manual
// http://www.6502.org/tutorials/65c02opcodes.html
// http://www.6502.org/users/obelisk/6502/reference.html

pub const CPU = struct {
    // Registers 
    RA: u8, // Accumulator register
    RP: u8, // Status register - Only 7 bits are used, bit 5 is always 1. 0C, 1Z, 2I, 3D, 4B, 5 Unused, 6V, 7N
    RS: u8, // Stack Pointer 
    RX: u8, // index register
    RY: u8, // index register
    RPC: u16, // Program counter

    const CPUError = error {
        null_byte,
        null_cpu_ref,
        unimplemented_address_pipe,
        unimplemented_op_code,
        invalid_addressing_mode,
        invalid_op_code,
        cpu_flag_overflow,
    };

    const cpu_flags = cpu_flag_module.flagEnum;

    pub fn assignInstruction(self: *CPU, memory: *const [65536]u8) void {
        
        const instruction = memory[self.RPC]; // Instructions can be multiple bytes and will need to be stored to understand the full instruction.

        switch (instruction) {
            // 6502 instruction set
            0x00 => { // BRK
            logging.infoLog("Break hit! \n");
                self.RP = 0b00001100;
            },
            0x01 => { 
                logging.infoLog("0x1 Hit! \n");
            },
            else => {
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
                operand = zeroPageXAddressingMode(self, memory);
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
                cpu_flag_module.setFlag(cpu_flags.carry_f, &self.RP);
            } else {
                cpu_flag_module.clearFlag(cpu_flags.carry_f, &self.RP);
            }

            // Storing the lower bit value back in the accumulator
            self.RA = u8(result & 0xFF); 

    }

    fn logicalAND(self: *CPU, memory: []*u8, mode:addressingMode) !void {
        const operand: u16 = 0;

        switch (mode) {
            addressingMode.immediate => {
                operand = immediateAddressingMode(self, memory);
            },
            addressingMode.zero_page => {
                operand = zeroPageAddressingMode(self, memory);
            },
            addressingMode.zero_page_x => {
                operand = zeroPageXAddressingMode(self, memory);
            },
            addressingMode.absolute => {
                operand = absoluteAddressingMode(self, memory);
            },
            addressingMode.absolute_x => {
                operand = absoluteXAddressingMode(self, memory);
            },
            addressingMode.absolute_y => {
                operand = absoluteYAddressingMode(self, memory);
            },
            addressingMode.indirect_x => {
                return CPUError.invalid_addressing_mode;
            },
            addressingMode.zero_page => {
                return CPUError.invalid_addressing_mode;
            }

        }

        self.RA &= operand;

        // Setting flags 
        self.setFlag(0b0_1_000000);

    }


};