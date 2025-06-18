class crypto_monitor extends uvm_monitor;
  `uvm_component_utils(crypto_monitor)

  virtual crypto_if m_vif;   // monitor interface
  crypto_seq_item rsp_seq_item;
  uvm_analysis_port #(crypto_seq_item) mon_ap;

  function new(string name = "crypto_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      @(posedge m_vif.clk);

    //if (m_vif.done == 1'b1) begin
        rsp_seq_item = crypto_seq_item::type_id::create("rsp_seq_item");

        rsp_seq_item.rst_n     = m_vif.rst_n;
        rsp_seq_item.start     = m_vif.start;
        rsp_seq_item.size      = m_vif.size;
        // Capture all 15 data inputs
        rsp_seq_item.data_in_0  = m_vif.data_in_0;
        rsp_seq_item.data_in_1  = m_vif.data_in_1;
        rsp_seq_item.data_in_2  = m_vif.data_in_2;
        rsp_seq_item.data_in_3  = m_vif.data_in_3;
        rsp_seq_item.data_in_4  = m_vif.data_in_4;
        rsp_seq_item.data_in_5  = m_vif.data_in_5;
        rsp_seq_item.data_in_6  = m_vif.data_in_6;
        rsp_seq_item.data_in_7  = m_vif.data_in_7;
        rsp_seq_item.data_in_8  = m_vif.data_in_8;
        rsp_seq_item.data_in_9  = m_vif.data_in_9;
        rsp_seq_item.data_in_10 = m_vif.data_in_10;
        rsp_seq_item.data_in_11 = m_vif.data_in_11;
        rsp_seq_item.data_in_12 = m_vif.data_in_12;
        rsp_seq_item.data_in_13 = m_vif.data_in_13;
        rsp_seq_item.data_in_14 = m_vif.data_in_14;
        //capture hash out 
        rsp_seq_item.hash_out      = m_vif.hash_out;
        rsp_seq_item.done          = m_vif.done;

        mon_ap.write(rsp_seq_item);
      end
    // end
  endtask

endclass
