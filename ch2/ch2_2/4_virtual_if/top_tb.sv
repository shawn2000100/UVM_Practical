// File: top_tb.sv
// UVM 測試平台頂層 (含 interface)

`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_driver.sv"

module top_tb;

    // clock/reset & 資料訊號宣告
    reg         clk;        // 時脈
    reg         rst_n;      // 非同步低有效 reset
    reg  [7:0]  rxd;        // 輸入資料（未實際連接）
    reg         rx_dv;      // 資料有效（未實際連接）
    wire [7:0]  txd;        // 輸出資料（未實際連接）
    wire        tx_en;      // 輸出有效（未實際連接）

    // Interface 實例化
    my_if input_if(clk, rst_n);
    my_if output_if(clk, rst_n);

    // DUT 實例化，連接 interface
    dut my_dut(
        .clk    (clk),
        .rst_n  (rst_n),
        .rxd    (input_if.data),
        .rx_dv  (input_if.valid),
        .txd    (output_if.data),
        .tx_en  (output_if.valid)
    );

    // clock 產生器（100ns 週期）
    initial begin
        clk = 0;
        forever begin
            #100 clk = ~clk;
        end
    end

    // reset 初始化
    initial begin
        rst_n = 1'b0;
        #1000;
        rst_n = 1'b1;
    end

    // 啟動 UVM 測試
    initial begin
        run_test("my_driver");
    end

    // 設定 UVM config_db 綁定 interface
    initial begin
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top", "vif", input_if);
    end

endmodule
