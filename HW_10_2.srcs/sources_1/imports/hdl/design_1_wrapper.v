//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2026.1 (win64) Build 6511674 Tue Jun 16 11:02:23 MDT 2026
//Date        : Sun Oct 18 16:11:01 2026
//Host        : DESKTOP-GA58GU9 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (BTN_tri_i,
    LED_tri_o,
    SW_tri_i,
    sys_clk);
  input [3:0]BTN_tri_i;
  output [3:0]LED_tri_o;
  input [1:0]SW_tri_i;
  input sys_clk;          // 125 MHz, PYNQ-Z2 pin H16

  wire [3:0]BTN_tri_i;
  wire [3:0]LED_tri_o;
  wire [1:0]SW_tri_i;
  wire sys_clk;

  // Внутрішні сигнали (не виводяться на піни)
  wire clk_out1_0;              // 100 MHz з clk_wiz (вже через BUFG) -> такт ILA
  wire reset_rtl_0 = 1'b1;      // active-low, вільної кнопки на PYNQ-Z2 немає -> постійно неактивний

  design_1 design_1_i
       (.BTN_tri_i(BTN_tri_i),
        .LED_tri_o(LED_tri_o),
        .SW_tri_i(SW_tri_i),
        .clk_out1_0(clk_out1_0),
        .sys_clk(sys_clk),
        .reset_rtl_0(reset_rtl_0));

    ila_0 ila_instance (
        .clk(clk_out1_0), // input wire clk

        .probe0(LED_tri_o), // input wire [3:0]  probe0
        .probe1(BTN_tri_i), // input wire [3:0]  probe1
        .probe2(SW_tri_i), // input wire [1:0]  probe2
        .probe3(reset_rtl_0) // input wire [0:0]  probe3
    );
endmodule
