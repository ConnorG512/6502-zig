const std = @import("std");
// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502
// http://www.6502.org/users/obelisk/6502/instructions.html
// https://www.ahl27.com/posts/2023/01/6502-emu1/
// https://archive.org/details/mos_microcomputers_programming_manual
// http://www.6502.org/tutorials/65c02opcodes.html
// http://www.6502.org/users/obelisk/6502/reference.html#BRK

const CPUError = error {
    nullByte,
    unimplementedAddressPipe,
    unimplementedOpCode,
    invalidAddressingMode,
    invalidOpCode,
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
        Accumulator,
        Immediate, 
        zeroPage, 
        zeroPageX,
        zeroPageY,
        relative, 
        absolute, 
        AbsoluteX, 
        AbsoluteY, 
        Indirect,
        IndirectX, 
        IndirectY,
        Implied };

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
            addressingMode.Immediate => {
                operand = memory[self.RPC + 1].*; // Dereferencing the value in the array 
                
            },
            addressingMode.zeroPage => {
                return CPUError.unimplementedOpCode;
            },
            addressingMode.zeroPageX => {
                return CPUError.unimplementedOpCode;
            },
            addressingMode.absolute => {
                return CPUError.unimplementedOpCode;
            },
            addressingMode.AbsoluteX => {
                return CPUError.unimplementedOpCode;
            },
            addressingMode.AbsoluteY => {
                return CPUError.unimplementedOpCode;
            },
            addressingMode.IndirectX => {
                return CPUError.unimplementedOpCode;
            },
            addressingMode.IndirectY => {
                return CPUError.unimplementedOpCode;
            },
            _ => {
                return CPUError.invalidOpCode;
            },
        }
    }

};