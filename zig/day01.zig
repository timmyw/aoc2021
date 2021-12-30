const std = @import("std");
const io = @import("std").io;
const utils = @import("./utils.zig");

fn get_up_and_down(ls: std.ArrayListAligned(u16, null)) void {
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
    std.debug.print("Up:{d} Down:{d}\n", .{ up, down });
}

pub fn main() !void {
    std.debug.print("Day 01\n", .{});

    var ls = try utils.read_file_u32("day01-input.txt");
    get_up_and_down(ls);

    var group3 = std.ArrayList(u16).init(std.heap.page_allocator);
    for (ls.items) |d, i| {
        if (i < ls.items.len - 2) {
            var s = d + ls.items[i + 1] + ls.items[i + 2];
            try group3.append(s);
        }
    }
    get_up_and_down(group3);
}
