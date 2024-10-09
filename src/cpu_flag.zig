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

const CPU_flag = struct {

    const CPUFlagError = error {
        flagNull,
    };
    
    // flags are represented from right to left.
    // right most side = 0, left most sife 7.
    const flagEnum = enum {
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
            logging.errorLog("setAllFlags: Error, CPU flag is null!");
            return CPUFlagError.flagNull;
        }

        flag_register = 0b1_1_1_1_1_1_1_1; // Setting all flags to 1
    }

    pub fn clearAllFlags(flag_register: *u8) !void {
        if (flag_register == null) {
            logging.errorLog("setAllFlags: Error, CPU flag is null!");
            return CPUFlagError.flagNull;
        }

        flag_register = 0b0_0_0_1_0_0_0_0; // Set all flags to 0 except bit 5 which is unused
    }

    pub fn clearFlag(flag: flagEnum, flag_register: *u8) !void {
        if (flag_register == null) {
            logging.errorLog("clearAllFlags: Error, CPU flag is null!");
            return CPUFlagError.flagNull; 
        }

        switch (flag) {
            flagEnum.carry_f => {

            },
            flagEnum.zero_f => {

            },
            flagEnum.interrupt_f => {

            },
            flagEnum.decimal_f => {

            },
            flagEnum.break_f => {

            },
            flagEnum.overflow_f => {

            },
            flagEnum.negative_f => {

            },
        }
    }

    pub fn setFlag(flag: flagEnum, flag_register: *u8) !void {
        if (flag_register == null) {
            logging.errorLog("setFlag: Error, CPU flag is null!");
            return CPUFlagError.flagNull;
        }

        switch (flag) {
            flagEnum.carry_f => {

            },
            flagEnum.zero_f => {

            },
            flagEnum.interrupt_f => {

            },
            flagEnum.decimal_f => {

            },
            flagEnum.break_f => {

            },
            flagEnum.overflow_f => {

            },
            flagEnum.negative_f => {

            },
        
        }
    }
};