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
    const INSTRUCTION_SET = [255]instructionFn;

    const cpu_flags = cpu_flag_module.flagEnum;

    pub fn assignInstruction(self: *CPU, memory: *const [65536]u8) void {
        
        const instruction = memory[self.RPC]; // Instructions can be multiple bytes and will need to be stored to understand the full instruction.

    }
};

