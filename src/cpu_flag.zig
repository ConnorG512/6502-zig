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

const cpu_flag = struct {
    const cpuFlag = enum {
        carry_f,
        zero_f,
        interrupt_f,
        decimal_f,
        break_f,
        unused_f,
        overflow_f,
        negative_f,
    };

    // Set flags for functions
    // flag 5 is unused in 6502 and will always be set to the value of 1
    fn setAllFlags() !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in setAllFlags() !");
            return CPUError.null_cpu_ref;
        }
        
        self.RP = 0b1_1_1_1_1_1_1_1;
    }

    fn setFlag(self: *CPU) !void {

        if (self == null) {
            logging.errorLog("Error: CPU null reference in setFlag() !");
            return CPUError.null_cpu_ref;
        }

        switch (self.cpuFlag) {
            cpuflag.carry_f => {

            } 

        }
    }
    
    fn clearAllFlags (self: *CPU) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in clearAllFlags() !");
            return CPUError.null_cpu_ref;
        }

        self.RP = 0b0_0_0_1_0_0_0_0;
    }

    fn clearFlag(self: *CPU, flag:u8) !void {
        if (self == null) {
            logging.errorLog("Error: CPU null reference in clearFlag() !");
            return CPUError.null_cpu_ref;
        }
        
        if (flag > 0b1_1_1_1_1_1_1_1) {
            logging.errorLog("Error: Flag overflow in clearFlag() !");
            return CPUError.cpu_flag_overflow;
        }

        // bitwise and (&) not (~) operation to set the respective bits to 0
        self.RP &= ~flag;
    }
};