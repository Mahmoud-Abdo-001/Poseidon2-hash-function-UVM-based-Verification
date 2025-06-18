class crypto_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(crypto_scoreboard)

  //==================== Ports & Interfaces ====================//
  uvm_analysis_export #(crypto_seq_item) sb_export;
  uvm_tlm_analysis_fifo #(crypto_seq_item) sb_fifo;
  virtual ref_if ref_vif;

  //==================== Variables ====================//
  crypto_seq_item seq_item_sb;
  int MATCH_count = 0;
  int MISMATCH_count = 0;

  //==================== Constructor ====================//
  function new(string name = "crypto_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  //==================== Build Phase ====================//
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_export = new("sb_export", this);
    sb_fifo   = new("sb_fifo", this);

    if (!uvm_config_db#(virtual ref_if)::get(this, "", "refV", ref_vif))
      `uvm_fatal("REF_CRYPTO_IF", "Unable to get ref crypto interface from database")
  endfunction

  //==================== Connect Phase ====================//
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    sb_export.connect(sb_fifo.analysis_export);
  endfunction

  //==================== Run Phase ====================//
  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      sb_fifo.get(seq_item_sb);

      if (seq_item_sb.done && ref_vif.done) begin
        if (seq_item_sb.hash_out === ref_vif.hash_out) begin
          MATCH_count++;
        end else begin
          MISMATCH_count++;
          `uvm_error("SB", $sformatf(
            "Hash mismatch:\n  DUT: 0x%h\n  REF: 0x%h",
            seq_item_sb.hash_out, ref_vif.hash_out
          ))
        end
      end 
    end
  endtask

  //==================== Report Phase ====================//
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("report_phase", "=================  CRYPTO WRAPPER RESULTS =================", UVM_MEDIUM)
    `uvm_info("report_phase", $sformatf("======= Total successful hashes : %0d", MATCH_count), UVM_MEDIUM)
    `uvm_info("report_phase", $sformatf("======= Total failed hashes     : %0d", MISMATCH_count), UVM_MEDIUM)
  endfunction

endclass
