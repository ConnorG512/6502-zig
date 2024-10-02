// CPU Info
// https://en.wikipedia.org/wiki/MOS_Technology_6502

const CPU = struct {
    // Registers 
    A: u8, // Accumulator register
    P: u8, // Status register - Only 7 bits are used, bit 5 is always 1
    PC: u16, // Program counter
    S: u8, // Stack Pointer 
    X: u8, // index register
    Y: u8, // index register
};