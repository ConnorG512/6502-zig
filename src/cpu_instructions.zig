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
    
    pub fn TAX() {
        logging.infoLog("cpu_instructions: TAX Called!");
    }

    pub fn TAY() {
        logging.infoLog("cpu_instructions: TAY Called!");
    }

    pub fn TXA() {
        logging.infoLog("cpu_instructions: TXA Called!");
    }

    pub fn TYA() {
        logging.infoLog("cpu_instructions: TYA Called!");
    }
    
    ///////////////////////////////////////
    // Stack Operations
    ///////////////////////////////////////

    ///////////////////////////////////////
    // Logical
    ///////////////////////////////////////

    ///////////////////////////////////////
    // Arithmetic
    ///////////////////////////////////////

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