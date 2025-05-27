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

    input wire clk;  
    input wire rst_n;
    input wire [7:0] rxd;  
    input wire rx_dv;
    output reg [7:0] txd;  
    output reg tx_en;

    always @(posedge clk) begin
        if (!rst_n) begin
            txd   <= 8'b0;
            tx_en <= 1'b0; 
        end else begin
            txd   <= rxd;  
            tx_en <= rx_dv;
        end
    end

endmodule