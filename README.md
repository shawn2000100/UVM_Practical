# UVM Practice (Based on 《UVM实战》by 张强)

本專案為 SystemVerilog UVM 驗證練習，依照張強《UVM实战 卷Ⅰ》教材與開源範例實作。方便自學與作品集展示。


## 參考資料
- [UVM实战 卷Ⅰ PDF](https://github.com/CodeMadUser/FPGA-1/blob/master/src/docs/UVM%E5%AE%9E%E6%88%98%20%E5%8D%B7%E2%85%A0.pdf)
- [siyueyinghua/UVMInPracticesByZhangQiang](https://github.com/siyueyinghua/UVMInPracticesByZhangQiang/tree/master/puvm/src)


## 專案內容
- 基本 UVM 元件：env, agent, driver, monitor, sequence, scoreboard, test
- 簡易 DUT 及對應 top_tb 測試平台
- 練習範例對應原書各章節


### NOTE: UVM Phase
UVM Common Phases: https://verificationacademy.com/verification-methodology-reference/uvm/docs_1.2/html/files/base/uvm_common_phases-svh.html#uvm_run_phase


| UVM Phases | Direction |
| --- | --- |
| build_phase | uvm_topdown_phase |
| connect_phase | uvm_bottomup_phase |
| end_of_elaboration_phase | uvm_bottomup_phase |
| start_of_simulation_phase | uvm_bottomup_phase |
| run_phase | parallel |
| extract_phase | uvm_bottomup_phase |
| check_phase | uvm_bottomup_phase |
| report_phase | uvm_bottomup_phase |
| final_phase | uvm_topdown_phase |



### Keywords
CH.2_2

factory, uvm_component_utils
    run_test, uvm_test_top, main_phase
    type_name：：type_id：：create

objection, raise_objection, drop_objection
    $time, simulation time, cpu time

virtual interface
    module -> interface
    class -> virtual interface

build_phase
    config_db, set, get

uvm_fatal vs. uvm_info


---


CH.2_3
Transaction
    randomize, post_randomize
    uvm_sequence_item
    uvm_object_utils

uvm_env (Container)
    uvm_component, uvm_tree_hierarchy
    build_phase, root -> leaf (Top-Down)

uvm_monitor
input monitor / output monitor

uvm_agent
    is_active
    UVM_ACTIVE (default)
    UVM_PASSIVE

UVM_Tree_Node
    only uvm_component not uvm_object

reference model & DUT
    my_monitor & my_model
    uvm_analysis_port (non-blocking)
    uvm_tlm_analysis_fifo
    blocking_get_port
    connect_phase (Bottom-up)

    exp_port & act_port
    my_compare

field_automation
    uvm_field


sequence & sequencer

sequence -> sequencer -- transaction --> driver --> DUT

Gen transaction:
    uvm_do | start_item & finish_item


base_test & uvm_test


---


CH3

TODO


---


## QuestaSim 執行方式

1. **切換目錄：**
    ```sh
    cd src    # 或進入有 .sv 檔案的目錄
    ```

2. **編譯：**
    ```sh
    vlog *.sv
    ```

3. **模擬：**
    ```sh
    vsim top_tb
    ```

4. **執行/看波形：**
    - 在 transcript 輸入：
      ```sh
      run -all
      ```
    - 或用 GUI 加入信號觀察波形