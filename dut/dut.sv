// File: dut.sv
// Description: 簡單資料通道 DUT，供 UVM 練習用

module dut (
    clk,     // Clock
    rst_n,   // Active-low reset
    rxd,     // Received data
    rx_dv,   // Data valid
    txd,     // Transmit data
    tx_en    // Transmit enable
);

    // ==== Port 宣告 ====
    input        clk;         // 時脈
    input        rst_n;       // 非同步低有效 reset
    input  [7:0] rxd;         // 接收資料
    input        rx_dv;       // 接收資料有效
    output [7:0] txd;         // 傳送資料
    output       tx_en;       // 傳送使能

    // ==== Output 註冊 ====
    reg [7:0] txd;
    reg       tx_en;

    // ==== 資料處理邏輯 ====
    always @(posedge clk) begin
        if (!rst_n) begin
            txd   <= 8'b0;    // Reset 狀態，資料清零
            tx_en <= 1'b0;    // Reset 狀態，禁止傳送
        end else begin
            txd   <= rxd;     // 正常狀態，輸出接收資料
            tx_en <= rx_dv;   // 正常狀態，輸出資料有效
        end
    end

endmodule