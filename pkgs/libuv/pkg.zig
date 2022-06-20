const std = @import("std");
const Pkg = std.build.Pkg;
const LibExeObjStep = std.build.LibExeObjStep;

fn concat(comptime dir: anytype, comptime file: anytype) [dir.len + file.len] u8
{
    var buffer: [dir.len + file.len] u8 = undefined;
    @memcpy(&buffer, dir, dir.len);
    @memcpy((&buffer)[dir.len..], file, file.len);
    return buffer;
}

pub fn addTo(exe: *LibExeObjStep, comptime path: anytype) Pkg
{
    _ = exe;
    const pkg = Pkg{
        .name = "libuv",
        .path = .{
            .path = &concat(path, "src/main.zig"),
        }
    };
    exe.addPackage(pkg);

    exe.addIncludeDir(&concat(path, "deps/libuv/include"));
    exe.addCSourceFiles(&.{&concat(path, "src/wrap.cpp")}, &.{});
    return pkg;
}
