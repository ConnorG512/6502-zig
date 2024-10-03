const std = @import("std");
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
            std.debug.print("Error, Byte is null!", .{});
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
        var operand: u8 = 0;
        
        switch (mode) {
            addressingMode.immediate => {
                operand = memory[self.RPC + 1].*; // Dereferencing the value in the array 
                self.RPC += 2; // Move the program counter forward by 2 bytes to vover the opcode and the operand
            },
            addressingMode.zero_page => {
                return CPUError.unimplemented_op_code;
            },
            addressingMode.zero_page_x => {
                return CPUError.unimplemented_op_code;
            },
            addressingMode.absolute => {
                return CPUError.unimplemented_op_code;
            },
            addressingMode.absolute_x => {
                return CPUError.unimplemented_op_code;
            },
            addressingMode.absolute_y => {
                return CPUError.unimplemented_op_code;
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
            
    }

    // Set flags for functions
    // flag 5 is unused in 6502 and will always be set to the value of 1
    fn setAllFlags(self: *CPU) !void {
        if (self == null) {
            return CPUError.null_cpu_ref;
        }
        
        self.RP = 0b1_1_1_1_1_1_1_1;
    }

    fn setFlag(self: *CPU, flag:u8) !void {
        if (self == null) {
            return CPUError.null_cpu_ref;
        }

        // bitwise or (|) operation to set the respective bits to 1
        self.RP |= flag;
    }
    
    fn clearFlag(self: *CPU, flag:u8) !void {
        if (self == null) {
            return CPUError.null_cpu_ref;
        }

        // bitwise and (&) not (~) operation to set the respective bits to 0
        self.RP &= ~flag;
    }

    fn clearAllFlags (self: *CPU) !void {
        if (self == null) {
            return CPUError.null_cpu_ref;
        }

        self.RP = 0b0_0_0_0_1_0_0_0;
    }
};