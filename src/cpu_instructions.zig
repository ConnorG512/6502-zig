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

// http://www.6502.org/users/obelisk/6502/instructions.html
// http://www.6502.org/users/obelisk/6502/reference.html#LDA

const logging = @import("logging.zig");
const CPU = @import("cpu.zig");

pub const CPU_Instruction = struct {

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
        implied 
    };

    ///////////////////////////////////////
    // Load / Store Operations
    ///////////////////////////////////////
    
    pub fn LDA() void {
        logging.infoLog("cpu_instructions: LDA Called!");
    }

    pub fn LDX() void {
        logging.infoLog("cpu_instructions: LDX Called!");
    }

    pub fn LDY() void {
        logging.infoLog("cpu_instructions: LDY Called!");
    }

    pub fn STA() void {
        logging.infoLog("cpu_instructions: STA Called!");
    }

    pub fn STX() void {
        logging.infoLog("cpu_instructions: STX Called!");
    }

    pub fn STY() void {
        logging.infoLog("cpu_instructions: STY Called!");
    }

    ///////////////////////////////////////
    // Register transfers
    ///////////////////////////////////////
    
    pub fn TAX() void {
        logging.infoLog("cpu_instructions: TAX Called!");
    }

    pub fn TAY() void {
        logging.infoLog("cpu_instructions: TAY Called!");
    }

    pub fn TXA() void {
        logging.infoLog("cpu_instructions: TXA Called!");
    }

    pub fn TYA() void {
        logging.infoLog("cpu_instructions: TYA Called!");
    }

    ///////////////////////////////////////
    // Stack Operations
    ///////////////////////////////////////

    pub fn TSX() void {
        logging.infoLog("cpu_instructions: TSX Called!");
    }

    pub fn TXS() void {
        logging.infoLog("cpu_instructions: TXS Called!");
    }

    pub fn PHA() void {
        logging.infoLog("cpu_instructions: PHA Called!");
    }

    pub fn PHP() void {
        logging.infoLog("cpu_instructions: PHP Called!");
    }

    pub fn PLA() void {
        logging.infoLog("cpu_instructions: PLA Called!");
    }

    pub fn PLP() void {
        logging.infoLog("cpu_instructions: PLP Called!");
    }

    ///////////////////////////////////////
    // Logical
    ///////////////////////////////////////
     
    pub fn AND() void {
        logging.infoLog("cpu_instructions: AND Called!");
    }

    pub fn EOR() void {
        logging.infoLog("cpu_instructions: EOR Called!");
    }

    pub fn ORA() void {
        logging.infoLog("cpu_instructions: ORA Called!");
    }

    pub fn BIT() void {
        logging.infoLog("cpu_instructions: BIT Called!");
    } 
    
    ///////////////////////////////////////
    // Arithmetic
    ///////////////////////////////////////

    pub fn ADC() void {
        logging.infoLog("cpu_instructions: ADC Called!");
    } 

    pub fn SBC() void {
        logging.infoLog("cpu_instructions: SBC Called!");
    } 

    pub fn CMP() void {
        logging.infoLog("cpu_instructions: CMP Called!");
    } 

    pub fn CPX() void {
        logging.infoLog("cpu_instructions: CPX Called!");
    } 

    pub fn CPY() void {
        logging.infoLog("cpu_instructions: CPY Called!");
    } 

    ///////////////////////////////////////
    // Increments & Decrements
    ///////////////////////////////////////

    pub fn INC() void {
        logging.infoLog("cpu_instructions: INC Called!");
    } 

    pub fn INX() void {
        logging.infoLog("cpu_instructions: INX Called!");
    } 

    pub fn INY() void {
        logging.infoLog("cpu_instructions: INY Called!");
    } 

    pub fn DEC() void {
        logging.infoLog("cpu_instructions: DEC Called!");
    } 

    pub fn DEX() void {
        logging.infoLog("cpu_instructions: DEX Called!");
    } 

    pub fn DEY() void {
        logging.infoLog("cpu_instructions: DEY Called!");
    } 

    ///////////////////////////////////////
    // Shifts
    ///////////////////////////////////////

    pub fn ASL() void {
        logging.infoLog("cpu_instructions: ASL Called!");
    } 
    
    pub fn LSR() void {
        logging.infoLog("cpu_instructions: LSR Called!");
    }

    pub fn ROL() void {
        logging.infoLog("cpu_instructions: ROL Called!");
    } 

    pub fn ROR() void {
        logging.infoLog("cpu_instructions: ROR Called!");
    }  

    ///////////////////////////////////////
    // Jumps & Calls
    ///////////////////////////////////////

    pub fn JMP() void {
        logging.infoLog("cpu_instructions: JMP Called!");
    } 

    pub fn JSR() void {
        logging.infoLog("cpu_instructions: JSR Called!");
    } 

    pub fn RTS() void {
        logging.infoLog("cpu_instructions: RTS Called!");
    } 

    ///////////////////////////////////////
    // Branches
    ///////////////////////////////////////

    pub fn BCC() void {
        logging.infoLog("cpu_instructions: BCC Called!");
    } 

    pub fn BCS() void {
        logging.infoLog("cpu_instructions: BCS Called!");
    } 

    pub fn BEQ() void {
        logging.infoLog("cpu_instructions: BEQ Called!");
    } 

    pub fn BMI() void {
        logging.infoLog("cpu_instructions: BMI Called!");
    } 

    pub fn BNE() void {
        logging.infoLog("cpu_instructions: BNE Called!");
    } 

    pub fn BPL() void {
        logging.infoLog("cpu_instructions: BPL Called!");
    } 

    pub fn BVC() void {
        logging.infoLog("cpu_instructions: BVC Called!");
    } 

    pub fn BVS() void {
        logging.infoLog("cpu_instructions: BVS Called!");
    } 

    ///////////////////////////////////////
    // Status Flag Changes
    ///////////////////////////////////////

    pub fn CLC() void {
        logging.infoLog("cpu_instructions: CLC Called!");
    } 

    pub fn CLD() void {
        logging.infoLog("cpu_instructions: CLD Called!");
    } 

    pub fn CLI() void {
        logging.infoLog("cpu_instructions: CLI Called!");
    } 

    pub fn CLV() void {
        logging.infoLog("cpu_instructions: CLV Called!");
    } 

    pub fn SEC() void {
        logging.infoLog("cpu_instructions: SEC Called!");
    } 

    pub fn SED() void {
        logging.infoLog("cpu_instructions: SED Called!");
    } 

    pub fn SEI() void {
        logging.infoLog("cpu_instructions: SEI Called!");
    } 

    ///////////////////////////////////////
    // System Functions
    ///////////////////////////////////////
    
    pub fn BRK() void {
        logging.infoLog("cpu_instructions: BRK Called!");
    } 

    pub fn NOP() void {
        logging.infoLog("cpu_instructions: NOP Called!");
    } 

    pub fn RTI() void {
        logging.infoLog("cpu_instructions: RTI Called!");
    } 

    ///////////////////////////////////////
    // ADDRESSING MODES
    ///////////////////////////////////////
    
    // Not to be called from outide the module. Only called internally.

    fn accumulatorAddressingMode() u16 {

    }

    fn immediateAddressingMode(self: *CPU, memory: *const []u8) u8 {
        const operand: u8 = memory.readByte(self.RPC + 1); // Dereferencing the value in the array 
        self.RPC += 2; // Move the program counter forward by 2 bytes to vover the opcode and the operand
        logging.infoLog("cpu_instructions: immediate addressing mode finished!");
        return operand;
    }

    fn zeroPageAddressingMode(self: *CPU, memory: *const []u8) u16 {
        const address: u16 = memory.readByte(self.RPC); // Read address from counter
        const value: u8 = memory.readByte(address); // Read value from zero page address
        self.RPC += 1; // Increment program counter by 1, zero-page only uses 1 byte
        logging.infoLog("cpu_instructions: zero page addressing mode finished!");
        return value; 
    }

    fn zeroPageXAddressingMode(self: *CPU, memory: *const []u8) u16 {
        const base_address: u8 = memory.readByte(self.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + self.RX) & 0xFF; // Adding and wrapping X to 8 bits
        logging.infoLog("cpu_instructions: zero page x addressing mode finished!");
        return address;
    }

    fn zeroPageYAddressingMode(self: *CPU, memory: *const []u8) u16 {
        const base_address: u8 = memory.readByte(self.RPC + 1); // Fetch a Zero Page address
        const address: u16 = (base_address + self.RY) & 0xFF; // Adding and wrapping X to 8 bits
        logging.infoLog("cpu_instructions: zero page y addressing mode finished!");
        return address;
    }

    fn relativeAddressingMode(self: *CPU, memory: *const []u8) u16 {
        // Getting the relative offset from the bute that is relative to the operand. 
        const offset: i8 = i8(memory.readByte((self.RPC + 1))); // casting as an signed 8 bit integer
        const new_address: u16 = u16(self.RPC + 2) + u16(offset);
        logging.infoLog("cpu_instructions: relative addressing mode finished!");
        return new_address; // return the calculated address
    }
    
    fn absoluteAddressingMode(self: *CPU, memory: *const []u8) u16 {
        // Instructions using absolute addressing contain a full 16 bit address to identify the target location.
        const low_byte: u8 = memory.readByte(self.RPC + 1); // Fetching the low byte
        const high_byte: u8 = memory.readByte(self.RPC + 2); // Fetching the high byte
        self.RPC += 3; // Moving the program counter 3 spaces forward
        const result: u16 = (high_byte << 8 | low_byte);
        logging.infoLog("cpu_instructions: absolute addressing mode finished!");
        return result;
    }

    fn absoluteXAddressingMode(self: *CPU, memory: *const []u8) u16 {
        const base_address: u16 = memory.readWord(self.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + self.RY; // Add Y Register
        logging.infoLog("cpu_instructions: absolute x addressing mode finished!");
        return address;
    }

    fn absoluteYAddressingMode(self: *CPU, memory: *const []u8) u16 {
        const base_address: u16 = memory.readWord(self.RPC + 1); // Fetching the absolute address
        const address: u16 = base_address + self.RX; // Add X Register
        logging.infoLog("cpu_instructions: absolute y addressing mode finished!");
        return address;
    }

    fn indirectAddressingMode() u16 {
    }

    fn indexedIndirectAddressingMode() u16 {
    }

    fn indirectIndexedAddressingMode() u16 {
    }
};