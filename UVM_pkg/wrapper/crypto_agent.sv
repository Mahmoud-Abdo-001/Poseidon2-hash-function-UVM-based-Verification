class crypto_agent extends uvm_agent;
  `uvm_component_utils(crypto_agent)

  // Components
  crypto_config_obj c_cfg;       // Configuration object
  crypto_driver     drv;         // Driver
  crypto_monitor    mon;         // Monitor
  sequencer    sqr;         // Sequencer

  // Analysis port to broadcast transactions
  uvm_analysis_port #(crypto_seq_item) agt_ap;

  function new(string name = "crypto_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Retrieve configuration object
    if (!uvm_config_db#(crypto_config_obj)::get(this, "", "CFG", c_cfg)) begin
      `uvm_fatal("AGENT_CFG", "Unable to get configuration object from config DB")
    end

    // Component creation
    drv    = crypto_driver   ::type_id::create("drv", this);
    mon    = crypto_monitor  ::type_id::create("mon", this);
    sqr    = sequencer       ::type_id::create("sqr", this);
    agt_ap = new("agt_ap", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Interface binding
    drv.d_vif = c_cfg.cr_if;
    mon.m_vif = c_cfg.cr_if;

    // Sequencer-driver connection
    drv.seq_item_port.connect(sqr.seq_item_export);

    // Monitor-agent analysis connection
    mon.mon_ap.connect(agt_ap);
  endfunction

endclass
