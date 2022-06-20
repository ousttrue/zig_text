pub extern "C" fn getSizeOfUvLoopT() usize;

pub const uv_run_mode = enum(u32) {
  UV_RUN_DEFAULT = 0,
  UV_RUN_ONCE,
  UV_RUN_NOWAIT
} ;

pub const uv_loop_t = anyopaque;
pub extern "C" fn uv_loop_init(loop: *uv_loop_t) i32;
pub extern "C" fn uv_loop_close(loop: *uv_loop_t) i32;
pub extern "C" fn uv_run(loop: *uv_loop_t, mode: uv_run_mode) i32;
