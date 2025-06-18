class crypto_coverage_collector extends uvm_component;
  `uvm_component_utils(crypto_coverage_collector)

  uvm_analysis_export #(crypto_seq_item) cov_export;
  uvm_tlm_analysis_fifo #(crypto_seq_item) cov_fifo;

  crypto_seq_item crypto_item_cov;
  crypto_config_obj c_cfg;
  virtual crypto_if c_if;

  // Sampled variables
  logic [3:0] size_val;
  logic start_val;
  logic done_val;
  logic [255:0] data_in_val[15];
  logic [255:0] hash_out_val;

  // Covergroup
  covergroup CRYPTO_CG;
    option.per_instance = 1;

    // size coverage
    size_cp : coverpoint size_val {
      bins all_sizes[] = {[0:15]};
    }

    // start signal
    start_cp : coverpoint start_val {
      bins active = {1'b1};
      bins inactive = {1'b0};
    }

    // done signal
    done_cp : coverpoint done_val {
      bins done = {1'b1};
      bins not_done = {1'b0};
    }

    // hash output (LSB and MSB)
    hash_lsb_cp : coverpoint hash_out_val[7:0] {
      bins all = {[8'h00:8'hFF]};
    }

    hash_msb_cp : coverpoint hash_out_val[255:248] {
      bins all = {[8'h00:8'hFF]};
    }

    // Data input coverpoints (LSB + MSB per each input)
    data_in_0_lsb_cp : coverpoint data_in_val[0][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_0_msb_cp : coverpoint data_in_val[0][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_1_lsb_cp : coverpoint data_in_val[1][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_1_msb_cp : coverpoint data_in_val[1][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_2_lsb_cp : coverpoint data_in_val[2][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_2_msb_cp : coverpoint data_in_val[2][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_3_lsb_cp : coverpoint data_in_val[3][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_3_msb_cp : coverpoint data_in_val[3][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_4_lsb_cp : coverpoint data_in_val[4][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_4_msb_cp : coverpoint data_in_val[4][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_5_lsb_cp : coverpoint data_in_val[5][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_5_msb_cp : coverpoint data_in_val[5][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_6_lsb_cp : coverpoint data_in_val[6][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_6_msb_cp : coverpoint data_in_val[6][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_7_lsb_cp : coverpoint data_in_val[7][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_7_msb_cp : coverpoint data_in_val[7][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_8_lsb_cp : coverpoint data_in_val[8][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_8_msb_cp : coverpoint data_in_val[8][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_9_lsb_cp : coverpoint data_in_val[9][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_9_msb_cp : coverpoint data_in_val[9][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_10_lsb_cp : coverpoint data_in_val[10][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_10_msb_cp : coverpoint data_in_val[10][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_11_lsb_cp : coverpoint data_in_val[11][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_11_msb_cp : coverpoint data_in_val[11][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_12_lsb_cp : coverpoint data_in_val[12][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_12_msb_cp : coverpoint data_in_val[12][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_13_lsb_cp : coverpoint data_in_val[13][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_13_msb_cp : coverpoint data_in_val[13][255:248] { bins all = {[8'h00:8'hFF]}; }

    data_in_14_lsb_cp : coverpoint data_in_val[14][7:0] { bins all = {[8'h00:8'hFF]}; }
    data_in_14_msb_cp : coverpoint data_in_val[14][255:248] { bins all = {[8'h00:8'hFF]}; }

  endgroup

  // Constructor
  function new(string name = "crypto_coverage_collector", uvm_component parent = null);
    super.new(name, parent);
    CRYPTO_CG = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_export = new("cov_export", this);
    cov_fifo   = new("cov_fifo", this);

    if (!uvm_config_db#(crypto_config_obj)::get(this, "", "CFG", c_cfg))
      `uvm_fatal("CRYPTO_CFG", "Unable to get crypto config object")
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    cov_export.connect(cov_fifo.analysis_export);
    c_if = c_cfg.cr_if;
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge c_if.clk);
      size_val = c_if.size;
      start_val = c_if.start;
      done_val = c_if.done;
      hash_out_val = c_if.hash_out;

      data_in_val[0] = c_if.data_in_0;
      data_in_val[1] = c_if.data_in_1;
      data_in_val[2] = c_if.data_in_2;
      data_in_val[3] = c_if.data_in_3;
      data_in_val[4] = c_if.data_in_4;
      data_in_val[5] = c_if.data_in_5;
      data_in_val[6] = c_if.data_in_6;
      data_in_val[7] = c_if.data_in_7;
      data_in_val[8] = c_if.data_in_8;
      data_in_val[9] = c_if.data_in_9;
      data_in_val[10] = c_if.data_in_10;
      data_in_val[11] = c_if.data_in_11;
      data_in_val[12] = c_if.data_in_12;
      data_in_val[13] = c_if.data_in_13;
      data_in_val[14] = c_if.data_in_14;

      CRYPTO_CG.sample();

      if (!cov_fifo.is_empty()) begin
        cov_fifo.get(crypto_item_cov);
      end
    end
  endtask

function void report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info("COV_REPORT", "================= CRYPTO Coverage Summary ================", UVM_LOW)
  `uvm_info("COV_REPORT", $sformatf("======== Size Coverage: %.2f%%", CRYPTO_CG.size_cp.get_coverage()), UVM_LOW)
  `uvm_info("COV_REPORT", $sformatf("======== Start Coverage: %.2f%%", CRYPTO_CG.start_cp.get_coverage()), UVM_LOW)
  `uvm_info("COV_REPORT", $sformatf("======== Done Coverage: %.2f%%", CRYPTO_CG.done_cp.get_coverage()), UVM_LOW)
  `uvm_info("COV_REPORT", $sformatf("======== Hash Out LSB Coverage: %.2f%%", CRYPTO_CG.hash_lsb_cp.get_coverage()), UVM_LOW)
  `uvm_info("COV_REPORT", $sformatf("======== Hash Out MSB Coverage: %.2f%%", CRYPTO_CG.hash_msb_cp.get_coverage()), UVM_LOW)
endfunction


endclass
