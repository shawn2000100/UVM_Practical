`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_driver.sv"

module top_tb;
    reg         clk;  
    reg         rst_n;
    reg  [7:0]  rxd;  
    reg         rx_dv;
    wire [7:0]  txd;  
    wire        tx_en;

    dut my_dut (
        .clk    (clk),
        .rst_n  (rst_n),
        .rxd    (rxd),
        .rx_dv  (rx_dv),
        .txd    (txd),
        .tx_en  (tx_en)
    );

    initial begin
        my_driver drv;         // 宣告 driver handle
        drv = new("drv", null); // 建立 driver 物件
        drv.main_phase(null);   // 直接呼叫 main_phase 執行
        $finish();              // 結束模擬
    end

    initial begin
        clk = 0;
        forever begin
            #100 clk = ~clk;
        end
    end

    initial begin
        rst_n = 1'b0;
        #1000;
        rst_n = 1'b1;
    end

endmodule
