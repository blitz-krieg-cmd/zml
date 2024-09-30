const std = @import("std");

pub fn Transpose(in: [][]f16) [][]f16 {
    var result: [][]f16 = undefined;
    inline for (in) |row| {
        inline for (row) |col| {
            result[row][col] = in[col][row];
        }
    }
    return result;
}

pub fn Zeros(x: usize, y: usize) [][]f16 {
    return [x][y]f16{0} ** x * y;
}

pub fn Forward(inputs: [][]f16, weights: [][]f16, biases: [][]f16) void {}

pub const LayerDense = struct {
    weights: [][]f16,
    biases: [][]f16,
    output: [][]f16,

    pub fn Init(self: LayerDense, inputs: usize, neurons: usize) void {
        self.weights = Zeros(inputs, neurons);
        self.biases = Zeros(1, neurons);
    }

    pub fn Forward(self: LayerDense, inputs: [][]f16) void {
        self.output = Dot(inputs, self.weights, self.biases);
    }
};

pub fn main() !void {
    const layer1 = LayerDense.Init(4, 5);
    layer1.Forward([_][]f16{
        .{ 0.2, 0.8, -0.5, 1.0 },
        .{ 0.5, -0.91, 0.26, -0.5 },
        .{ -0.26, -0.27, 0.17, 0.87 },
    });

    const layer2 = LayerDense.Init(5, 2);
    layer2.Forward(layer1.output);

    std.log.info("{any}", .{layer2.output});
}
