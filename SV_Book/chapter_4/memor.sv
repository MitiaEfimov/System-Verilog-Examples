module memor
    #(parameter 
        Dwidth = 8,
        Words = 256,
        Awidth = $clog2(Words))
    (input bit [Dwidth-1:0] dataIn,
    input bit [Awidth-1:0] address,
    input bit clock, wEnable,
    output bit [Dwidth-1:0] dataOut);

    bit [Dwidth-1:0] m [Words];

    assign dataOut = m[address];
    always_ff @(posedge clock)
        if (wEnable) m[address] <= dataIn;
endmodule