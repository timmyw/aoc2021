const std = @import("std");
const io = @import("std").io;

fn read_file(filename: []const u8) !std.ArrayListAligned([]const u8, null) {
    var lines = std.ArrayList([]const u8).init(std.heap.page_allocator);

    var file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();
    var buf_reader = io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var line_copy = line;
        try lines.append(line_copy);
    }

    return lines;
}

fn read_file_u32(filename: []const u8) !std.ArrayListAligned(u16, null) {
    var lines = std.ArrayList(u16).init(std.heap.page_allocator);

    var file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();
    var buf_reader = io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var i = try std.fmt.parseInt(u16, line, 10);
        try lines.append(i);
    }

    return lines;
}

pub fn main() !void {
    std.debug.print("Day 01\n", .{});

    var ls = try read_file_u32("day01-input.txt");
    var last: u16 = undefined;
    var up: u16 = 0;
    var down: u16 = 0;

    for (ls.items) |depth, i| {
        if (i > 0) {
            if (depth > last) up += 1;
            if (depth < last) down += 1;
        }
        last = depth;
    }

    std.debug.print("Up:{d} Down:{d}\n", .{up, down});
}
