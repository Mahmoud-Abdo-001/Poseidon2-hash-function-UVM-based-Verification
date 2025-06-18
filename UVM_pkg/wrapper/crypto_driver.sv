class crypto_driver extends uvm_driver #(crypto_seq_item);
  `uvm_component_utils(crypto_driver)

  virtual crypto_if.drv d_vif;
  crypto_seq_item stim_seq_item;

  function new(string name = "crypto_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    // Reset phase
    @(posedge d_vif.clk);
    d_vif.rst_n     <= 1'b0;
    d_vif.start     <= 1'b0;
    d_vif.size      <= '0;

    d_vif.data_in_0 <= '0;
    d_vif.data_in_1 <= '0;
    d_vif.data_in_2 <= '0;
    d_vif.data_in_3 <= '0;
    d_vif.data_in_4 <= '0;
    d_vif.data_in_5 <= '0;
    d_vif.data_in_6 <= '0;
    d_vif.data_in_7 <= '0;
    d_vif.data_in_8 <= '0;
    d_vif.data_in_9 <= '0;
    d_vif.data_in_10 <= '0;
    d_vif.data_in_11 <= '0;
    d_vif.data_in_12 <= '0;
    d_vif.data_in_13 <= '0;
    d_vif.data_in_14 <= '0;
    
    repeat (10) @(posedge d_vif.clk);
    d_vif.rst_n <= 1'b1;
     `uvm_info("DRV", "Reset complete", UVM_MEDIUM)

    forever begin
      seq_item_port.get_next_item(stim_seq_item);

      // Apply input
      @(posedge d_vif.clk);
      d_vif.data_in_0 <= stim_seq_item.data_in_0;
      d_vif.data_in_1 <= stim_seq_item.data_in_1;
      d_vif.data_in_2 <= stim_seq_item.data_in_2;
      d_vif.data_in_3 <= stim_seq_item.data_in_3;
      d_vif.data_in_4 <= stim_seq_item.data_in_4;
      d_vif.data_in_5 <= stim_seq_item.data_in_5;
      d_vif.data_in_6 <= stim_seq_item.data_in_6;
      d_vif.data_in_7 <= stim_seq_item.data_in_7;
      d_vif.data_in_7 <= stim_seq_item.data_in_7;
      d_vif.data_in_8 <= stim_seq_item.data_in_8;
      d_vif.data_in_9 <= stim_seq_item.data_in_9;
      d_vif.data_in_10 <= stim_seq_item.data_in_10;
      d_vif.data_in_11 <= stim_seq_item.data_in_11;
      d_vif.data_in_12 <= stim_seq_item.data_in_12;
      d_vif.data_in_13 <= stim_seq_item.data_in_13;
      d_vif.data_in_14 <= stim_seq_item.data_in_14;
      d_vif.size   <= stim_seq_item.size;
      d_vif.rst_n   <= stim_seq_item.rst_n;
      d_vif.start      <= 1'b1;

      @(posedge d_vif.clk);  // assert start for one clk cycle
      d_vif.start <= 1'b0;

      // Wait until done is asserted
      wait (d_vif.done == 1'b1);

      // crypto reset after each hashout  
      @(posedge d_vif.clk);
      d_vif.rst_n <= 1'b0;

      @(posedge d_vif.clk);
      d_vif.rst_n <= 1'b1;

      seq_item_port.item_done();
    end
  endtask
endclass
