class crypto_config_obj extends uvm_object;
    `uvm_object_utils(crypto_config_obj)

    virtual crypto_if cr_if;

    //constructor 
    function new(string name ="crypto_config_obj");
        super.new(name);
    endfunction

endclass