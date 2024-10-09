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

const std = @import("std");
const cpu_mod = @import("cpu.zig").CPU;
const mem_mod = @import("memory.zig").Memory;

pub fn main() !void {
    // Creating an instance of the memory struct
    var memory = mem_mod{
        .mem_array = [0]u8 ** 65536
    }; 

    // Creating an instance of the CPU
    var cpu = cpu_mod{
        .RA = 0,
        .RP = 0,
        .RPC = 0,
        .RS = 0,
        .RX = 0,
        .RY = 0,
    }; 

    cpu.assignInstruction(&memory.mem_array);
}

test "simple test" {

}

