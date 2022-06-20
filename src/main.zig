const std = @import("std");
const libuv = @import("libuv");

pub fn main() anyerror!void {

    const allocator= std.testing.allocator;

    const size = libuv.getSizeOfUvLoopT();
    std.debug.print("size of uv_loop_t = {}\n", .{size});

    const p = try allocator.alloc(u8, size);
    defer allocator.free(p);

    const loop = @ptrCast(*anyopaque, p);

    _ = libuv.uv_loop_init(loop);
    defer _ = libuv.uv_loop_close(loop);

    std.debug.print("Now quitting.\n", .{});
    _ = libuv.uv_run(loop, .UV_RUN_DEFAULT);
}
