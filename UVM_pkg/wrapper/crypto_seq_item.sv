class crypto_seq_item extends uvm_sequence_item;
  `uvm_object_utils(crypto_seq_item)

  //====================//
  //  Data Members      //
  logic rst_n;
  rand logic [3:0] size;
  logic start;
  // Individual data inputs
  rand logic [255:0] data_in_0;
  rand logic [255:0] data_in_1;
  rand logic [255:0] data_in_2;
  rand logic [255:0] data_in_3;
  rand logic [255:0] data_in_4;
  rand logic [255:0] data_in_5;
  rand logic [255:0] data_in_6;
  rand logic [255:0] data_in_7;
  rand logic [255:0] data_in_8;
  rand logic [255:0] data_in_9;
  rand logic [255:0] data_in_10;
  rand logic [255:0] data_in_11;
  rand logic [255:0] data_in_12;
  rand logic [255:0] data_in_13;
  rand logic [255:0] data_in_14;
  
  // Outputs
  logic [255:0] hash_out;
  logic done;


  // constrains
  constraint valid_size { size dist {[1:15] := 1}; }
  //====================
  // Constructor        
  function new(string name = "crypto_seq_item");
    super.new(name);
  endfunction

  //====================//
  // Print Utility      //
  //====================//
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    
    // Control signals
    printer.print_field("rst_n", rst_n, 1, UVM_BIN);
    printer.print_field("size", size, 4, UVM_DEC);
    printer.print_field("start", start, 1, UVM_BIN);
    
    // Data inputs
    printer.print_field("data_in_0", data_in_0, 256, UVM_HEX);
    printer.print_field("data_in_1", data_in_1, 256, UVM_HEX);
    printer.print_field("data_in_2", data_in_2, 256, UVM_HEX);
    printer.print_field("data_in_3", data_in_3, 256, UVM_HEX);
    printer.print_field("data_in_4", data_in_4, 256, UVM_HEX);
    printer.print_field("data_in_5", data_in_5, 256, UVM_HEX);
    printer.print_field("data_in_6", data_in_6, 256, UVM_HEX);
    printer.print_field("data_in_7", data_in_7, 256, UVM_HEX);
    printer.print_field("data_in_8", data_in_8, 256, UVM_HEX);
    printer.print_field("data_in_9", data_in_9, 256, UVM_HEX);
    printer.print_field("data_in_10", data_in_10, 256, UVM_HEX);
    printer.print_field("data_in_11", data_in_11, 256, UVM_HEX);
    printer.print_field("data_in_12", data_in_12, 256, UVM_HEX);
    printer.print_field("data_in_13", data_in_13, 256, UVM_HEX);
    printer.print_field("data_in_14", data_in_14, 256, UVM_HEX);
    
    // Outputs
    printer.print_field("hash_out", hash_out, 256, UVM_HEX);
    printer.print_field("done", done, 1, UVM_BIN);
  endfunction


endclass