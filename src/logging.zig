const std = @import("std");


 // ANSI escape codes for colours
const reset = "\x1b[0m"; // Reset to default color
const red = "\x1b[31m";   // Red text
const yellow = "\x1b[33m";   // Yellow text
   
pub fn infoLog(message: []const u8) void {
    std.debug.print("ERROR: {}\n", .{message});
}
pub fn infoValueLog(message: []const u8, value: *u64) void {
    std.debug.print("Info Log: {}, Address: {p}\n", .{message, value});
}
pub fn errorLog(message: []const u8) void {
    std.debug.print("{}ERROR: {}\n", .{red, message});
}
pub fn warnLog(message: []const u8) void {
    std.debug.print("{}ERROR: {}\n", .{yellow, message});
}