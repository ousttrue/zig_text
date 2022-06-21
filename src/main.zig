const std = @import("std");
const c = @import("./c.zig");
const libuv = c.libuv;

var counter: i64 = 0;

fn wait_for_a_while(handle: [*c]libuv.uv_idle_t) callconv(.C) void {
    counter += 1;

    if (counter >= 10e6) {
        _ = libuv.uv_idle_stop(handle);
    }
}

pub fn main() anyerror!void {
    var idler: libuv.uv_idle_t = undefined;

    _ = libuv.uv_idle_init(libuv.uv_default_loop(), &idler);
    _ = libuv.uv_idle_start(&idler, wait_for_a_while);

    std.debug.print("Idling...\n", .{});
    _ = libuv.uv_run(libuv.uv_default_loop(), libuv.UV_RUN_DEFAULT);

    _ = libuv.uv_loop_close(libuv.uv_default_loop());
}
