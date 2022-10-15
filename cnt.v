module cnt # (
  parameter DW = 7
) (
  output     [DW-1:0] qout,
  output     [1:0]    state,

  input               clk,
  input               rst_n
);

  localparam STATE1 = 2'd0;
  localparam STATE2 = 2'd1;
  localparam STATE3 = 2'd2;
  localparam STATE4 = 2'd3;

  wire [DW-1:0] count_cur;
  wire [DW-1:0] count_nxt;

  wire sta_is_1 = (count_cur >= 0) & (count_cur < 40);
  wire sta_is_2 = (count_cur >= 40) & (count_cur < 45);
  wire sta_is_3 = (count_cur >= 45) & (count_cur < 65);
  wire sta_is_4 = (count_cur >= 65) & (count_cur < 70);
  wire sta_is_5 = count_cur >= 70;
  wire cnt_rst = (~sta_is_5) & rst_n;
  
  assign count_nxt = 
          ({DW{ cnt_rst}} & count_cur + 1)
        | ({DW{~cnt_rst}} & 6'd0         );

  assign qout = count_cur;

  assign state =
            ({DW{sta_is_1}} & STATE1)
          | ({DW{sta_is_2}} & STATE2)
          | ({DW{sta_is_3}} & STATE3)
          | ({DW{sta_is_4}} & STATE4)
          ;
  
  dffrs #(DW) cnt_dffrs (count_nxt, count_cur, clk, rst_n);

endmodule