const std = @import("std");
const warn = std.debug.warn;

test "Hello, world" {
    if (true) {
        warn("Hello, world!\n", .{});
    }
}
