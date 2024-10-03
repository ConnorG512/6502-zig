const std = @import("std");

const logging = struct {
    // ANSI escape codes for colours
    const reset = "\x1b[0m"; // Reset to default color
    const red = "\x1b[31m";   // Red text
    const yellow = "\x1b[33m";   // Yellow text
    
    pub fn infoLog(message: []const u8) void {
        std.debug.print("ERROR: {}", .{message});
    }
    pub fn errorLog(message: []const u8) void {
        std.debug.print("{}ERROR: {}", .{red, message});
    }
    pub fn warnLog(message: []const u8) void {
        std.debug.print("{}ERROR: {}", .{yellow, message});
    }
};