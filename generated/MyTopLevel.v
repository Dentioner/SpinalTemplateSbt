// Generator : SpinalHDL v1.7.2    git head : 08fc866bebdc40c471ebe327bface63e34406489
// Component : MyTopLevel
// Git hash  : 4570b17a29fb30dc4c8fa3f4a9d0aa7bfc20a017

`timescale 1ns/1ps

module MyTopLevel (
  input               io_addflow0_dataflow_valid,
  input      [7:0]    io_addflow0_dataflow_payload_data1,
  input      [7:0]    io_addflow0_dataflow_payload_data2,
  output              io_addflow0_sumflow_valid,
  output     [7:0]    io_addflow0_sumflow_payload,
  input               io_addflow1_dataflow_valid,
  input      [7:0]    io_addflow1_dataflow_payload_data1,
  input      [7:0]    io_addflow1_dataflow_payload_data2,
  output              io_addflow1_sumflow_valid,
  output     [7:0]    io_addflow1_sumflow_payload,
  input               clk,
  input               reset
);

  reg        [7:0]    _zz_io_addflow0_sumflow_payload;
  reg                 io_addflow0_dataflow_valid_regNext;
  reg        [7:0]    _zz_io_addflow1_sumflow_payload;
  reg                 io_addflow1_dataflow_valid_regNext;

  assign io_addflow0_sumflow_payload = _zz_io_addflow0_sumflow_payload;
  assign io_addflow0_sumflow_valid = io_addflow0_dataflow_valid_regNext;
  assign io_addflow1_sumflow_payload = _zz_io_addflow1_sumflow_payload;
  assign io_addflow1_sumflow_valid = io_addflow1_dataflow_valid_regNext;
  always @(posedge clk) begin
    if(io_addflow0_dataflow_valid) begin
      _zz_io_addflow0_sumflow_payload <= (io_addflow0_dataflow_payload_data1 + io_addflow0_dataflow_payload_data2);
    end
    if(io_addflow1_dataflow_valid) begin
      _zz_io_addflow1_sumflow_payload <= (io_addflow1_dataflow_payload_data1 + io_addflow1_dataflow_payload_data2);
    end
  end

  always @(posedge clk) begin
    if(reset) begin
      io_addflow0_dataflow_valid_regNext <= 1'b0;
      io_addflow1_dataflow_valid_regNext <= 1'b0;
    end else begin
      io_addflow0_dataflow_valid_regNext <= io_addflow0_dataflow_valid;
      io_addflow1_dataflow_valid_regNext <= io_addflow1_dataflow_valid;
    end
  end


endmodule
