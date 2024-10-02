const std = @import("std");
// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502
// http://www.6502.org/users/obelisk/6502/instructions.html
// https://www.ahl27.com/posts/2023/01/6502-emu1/
// https://archive.org/details/mos_microcomputers_programming_manual

const CPU = struct {
    // Registers 
    RA: u8, // Accumulator register
    RP: u8, // Status register - Only 7 bits are used, bit 5 is always 1
    RPC: u16, // Program counter
    RS: u8, // Stack Pointer 
    RX: u8, // index register
    RY: u8, // index register

    pub fn readMemory() !void {

    }

};