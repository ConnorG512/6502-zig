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

const logging = @import("logging.zig");

pub const CPU_Instruction = struct {

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

};