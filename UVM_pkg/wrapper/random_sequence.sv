class random_sequence extends uvm_sequence #(crypto_seq_item);
  `uvm_object_utils(random_sequence)

  function new(string name = "random_sequence");
    super.new(name);
  endfunction

task body();
  crypto_seq_item tr;

    // First pattern: alternate between 2'b00 and 2'b01
    repeat (2000) begin
      tr = crypto_seq_item::type_id::create("tr");
      assert(tr.randomize());
      tr.rst_n = 1 ;
        // Pound (set) unused elements to zero based on size
        for (int i = tr.size; i < 15; i++) begin
            case (i)
                0:  tr.data_in_0  = 256'h0;
                1:  tr.data_in_1  = 256'h0;
                2:  tr.data_in_2  = 256'h0;
                3:  tr.data_in_3  = 256'h0;
                4:  tr.data_in_4  = 256'h0;
                5:  tr.data_in_5  = 256'h0;
                6:  tr.data_in_6  = 256'h0;
                7:  tr.data_in_7  = 256'h0;
                8:  tr.data_in_8  = 256'h0;
                9:  tr.data_in_9  = 256'h0;
                10: tr.data_in_10 = 256'h0;
                11: tr.data_in_11 = 256'h0;
                12: tr.data_in_12 = 256'h0;
                13: tr.data_in_13 = 256'h0;
                14: tr.data_in_14 = 256'h0;
            endcase
        end
      start_item(tr);
      finish_item(tr);
    end
endtask
endclass
