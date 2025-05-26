//==============================================================================
// File    : my_driver.sv
// Brief   : UVM 驅動（driver）範例，隨機產生資料送至 DUT
// Author  : 張強《UVM實戰白皮書》練習風格
//==============================================================================

`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

//==============================================================================
// my_driver: 繼承自 uvm_driver 的自訂驅動類別
//==============================================================================
class my_driver extends uvm_driver;

    //--------------------------------------------------------------------------
    // 建構函數：初始化名稱與父元件
    //--------------------------------------------------------------------------
    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    //--------------------------------------------------------------------------
    // main_phase: 覆寫主流程（於測試期間呼叫）
    //--------------------------------------------------------------------------
    extern virtual task main_phase(uvm_phase phase);

endclass

//==============================================================================
// main_phase 實作
// - 初始化 DUT 端口
// - 等待 reset 結束
// - 每個時脈週期產生隨機資料並送出
//==============================================================================
task my_driver::main_phase(uvm_phase phase);

    top_tb.rxd   <= 8'b0;      // 初始化輸入資料
    top_tb.rx_dv <= 1'b0;      // 初始化資料有效訊號

    // 等待 reset 結束
    while (!top_tb.rst_n)
        @(posedge top_tb.clk);

    // 資料驅動流程（共 256 筆隨機資料）
    for (int i = 0; i < 256; i++) begin
        @(posedge top_tb.clk);
        top_tb.rxd   <= $urandom_range(0, 255); // 產生隨機資料
        top_tb.rx_dv <= 1'b1;                   // 資料有效
        `uvm_info("my_driver", "data is drived", UVM_LOW) // UVM 日誌
    end

    // 停止驅動資料
    @(posedge top_tb.clk);
    top_tb.rx_dv <= 1'b0;

endtask

`endif
