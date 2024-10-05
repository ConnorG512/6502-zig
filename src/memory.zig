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

// All addresses in the CPU emulation are 16 bits wide / u16
// The memory in the 6502 CPU is in little endian, this means that that the least 
// siginificant or low byte comes first in memory.

@const logging = @import("logging.zig");

pub const Memory = struct {
    mem_array: [0x10000]u8, // 64KB of total memory
    

    pub fn readByte(self: *Memory, address: u16) u8 {
        // Passes the address to read  and returns the byte in memory.
        return self.mem_array[address];
    }

    pub fn writeByte(self: *Memory, address: u16, value: u8) void {
        // write a value into an address
        self.mem_array[address] = value;
    }

    pub fn readWord(self: *Memory, address: u16) u16 {
        // Write 2 bytes into an address space
        const low_byte = self.readByte(address);
        const high_byte = self.readByte(address + 1);
        // Moving high_byte forward to make space for the low_byte and add together.
        return (high_byte << 8) | low_byte; 
    }

    pub fn writeWord(self: *Memory, address: u16, value: u16) void {
        const low_byte = u8(value); // converts the u16 address into a u8
        const high_byte = u8(value >> 8); // bit shifts to the right
        self.writeByte(address, low_byte);
        self.writeByte(address + 1, high_byte);
    }
}; 