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
const cpu_instruction_module = @import("cpu_instructions.zig").CPU_Instruction;

// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502
// http://www.6502.org/users/obelisk/6502/instructions.html
// https://www.ahl27.com/posts/2023/01/6502-emu1/
// https://archive.org/details/mos_microcomputers_programming_manual
// http://www.6502.org/tutorials/65c02opcodes.html
// http://www.6502.org/users/obelisk/6502/reference.html

pub const CPU = struct {
    // Registers 
    RA: u8,   // Accumulator register
    RP: u8,   // Status register - Only 7 bits are used, bit 5 is always 1. 0C, 1Z, 2I, 3D, 4B, 5 Unused, 6V, 7N
    RS: u8,   // Stack Pointer 
    RX: u8,   // index register
    RY: u8,   // index register
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

    // Function to use in the array instruction index
    const instructionFn = fn(Self: *CPU, memory: *const [65536]u8, addressing_mode: *cpu_instruction_module.addressingMode) void;
    const INSTRUCTION_SET = [255]instructionFn {

        // 0x00, 
        // 0x01, 
        // 0x02, 
        // 0x03, 
        // 0x04, 
        // 0x05, 
        cpu_instruction_module.ASL, // 0x06, Zero Page
        // 0x07, 
        // 0x08, 
        // 0x09,
        cpu_instruction_module.ASL, // 0x0A, Accumulator
        // 0x0B, 
        // 0x0C, 
        // 0x0D, 
        cpu_instruction_module.ASL, // 0x0E, Absolute
        // 0x0F,
        cpu_instruction_module.BPL, // 0x10, Relative 
        // 0x11, 
        // 0x12, 
        // 0x13, 
        // 0x14, 
        // 0x15, 
        cpu_instruction_module.ASL, // 0x16, Zero Page X
        // 0x17, 
        // 0x18, 
        // 0x19,
        // 0x1A,
        // 0x1B, 
        // 0x1C, 
        // 0x1D, 
        cpu_instruction_module.ASL,  // 0x1E, Absolute X
        // 0x1F,
        // 0x20, 
        cpu_instruction_module.AND, // 0x21, Indirect X
        // 0x22, 
        // 0x23, 
        cpu_instruction_module.BIT, // 0x24, Zero Page 
        cpu_instruction_module.AND, // 0x25, Zero Page
        // 0x26, 
        // 0x27, 
        // 0x28, 
        cpu_instruction_module.AND, // 0x29, Immediate
        // 0x2A, 
        // 0x2B, 
        cpu_instruction_module.BIT, // 0x2C, Absolute 
        cpu_instruction_module.AND, // 0x2D, Absolute
        // 0x2E, 
        // 0x2F,
        cpu_instruction_module.BMI, // 0x30, Relative 
        cpu_instruction_module.AND, // 0x31, Indirect Y 
        // 0x32, 
        // 0x33, 
        // 0x34, 
        cpu_instruction_module.AND, // 0x35, Zero Page X
        // 0x36, 
        // 0x37, 
        // 0x38, 
        cpu_instruction_module.AND, // 0x39, Absolute Y
        // 0x3A, 
        // 0x3B, 
        // 0x3C, 
        cpu_instruction_module.AND, // 0x3D, Absolute X
        // 0x3E, 
        // 0x3F,
        // 0x40, 
        // 0x41, 
        // 0x42, 
        // 0x43, 
        // 0x44, 
        // 0x45, 
        // 0x46, 
        // 0x47, 
        // 0x48, 
        // 0x49,
        // 0x4A, 
        // 0x4B, 
        // 0x4C, 
        // 0x4D, 
        // 0x4E, 
        // 0x4F,
        // 0x50, 
        // 0x51, 
        // 0x52, 
        // 0x53, 
        // 0x54, 
        // 0x55, 
        // 0x56, 
        // 0x57, 
        // 0x58, 
        // 0x59,
        // 0x5A, 
        // 0x5B, 
        // 0x5C, 
        // 0x5D, 
        // 0x5E, 
        // 0x5F,
        // 0x60, 
        cpu_instruction_module.ADC, // 0x61, Indirect X ADC
        // 0x62, 
        // 0x63, 
        // 0x64, 
        cpu_instruction_module.ADC, // 0x65, Zero Page ADC 
        // 0x66, 
        // 0x67, 
        // 0x68, 
        cpu_instruction_module.ADC, // 0x69, Immediate ADC
        // 0x6A, 
        // 0x6B, 
        // 0x6C, 
        cpu_instruction_module.ADC, // 0x6D, Absolute 
        // 0x6E, 
        // 0x6F,
        // 0x70, 
        cpu_instruction_module.ADC, // 0x71, Indirect Y ADC
        // 0x72, 
        // 0x73, 
        // 0x74, 
        cpu_instruction_module.ADC, // 0x75, Zero Page X ADC
        // 0x76, 
        // 0x77, 
        // 0x78, 
        cpu_instruction_module.ADC, // 0x79, Absolute Y ADC
        // 0x7A, 
        // 0x7B, 
        // 0x7C, 
        cpu_instruction_module.ADC, // 0x7D, Absolute X ADC 
        // 0x7E, 
        // 0x7F,
        // 0x80, 
        // 0x81, 
        // 0x82, 
        // 0x83, 
        // 0x84, 
        // 0x85, 
        // 0x86, 
        // 0x87, 
        // 0x88, 
        // 0x89,
        // 0x8A, 
        // 0x8B, 
        // 0x8C, 
        // 0x8D, 
        // 0x8E, 
        // 0x8F,
        cpu_instruction_module.BCC, // 0x90, Relative 
        // 0x91, 
        // 0x92, 
        // 0x93, 
        // 0x94, 
        // 0x95, 
        // 0x96, 
        // 0x97, 
        // 0x98, 
        // 0x99,
        // 0x9A, 
        // 0x9B, 
        // 0x9C, 
        // 0x9D, 
        // 0x9E, 
        // 0x9F,
        // 0xA0, 
        // 0xA1, 
        // 0xA2, 
        // 0xA3, 
        // 0xA4, 
        // 0xA5, 
        // 0xA6, 
        // 0xA7, 
        // 0xA8, 
        // 0xA9,
        // 0xAA, 
        // 0xAB, 
        // 0xAC, 
        // 0xAD, 
        // 0xAE, 
        // 0xAF,
        cpu_instruction_module.BCS, // 0xB0, Relative
        // 0xB1, 
        // 0xB2, 
        // 0xB3, 
        // 0xB4, 
        // 0xB5, 
        // 0xB6, 
        // 0xB7, 
        // 0xB8, 
        // 0xB9,
        // 0xBA, 
        // 0xBB, 
        // 0xBC, 
        // 0xBD, 
        // 0xBE, 
        // 0xBF,
        // 0xC0, 
        // 0xC1, 
        // 0xC2, 
        // 0xC3, 
        // 0xC4, 
        // 0xC5, 
        // 0xC6, 
        // 0xC7, 
        // 0xC8, 
        // 0xC9,
        // 0xCA, 
        // 0xCB, 
        // 0xCC, 
        // 0xCD, 
        // 0xCE, 
        // 0xCF,
        cpu_instruction_module.BNE, // 0xD0, Relative 
        // 0xD1, 
        // 0xD2, 
        // 0xD3, 
        // 0xD4, 
        // 0xD5, 
        // 0xD6, 
        // 0xD7, 
        // 0xD8, 
        // 0xD9,
        // 0xDA, 
        // 0xDB, 
        // 0xDC, 
        // 0xDD, 
        // 0xDE, 
        // 0xDF,
        // 0xE0, 
        // 0xE1, 
        // 0xE2, 
        // 0xE3, 
        // 0xE4, 
        // 0xE5, 
        // 0xE6, 
        // 0xE7, 
        // 0xE8, 
        // 0xE9,
        // 0xEA, 
        // 0xEB, 
        // 0xEC, 
        // 0xED, 
        // 0xEE, 
        // 0xEF,
        cpu_instruction_module.BEQ, // 0xF0, Relative 
        // 0xF1, 
        // 0xF2, 
        // 0xF3, 
        // 0xF4, 
        // 0xF5, 
        // 0xF6, 
        // 0xF7, 
        // 0xF8, 
        // 0xF9,
        // 0xFA, 
        // 0xFB, 
        // 0xFC, 
        // 0xFD, 
        // 0xFE, 
        // 0xFF
    };

    const cpu_flags = cpu_flag_module.flagEnum;

    pub fn assignInstruction(self: *CPU, memory: *const [65536]u8) void {
        
        memory[self.RPC]; // Instructions can be multiple bytes and will need to be stored to understand the full instruction.

    }
};

