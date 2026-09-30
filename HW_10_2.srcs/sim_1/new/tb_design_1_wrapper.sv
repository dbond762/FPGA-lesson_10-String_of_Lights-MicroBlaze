`timescale 1us / 1ns


module tb_design_1_wrapper;

    // ---- Такт і reset --
    // ---- Диференційний такт --
    reg  diff_clock_rtl_0_clk_p = 0;
    wire diff_clock_rtl_0_clk_n = ~diff_clock_rtl_0_clk_p;   // завжди протифазний до clk_p
    reg  reset_rtl_0 = 1;
    
    // ---- Зовнішні GPIO-порти
    wire [3:0] LED_tri_o;
    reg  [3:0] BTN_tri_i;
    reg  [1:0] SW_tri_i;
    
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
    always #0.005 diff_clock_rtl_0_clk_p = ~diff_clock_rtl_0_clk_p;
    
    int fails = 0;
    
    task automatic check_leds;
        input reg    [3:0] led;
        input reg    [3:0] expected;
        input string       name;
        begin;
            if (led === expected)
            begin
                $display("PASS: [%0t] %s: %b", $time, name, led);
            end
            else
            begin
                $display("FAIL: [%0t] %s: expected: %b, actual: %b", $time, name, expected, led);
                fails++;
            end
        end;
    endtask;
    
    initial begin
        reset_rtl_0 = 0;
        SW_tri_i    = 2'b00;
        BTN_tri_i   = 4'b0000;
        #0.2;
        reset_rtl_0 = 1;
        
        // Дати MicroBlaze час "прокинутись" і дійти до while( TRUE ) --
        #40;
        
        check_leds(LED_tri_o, 4'b0001, "Start LED");
        #200;
        check_leds(LED_tri_o, 4'b0010, "Default Period 200 us, left dir");
        
        BTN_tri_i = 4'b0001;
        #30;
        BTN_tri_i = 4'b0000;
        $display("Faster button pressed");
        
        #100;
        check_leds(LED_tri_o, 4'b0100, "Period 100 us, left dir");
        
        #200;
        check_leds(LED_tri_o, 4'b0001, "Period 100 us, left dir, 2 ticks and overflow");
        
        BTN_tri_i = 4'b1000;
        #30;
        BTN_tri_i = 4'b0000;
        $display("Slowwer button pressed");
        
        #200;
        check_leds(LED_tri_o, 4'b0010, "Period 200 us, left dir");
        
        SW_tri_i = 2'b01;
        #30;
        $display("Change direction");
        
        #200;
        check_leds(LED_tri_o, 4'b0001, "Period 200 us, right dir");
        
        BTN_tri_i = 4'b0100;
        #30;
        BTN_tri_i = 4'b0000;
        $display("Pause button pressed");
        
        #200;
        check_leds(LED_tri_o, 4'b0001, "Period 200 us, no change");
        
        BTN_tri_i = 4'b0010;
        #30;
        BTN_tri_i = 4'b0000;
        $display("Play button pressed");
        
        #200;
        check_leds(LED_tri_o, 4'b1000, "Period 200 us, right dir and overflow");
        
        $display("%0d failures", fails);
        
        $finish;
    end
    
    initial begin
       #2000;
       $display("TIMEOUT");
       $finish;
   end

endmodule
