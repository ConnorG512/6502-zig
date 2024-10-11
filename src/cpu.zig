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

        cpu_instruction_module.BRK, // 0x00, Implied 
        cpu_instruction_module.ORA, // 0x01, Indirect X
        // 0x02, 
        // 0x03, 
        // 0x04, 
        cpu_instruction_module.ORA, // 0x05, Zero Page
        cpu_instruction_module.ASL, // 0x06, Zero Page
        // 0x07, 
        cpu_instruction_module.PHP,  // 0x08, Implied 
        cpu_instruction_module.ORA, // 0x09, Immediate
        cpu_instruction_module.ASL, // 0x0A, Accumulator
        // 0x0B, 
        // 0x0C, 
        cpu_instruction_module.ORA, // 0x0D, Absolute
        cpu_instruction_module.ASL, // 0x0E, Absolute
        // 0x0F,
        cpu_instruction_module.BPL, // 0x10, Relative 
        cpu_instruction_module.ORA, // 0x11, Indirect Y
        // 0x12, 
        // 0x13, 
        // 0x14, 
        cpu_instruction_module.ORA, // 0x15, Zero Page X
        cpu_instruction_module.ASL, // 0x16, Zero Page X
        // 0x17, 
        cpu_instruction_module.CLC, // 0x18, Implied 
        cpu_instruction_module.ORA, // 0x19, Absolute Y
        // 0x1A,
        // 0x1B, 
        // 0x1C, 
        cpu_instruction_module.ORA, // 0x1D, Absolute X
        cpu_instruction_module.ASL, // 0x1E, Absolute X
        // 0x1F,
        cpu_instruction_module.JSR, // 0x20, Absolute 
        cpu_instruction_module.AND, // 0x21, Indirect X
        // 0x22, 
        // 0x23, 
        cpu_instruction_module.BIT, // 0x24, Zero Page 
        cpu_instruction_module.AND, // 0x25, Zero Page
        cpu_instruction_module.ROL, // 0x26, Zero Page
        // 0x27, 
        cpu_instruction_module.PLP, // 0x28, Implied
        cpu_instruction_module.AND, // 0x29, Immediate
        cpu_instruction_module.ROL, // 0x2A, Accumulator 
        // 0x2B, 
        cpu_instruction_module.BIT, // 0x2C, Absolute 
        cpu_instruction_module.AND, // 0x2D, Absolute
        cpu_instruction_module.ROL, // 0x2E, Absolute
        // 0x2F,
        cpu_instruction_module.BMI, // 0x30, Relative 
        cpu_instruction_module.AND, // 0x31, Indirect Y 
        // 0x32, 
        // 0x33, 
        // 0x34, 
        cpu_instruction_module.AND, // 0x35, Zero Page X
        cpu_instruction_module.ROL, // 0x36, Zero Page X
        // 0x37, 
        cpu_instruction_module.SEC, // 0x38, Implied 
        cpu_instruction_module.AND, // 0x39, Absolute Y
        // 0x3A, 
        // 0x3B, 
        // 0x3C, 
        cpu_instruction_module.AND, // 0x3D, Absolute X
        cpu_instruction_module.ROL, // 0x3E, Absolute X 
        // 0x3F,
        cpu_instruction_module.RTI, // 0x40, Implied 
        cpu_instruction_module.EOR, // 0x41, Indirect X
        // 0x42, 
        // 0x43, 
        // 0x44, 
        cpu_instruction_module.EOR, // 0x45, Zero Page 
        cpu_instruction_module.LSR, // 0x46, Zero Page
        // 0x47, 
        cpu_instruction_module.PHA, // 0x48, Implied 
        cpu_instruction_module.EOR, // 0x49, Immediate
        cpu_instruction_module.LSR, // 0x4A, Accumulator
        // 0x4B, 
        cpu_instruction_module.JMP, // 0x4C, Absolute 
        cpu_instruction_module.EOR, // 0x4D, Absolute
        cpu_instruction_module.LSR, // 0x4E, Absolute
        // 0x4F,
        cpu_instruction_module.BVC, // 0x50, Relative
        cpu_instruction_module.EOR, // 0x51, Indirect Y
        // 0x52, 
        // 0x53, 
        // 0x54, 
        cpu_instruction_module.EOR, // 0x55, Zero Page X
        cpu_instruction_module.LSR, // 0x56, Zero Page X
        // 0x57, 
        cpu_instruction_module.CLI, // 0x58, Implied 
        cpu_instruction_module.EOR, // 0x59, Absolute Y
        // 0x5A, 
        // 0x5B, 
        // 0x5C, 
        cpu_instruction_module.EOR, // 0x5D, Absolute X
        cpu_instruction_module.LSR, // 0x5E, Absolute X
        // 0x5F,
        cpu_instruction_module.RTS, // 0x60, Implied 
        cpu_instruction_module.ADC, // 0x61, Indirect X ADC
        // 0x62, 
        // 0x63, 
        // 0x64, 
        cpu_instruction_module.ADC, // 0x65, Zero Page ADC 
        cpu_instruction_module.ROR, // 0x66, Zero Page
        // 0x67, 
        cpu_instruction_module.PLA, // 0x68, Implied 
        cpu_instruction_module.ADC, // 0x69, Immediate ADC
        cpu_instruction_module.ROR, // 0x6A, Accumulator 
        // 0x6B, 
        cpu_instruction_module.JMP, // 0x6C, Indirect 
        cpu_instruction_module.ADC, // 0x6D, Absolute 
        cpu_instruction_module.ROR, // 0x6E, Absolute
        // 0x6F,
        cpu_instruction_module.BVS, // 0x70, Relative 
        cpu_instruction_module.ADC, // 0x71, Indirect Y ADC
        // 0x72, 
        // 0x73, 
        // 0x74, 
        cpu_instruction_module.ADC, // 0x75, Zero Page X ADC
        cpu_instruction_module.ROR, // 0x76, Zero Page X
        // 0x77, 
        cpu_instruction_module.SEI, // 0x78, Implied
        cpu_instruction_module.ADC, // 0x79, Absolute Y ADC
        // 0x7A, 
        // 0x7B, 
        // 0x7C, 
        cpu_instruction_module.ADC, // 0x7D, Absolute X ADC 
        cpu_instruction_module.ROR, // 0x7E, Absolute X
        // 0x7F,
        // 0x80, 
        cpu_instruction_module.STA, // 0x81, Indirect X
        // 0x82, 
        // 0x83, 
        cpu_instruction_module.STY, // 0x84, Zero Page 
        cpu_instruction_module.STA, // 0x85, Zero Page 
        cpu_instruction_module.STX, // 0x86, Zero Page 
        // 0x87, 
        cpu_instruction_module.DEY, // 0x88, Implied 
        // 0x89,
        cpu_instruction_module.TXA, // 0x8A, Implied 
        // 0x8B, 
        cpu_instruction_module.STY, // 0x8C, Absolute
        cpu_instruction_module.STA, // 0x8D, Absolute
        cpu_instruction_module.STX, // 0x8E, Absolute
        // 0x8F,
        cpu_instruction_module.BCC, // 0x90, Relative 
        cpu_instruction_module.STA, // 0x91, Indirect Y
        // 0x92, 
        // 0x93, 
        cpu_instruction_module.STY, // 0x94, Zero Page X
        cpu_instruction_module.STA, // 0x95, Zero Page X
        cpu_instruction_module.STX, // 0x96, Zero Page Y
        // 0x97, 
        cpu_instruction_module.TYA, // 0x98, Implied 
        cpu_instruction_module.STA, // 0x99, Absolute Y
        cpu_instruction_module.TXS, // 0x9A, Implied 
        // 0x9B, 
        // 0x9C, 
        cpu_instruction_module.STA, // 0x9D, Absolute X 
        // 0x9E, 
        // 0x9F,
        cpu_instruction_module.LDY, // 0xA0, Immediate
        cpu_instruction_module.LDA, // 0xA1, Indirect X
        cpu_instruction_module.LDX, // 0xA2, Immediate 
        // 0xA3, 
        cpu_instruction_module.LDY, // 0xA4, Zero Page
        cpu_instruction_module.LDA, // 0xA5, Zero Page
        cpu_instruction_module.LDX, // 0xA6, Zero Page
        // 0xA7, 
        cpu_instruction_module.TAY, // 0xA8, Implied 
        cpu_instruction_module.LDA, // 0xA9, Immediate
        cpu_instruction_module.TAX, // 0xAA, Implied 
        // 0xAB, 
        cpu_instruction_module.LDY, // 0xAC, Absolute
        cpu_instruction_module.LDA, // 0xAD, Absolute
        cpu_instruction_module.LDX, // 0xAE, Absolute
        // 0xAF,
        cpu_instruction_module.BCS, // 0xB0, Relative
        cpu_instruction_module.LDA, // 0xB1, Indirect Y
        // 0xB2, 
        // 0xB3, 
        cpu_instruction_module.LDY, // 0xB4, Zero Page X
        cpu_instruction_module.LDA, // 0xB5, Zero Page X
        cpu_instruction_module.LDX, // 0xB6, Zero Page Y
        // 0xB7, 
        cpu_instruction_module.CLV, // 0xB8, Implied 
        cpu_instruction_module.LDA, // 0xB9, Absolute Y
        cpu_instruction_module.TSX, // 0xBA, Implied 
        // 0xBB, 
        cpu_instruction_module.LDY, // 0xBC, Absolute X
        cpu_instruction_module.LDA, // 0xBD, Absolute X
        cpu_instruction_module.LDX, // 0xBE, Absolute Y
        // 0xBF,
        cpu_instruction_module.CPY, // 0xC0, Immediate 
        cpu_instruction_module.CMP, // 0xC1, Indirect X
        // 0xC2, 
        // 0xC3, 
        cpu_instruction_module.CPY, // 0xC4, Zero Page 
        cpu_instruction_module.CMP, // 0xC5, Zero Page
        cpu_instruction_module.DEC, // 0xC6, Zero Page
        // 0xC7, 
        cpu_instruction_module.INY, // 0xC8, Implied 
        cpu_instruction_module.CMP, // 0xC9, Immediate
        cpu_instruction_module.DEX, // 0xCA, Implied 
        // 0xCB, 
        cpu_instruction_module.CPY, // 0xCC, Absolute
        cpu_instruction_module.CMP, // 0xCD, Absolute
        cpu_instruction_module.DEC, // 0xCE, Absolute
        // 0xCF,
        cpu_instruction_module.BNE, // 0xD0, Relative 
        cpu_instruction_module.CMP, // 0xD1, Indirect Y 
        // 0xD2, 
        // 0xD3, 
        // 0xD4, 
        cpu_instruction_module.CMP, // 0xD5, Zero Page X
        cpu_instruction_module.DEC, // 0xD6, Zero Page X
        // 0xD7, 
        cpu_instruction_module.CLD, // 0xD8, Implied 
        cpu_instruction_module.CMP, // 0xD9, Absolute Y
        // 0xDA, 
        // 0xDB, 
        // 0xDC, 
        cpu_instruction_module.CMP, // 0xDD, Absolute X
        cpu_instruction_module.DEC, // 0xDE, absolute X
        // 0xDF,
        cpu_instruction_module.CPX, // 0xE0, Immediate 
        cpu_instruction_module.SBC, // 0xE1, Indirect X
        // 0xE2, 
        // 0xE3, 
        cpu_instruction_module.CPX, // 0xE4, Zero Page
        cpu_instruction_module.SBC, // 0xE5, Zero Page
        cpu_instruction_module.INC, // 0xE6, Zero Page 
        // 0xE7, 
        cpu_instruction_module.INX, // 0xE8, Implied
        cpu_instruction_module.SBC, // 0xE9, Immediate
        cpu_instruction_module.NOP, // 0xEA, Implied  
        // 0xEB, 
        cpu_instruction_module.CPX, // 0xEC, Absolute
        cpu_instruction_module.SBC, // 0xED, Absolute
        cpu_instruction_module.INC, // 0xEE, Absolute 
        // 0xEF,
        cpu_instruction_module.BEQ, // 0xF0, Relative 
        cpu_instruction_module.SBC, // 0xF1, Indirect Y
        // 0xF2, 
        // 0xF3, 
        // 0xF4, 
        cpu_instruction_module.SBC, // 0xF5, Zero Page X
        cpu_instruction_module.INC, // 0xF6, Zero Page X
        // 0xF7, 
        cpu_instruction_module.SED, // 0xF8, Implied 
        cpu_instruction_module.SBC, // 0xF9, Absolute Y
        // 0xFA, 
        // 0xFB, 
        // 0xFC, 
        cpu_instruction_module.SBC, // 0xFD, Absolute X
        cpu_instruction_module.INC, // 0xFE, Absolute X
        // 0xFF
    };

    const cpu_flags = cpu_flag_module.flagEnum;

    pub fn assignInstruction(self: *CPU, memory: *const [65536]u8) void {
        
        memory[self.RPC]; // Instructions can be multiple bytes and will need to be stored to understand the full instruction.

    }
};

