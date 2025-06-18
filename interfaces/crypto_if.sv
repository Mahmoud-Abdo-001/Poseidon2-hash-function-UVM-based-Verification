interface crypto_if(input logic clk);

  logic rst_n;
  logic [3:0] size;
  logic start;
  // Individual data inputs
  logic [255:0] data_in_0;
  logic [255:0] data_in_1;
  logic [255:0] data_in_2;
  logic [255:0] data_in_3;
  logic [255:0] data_in_4;
  logic [255:0] data_in_5;
  logic [255:0] data_in_6;
  logic [255:0] data_in_7;
  logic [255:0] data_in_8;
  logic [255:0] data_in_9;
  logic [255:0] data_in_10;
  logic [255:0] data_in_11;
  logic [255:0] data_in_12;
  logic [255:0] data_in_13;
  logic [255:0] data_in_14;
  
  // Outputs
  logic  [255:0] hash_out;
  logic  done;
  
endinterface //crypto_if(input logic clk)