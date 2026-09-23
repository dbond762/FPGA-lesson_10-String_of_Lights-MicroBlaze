`timescale 1ns / 1ps


module tb_design_1_wrapper;

    // ---- Такт і reset --
    // ---- Диференційний такт --
    reg  diff_clock_rtl_0_clk_p = 0;
    wire diff_clock_rtl_0_clk_n = ~diff_clock_rtl_0_clk_p;   // завжди протифазний до clk_p
    reg reset_rtl_0 = 1;
    
    // ---- Зовнішні GPIO-порти
    reg [3:0] LED_tri_o;
    reg [3:0] BTN_tri_i;
    reg [1:0] SW_tri_i;
    
    // ---- Інстанціювання ПОВНОЇ верхньої обгортк
    design_1_wrapper dut (
        .diff_clock_rtl_0_clk_p(diff_clock_rtl_0_clk_p),
        .diff_clock_rtl_0_clk_n(diff_clock_rtl_0_clk_n),
        .reset_rtl_0(reset_rtl_0),
        .LED_tri_o(LED_tri_o),
        .BTN_tri_i(BTN_tri_i),
        .SW_tri_i(SW_tri_i)
    );
    
    // ---- Генерація такту
    always #5 diff_clock_rtl_0_clk_p = ~diff_clock_rtl_0_clk_p;
    
    initial begin
        reset_rtl_0 = 0;
        SW_tri_i    = 2'b00;
        BTN_tri_i   = 4'b0000;
        #200;
        reset_rtl_0 = 1;
        
        // Дати MicroBlaze час "прокинутись" і дійти до while( TRUE ) --
        #50000;
        
        // ...
    end

endmodule
