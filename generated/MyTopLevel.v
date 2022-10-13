// Generator : SpinalHDL v1.7.3    git head : aeaeece704fe43c766e0d36a93f2ecbb8a9f2003
// Component : MyTopLevel
// Git hash  : 9ea92e53ba7d8b0e0fe949e27742377d66dcf702

`timescale 1ns/1ps

module MyTopLevel (
  input      [7:0]    data1,
  input      [7:0]    data2,
  input      [7:0]    data3,
  input      [7:0]    data4,
  output     [7:0]    sum1,
  output     [7:0]    sum2,
  input               clk,
  input               reset
);

  wire       [7:0]    sumInst1_sum;
  wire       [7:0]    sumInst2_sum;

  mysum sumInst1 (
    .data1 (data1[7:0]       ), //i
    .data2 (data2[7:0]       ), //i
    .sum   (sumInst1_sum[7:0]), //o
    .clk   (clk              ), //i
    .reset (reset            )  //i
  );
  mysum sumInst2 (
    .data1 (data3[7:0]       ), //i
    .data2 (data4[7:0]       ), //i
    .sum   (sumInst2_sum[7:0]), //o
    .clk   (clk              ), //i
    .reset (reset            )  //i
  );
  assign sum1 = sumInst1_sum;
  assign sum2 = sumInst2_sum;

endmodule

//mysum replaced by mysum

module mysum (
  input      [7:0]    data1,
  input      [7:0]    data2,
  output reg [7:0]    sum,
  input               clk,
  input               reset
);


  always @(posedge clk) begin
    sum <= (data1 + data2);
  end


endmodule
