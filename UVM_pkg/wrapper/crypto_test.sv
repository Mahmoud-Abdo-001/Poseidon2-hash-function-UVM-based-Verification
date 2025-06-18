class crypto_test extends uvm_test;
`uvm_component_utils(crypto_test);

crypto_environment env;
crypto_config_obj c_cfg;
virtual crypto_if c_vif;
random_sequence rand_seq;

    function new(string name="crypto_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

        // build both environmnet, Sequences and configuration objects 
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env   = crypto_environment::type_id::create("env", this);
            c_cfg = crypto_config_obj::type_id::create("c_cfg");
            // sequences 
            rand_seq = random_sequence::type_id::create("rand_seq", this);

            //getting the real interface and assign it to the virtual one in the configuration object
            if (!uvm_config_db #(virtual crypto_if)::get(this,"","cryptoV", c_cfg.cr_if))
                `uvm_fatal("build_phase", "test unable");

            // setting the entire object to be visible by all under the ram_test umbrella
            uvm_config_db #(crypto_config_obj)::set(this,"*","CFG", c_cfg);
        endfunction


        // run phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this); // incerement static var.
            // main sequence
            `uvm_info("run_phase", "main random sequences asserted", UVM_MEDIUM)
                rand_seq.start(env.c_agt.sqr);
            `uvm_info("run_phase", "main random sequence dasserted", UVM_LOW)
            phase.drop_objection(this); // decrement static var.
        endtask
endclass //ram_test 