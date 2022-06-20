const std = @import("std");
const libuv = @import("libuv");

pub fn main() anyerror!void {

    const allocator= std.testing.allocator;

    const size = libuv.getSizeOfUvLoopT();
    std.debug.print("size of uv_loop_t = {}", .{size});

    const p = try allocator.alloc(u8, size);
    defer allocator.free(p);

}
