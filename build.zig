const std = @import("std");

pub fn build(b: *std.Build) !void {
    const t = b.standardTargetOptions(.{
        
    });
    const server = b.addExecutable(.{
        .name = "server",
        .target = t,
        .root_source_file = .{ .path = "src/server.zig" }
    } );
    const client = b.addExecutable(.{
        .name = "client",
        .target = t,
        .root_source_file = .{ .path = "src/client.zig" }
    });

    server.linkLibC();
    client.linkLibC();

    server.linkLibCpp();
    client.linkLibCpp();

    server.addCSourceFiles(&.{
        "src/server/main.cpp"
    }, &.{
        "-std=c++20"
    });
    client.addCSourceFiles(&.{
        "src/client/main.cpp"
    }, &.{
        "-std=c++20"
    });

    server.addIncludePath(.{ .path = "src/server" });
    server.addIncludePath(.{ .path = "src/common" });
    client.addIncludePath(.{ .path = "src/client" });
    client.addIncludePath(.{ .path = "src/common" });

    server.out_filename = "server";
    client.out_filename = "client";

    // b.default_step.dependOn(&server.step);

    b.installArtifact(server);
    b.installArtifact(client);


    
}