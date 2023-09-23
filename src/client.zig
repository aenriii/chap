pub const main = @cImport({
    @cInclude("c.h");
}).main;