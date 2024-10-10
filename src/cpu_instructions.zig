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

    ///////////////////////////////////////
    // Shifts
    ///////////////////////////////////////

    ///////////////////////////////////////
    // Jumps & Calls
    ///////////////////////////////////////

    ///////////////////////////////////////
    // Branches
    ///////////////////////////////////////

    ///////////////////////////////////////
    // Status Flag Changes
    ///////////////////////////////////////

    ///////////////////////////////////////
    // System Functions
    ///////////////////////////////////////

};