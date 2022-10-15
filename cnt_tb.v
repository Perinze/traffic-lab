`timescale 1s/1ms
module cnt_tb;

wire [6:0] cnt;
wire [1:0] state;
reg clk;
reg rst_n;

cnt #(7) c0 (cnt, state, clk, rst_n);
    
initial begin
    $dumpfile("cnt.vcd");
    $dumpvars(0, cnt_tb);
end

always #(0.5)
    clk = ~clk;

initial begin
    clk <= 1'b0;
    rst_n <= 1'b1;
    #(0.5) rst_n <= 1'b0;
    #(1) rst_n <= 1'b1;
    #(256) $finish;
end

endmodule