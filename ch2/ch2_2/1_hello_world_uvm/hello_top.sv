//==============================================================================
// File    : top_tb.sv
// Brief   : UVM 驅動環境下的頂層 Testbench
//           (配合 dut.sv 與 my_driver.sv)
// Author  : 張強《UVM實戰白皮書》練習風格
//==============================================================================

`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;           // 匯入 UVM 標準包
`include "my_driver.sv"      // 匯入自訂驅動程式

module top_tb;
    reg         clk;         // 時脈
    reg         rst_n;       // 非同步低有效 reset
    reg  [7:0]  rxd;         // 輸入資料
    reg         rx_dv;       // 資料有效
    wire [7:0]  txd;         // 輸出資料
    wire        tx_en;       // 輸出有效訊號

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
        drv.main_phase(null);   // 直接呼叫 main_phase 執行 (簡化寫法)
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
