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

 // ANSI escape codes for colours
const reset = "\x1b[0m"; // Reset to default color
const red = "\x1b[31m";   // Red text
const yellow = "\x1b[33m";   // Yellow text
   
pub fn infoLog(message: []const u8) void {
    std.debug.print("INFO: {s}\n", .{message});
}
pub fn infoPointerLog(message: []const u8, address: *u64) void {
    std.debug.print("INFO Log: {s}, Address: {p}\n", .{message, address});
}
pub fn infoDecValueLog(message: []const u8, value: u16) void {
    std.debug.print("INFO Log: {s}, Address: {d}\n", .{message, value});
}
pub fn errorLog(message: []const u8) void {
    std.debug.print("{}ERROR: {s}\n", .{red, message});
}
pub fn warnLog(message: []const u8) void {
    std.debug.print("{}WARN: {s}\n", .{yellow, message});
}