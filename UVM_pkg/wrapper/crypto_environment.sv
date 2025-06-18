import crypto_pkg::*;

class crypto_environment extends uvm_env;
        `uvm_component_utils (crypto_environment)

        // Wrapper agent, scoreboard and coverage collector
        crypto_agent c_agt;
        crypto_scoreboard c_sb;
        crypto_coverage_collector c_cov;


    
        // construction
        function new (string name = "crypto_environment", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            //crypto wrapper
            c_agt = crypto_agent::type_id::create("c_agt",this);            
            c_sb  = crypto_scoreboard::type_id::create("c_sb", this);
            c_cov = crypto_coverage_collector::type_id::create("c_cov", this);
            
        endfunction

        // connection between agent and scoreboard and between agent and coverage collector
        function void connect_phase (uvm_phase phase);
            //wrapper
            c_agt.agt_ap.connect(c_sb.sb_export);
            c_agt.agt_ap.connect(c_cov.cov_export);
    
        endfunction
    endclass