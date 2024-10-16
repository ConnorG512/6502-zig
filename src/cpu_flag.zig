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

pub const CPU_flag = struct {

    const CPUFlagError = error {
        flagNull,
    };
    
    // flags are represented from right to left.
    // right most side = 0, left most sife 7.
    pub const flagEnum = enum {
        carry_f,        // bit 0
        zero_f,         // bit 1
        interrupt_f,    // bit 2
        decimal_f,      // bit 3
        break_f,        // bit 4 
        unused_f,       // bit 5
        overflow_f,     // bit 6
        negative_f,     // bit 7
    };

    pub fn setAllFlags(flag_register: *u8) !void  {
        if (flag_register == null) {
            return CPUFlagError.flagNull;
        }

        flag_register = 0b1_1_1_1_1_1_1_1; // Setting all flags to 1
    }

    pub fn clearAllFlags(flag_register: *u8) !void {
        if (flag_register == null) {
            return CPUFlagError.flagNull;
        }

        flag_register = 0b0_0_0_1_0_0_0_0; // Set all flags to 0 except bit 5 which is unused
    }
    
    pub fn clearFlag(flag: flagEnum, flag_register: *u8) void {
       
        switch (flag) {

            // The pointer inside of the struct needs to be dereferenced with .*
            flagEnum.carry_f => {
                flag_register.* &= ~0b0_0_0_0_0_0_0_1; // bit 0
            },
            flagEnum.zero_f => {
                flag_register.* &= ~0b0_0_0_0_0_0_1_0; // bit 1
            },
            flagEnum.interrupt_f => {
                flag_register.* &= ~0b0_0_0_0_0_1_0_0; // bit 2
            },
            flagEnum.decimal_f => {
                flag_register.* &= ~0b0_0_0_0_1_0_0_0; // bit 3
            },
            flagEnum.break_f => {
                flag_register.* &= ~0b0_0_0_1_0_0_0_0; // bit 4
            },
            flagEnum.unused_f => {
                logging.infoLog("cpu_flag: Unused flag triggered!\n");
            },
            flagEnum.overflow_f => {
                flag_register.* &= ~0b0_1_0_0_0_0_0_0; // bit 6
            },
            flagEnum.negative_f => {
                flag_register.* &= ~0b1_0_0_0_0_0_0_0; // bit 7
            },
        }
    }

    pub fn setFlag(flag: flagEnum, flag_register: *u8) void {
        
        switch (flag) {

            // The pointer needs to be dereferenced with .* when passed in
            flagEnum.carry_f => {
                flag_register.* |= 0b0_0_0_0_0_0_0_1; // bit 0
            },
            flagEnum.zero_f => {
                flag_register.* |= 0b0_0_0_0_0_0_1_0; // bit 1
            },
            flagEnum.interrupt_f => {
                flag_register.* |= 0b0_0_0_0_0_1_0_0; // bit 2
            },
            flagEnum.decimal_f => {
                flag_register.* |= 0b0_0_0_0_1_0_0_0; // bit 3
            },
            flagEnum.break_f => {
                flag_register.* |= 0b0_0_0_1_0_0_0_0; // bit 4
            },
            flagEnum.unused_f => {
                logging.infoLog("cpu_flag: Unused flag triggered!\n");
            },
            flagEnum.overflow_f => {
                flag_register.* |= 0b0_1_0_0_0_0_0_0; // bit 6
            },
            flagEnum.negative_f => {
                flag_register.* |= 0b1_0_0_0_0_0_0_0; // bit 7
            },
        
        }
    }
};
