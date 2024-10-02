// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502

const CPU = struct {
    // Registers 
    RA: u8, // Accumulator register
    RP: u8, // Status register - Only 7 bits are used, bit 5 is always 1
    RPC: u16, // Program counter
    RS: u8, // Stack Pointer 
    RX: u8, // index register
    RY: u8, // index register
};