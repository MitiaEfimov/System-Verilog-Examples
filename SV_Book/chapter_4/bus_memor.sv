// Для создания экземпляра

// try [DW:0] dataline;
// bus_memor b (.data(dataline), .we(we), ...);
// assign dataline = (we) ? "Value_to_write" : 1'bz;


module bus_memor
    #(parameter
        DW = 8,
        W = 256,
        AW = $clog2(W))
    (input bit [AW-1:0] addr,
    input bit re, we, clk,
    inout tri [DW-1:0] data);

    bit [DW-1:0] m [W];

    assign data = (re) ? m[addr] : 'bz;

    always_ff @(posedge clk)
        if (we) m[addr] <= data;
endmodule