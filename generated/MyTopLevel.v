// Generator : SpinalHDL v1.7.3    git head : aeaeece704fe43c766e0d36a93f2ecbb8a9f2003
// Component : MyTopLevel
// Git hash  : 9c3b5855c5db3d0684eeb1212f2325108a29bd5a

`timescale 1ns/1ps

module MyTopLevel (
  input               io_liteIn_aw_valid,
  output              io_liteIn_aw_ready,
  input      [31:0]   io_liteIn_aw_payload_addr,
  input      [2:0]    io_liteIn_aw_payload_prot,
  input               io_liteIn_w_valid,
  output              io_liteIn_w_ready,
  input      [31:0]   io_liteIn_w_payload_data,
  input      [3:0]    io_liteIn_w_payload_strb,
  output              io_liteIn_b_valid,
  input               io_liteIn_b_ready,
  output     [1:0]    io_liteIn_b_payload_resp,
  input               io_liteIn_ar_valid,
  output              io_liteIn_ar_ready,
  input      [31:0]   io_liteIn_ar_payload_addr,
  input      [2:0]    io_liteIn_ar_payload_prot,
  output              io_liteIn_r_valid,
  input               io_liteIn_r_ready,
  output     [31:0]   io_liteIn_r_payload_data,
  output     [1:0]    io_liteIn_r_payload_resp,
  output              io_liteOut_aw_valid,
  input               io_liteOut_aw_ready,
  output     [63:0]   io_liteOut_aw_payload_addr,
  output     [2:0]    io_liteOut_aw_payload_prot,
  output              io_liteOut_w_valid,
  input               io_liteOut_w_ready,
  output     [63:0]   io_liteOut_w_payload_data,
  output     [7:0]    io_liteOut_w_payload_strb,
  input               io_liteOut_b_valid,
  output              io_liteOut_b_ready,
  input      [1:0]    io_liteOut_b_payload_resp,
  output              io_liteOut_ar_valid,
  input               io_liteOut_ar_ready,
  output     [63:0]   io_liteOut_ar_payload_addr,
  output     [2:0]    io_liteOut_ar_payload_prot,
  input               io_liteOut_r_valid,
  output              io_liteOut_r_ready,
  input      [63:0]   io_liteOut_r_payload_data,
  input      [1:0]    io_liteOut_r_payload_resp
);

  wire                alite_aw_valid;
  wire                alite_aw_ready;
  wire       [63:0]   alite_aw_payload_addr;
  wire       [2:0]    alite_aw_payload_prot;
  wire                alite_w_valid;
  wire                alite_w_ready;
  wire       [31:0]   alite_w_payload_data;
  wire       [3:0]    alite_w_payload_strb;
  wire                alite_b_valid;
  wire                alite_b_ready;
  wire       [1:0]    alite_b_payload_resp;
  wire                alite_ar_valid;
  wire                alite_ar_ready;
  wire       [63:0]   alite_ar_payload_addr;
  wire       [2:0]    alite_ar_payload_prot;
  wire                alite_r_valid;
  wire                alite_r_ready;
  wire       [31:0]   alite_r_payload_data;
  wire       [1:0]    alite_r_payload_resp;

  assign alite_aw_valid = io_liteIn_aw_valid;
  assign io_liteIn_aw_ready = alite_aw_ready;
  assign alite_aw_payload_addr = {32'd0, io_liteIn_aw_payload_addr};
  assign alite_aw_payload_prot = io_liteIn_aw_payload_prot;
  assign alite_w_valid = io_liteIn_w_valid;
  assign io_liteIn_w_ready = alite_w_ready;
  assign alite_w_payload_data = io_liteIn_w_payload_data;
  assign alite_w_payload_strb = io_liteIn_w_payload_strb;
  assign io_liteIn_b_valid = alite_b_valid;
  assign alite_b_ready = io_liteIn_b_ready;
  assign io_liteIn_b_payload_resp = alite_b_payload_resp;
  assign alite_ar_valid = io_liteIn_ar_valid;
  assign io_liteIn_ar_ready = alite_ar_ready;
  assign alite_ar_payload_addr = {32'd0, io_liteIn_ar_payload_addr};
  assign alite_ar_payload_prot = io_liteIn_ar_payload_prot;
  assign io_liteIn_r_valid = alite_r_valid;
  assign alite_r_ready = io_liteIn_r_ready;
  assign io_liteIn_r_payload_data = alite_r_payload_data;
  assign io_liteIn_r_payload_resp = alite_r_payload_resp;
  assign io_liteOut_aw_valid = alite_aw_valid;
  assign alite_aw_ready = io_liteOut_aw_ready;
  assign io_liteOut_aw_payload_addr = alite_aw_payload_addr;
  assign io_liteOut_aw_payload_prot = alite_aw_payload_prot;
  assign io_liteOut_w_valid = alite_w_valid;
  assign alite_w_ready = io_liteOut_w_ready;
  assign io_liteOut_w_payload_data = {32'd0, alite_w_payload_data};
  assign io_liteOut_w_payload_strb = {4'd0, alite_w_payload_strb};
  assign alite_b_valid = io_liteOut_b_valid;
  assign io_liteOut_b_ready = alite_b_ready;
  assign alite_b_payload_resp = io_liteOut_b_payload_resp;
  assign io_liteOut_ar_valid = alite_ar_valid;
  assign alite_ar_ready = io_liteOut_ar_ready;
  assign io_liteOut_ar_payload_addr = alite_ar_payload_addr;
  assign io_liteOut_ar_payload_prot = alite_ar_payload_prot;
  assign alite_r_valid = io_liteOut_r_valid;
  assign io_liteOut_r_ready = alite_r_ready;
  assign alite_r_payload_data = io_liteOut_r_payload_data[31:0];
  assign alite_r_payload_resp = io_liteOut_r_payload_resp;

endmodule
