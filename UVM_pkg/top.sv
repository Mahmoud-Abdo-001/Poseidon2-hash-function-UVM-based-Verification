module top ();
    import uvm_pkg::*;
    import crypto_pkg::*;
    `include "uvm_macros.svh"

    bit clk;

    crypto_if cry_if(clk);  // crypto wrapper interface
    ref_if r_if(clk);       //  reference crypto interface


    // crypto DUT Instantiation
    crypto_wrapper DUT (
    // System signals
    .clk(cry_if.clk),
    .rst_n(cry_if.rst_n),
    .size(cry_if.size),
    .start(cry_if.start), 
    // Individual data inputs
    .data_in_0(cry_if.data_in_0),
    .data_in_1(cry_if.data_in_1),
    .data_in_2(cry_if.data_in_2),
    .data_in_3(cry_if.data_in_3),
    .data_in_4(cry_if.data_in_4),
    .data_in_5(cry_if.data_in_5),
    .data_in_6(cry_if.data_in_6),
    .data_in_7(cry_if.data_in_7),
    .data_in_8(cry_if.data_in_8),
    .data_in_9(cry_if.data_in_9),
    .data_in_10(cry_if.data_in_10),
    .data_in_11(cry_if.data_in_11),
    .data_in_12(cry_if.data_in_12),
    .data_in_13(cry_if.data_in_13),
    .data_in_14(cry_if.data_in_14),
    // Outputs
    .hash_out(cry_if.hash_out),
    .done(cry_if.done)
    );


    // ref crypto DUT Instantiation
    ref_crypto ref_unit (
    // System signals
    .clk(r_if.clk),
    .rst_n(r_if.rst_n),
    .size(r_if.size),
    .start(r_if.start), 
    // Individual data inputs
    .data_in_0(r_if.data_in_0),
    .data_in_1(r_if.data_in_1),
    .data_in_2(r_if.data_in_2),
    .data_in_3(r_if.data_in_3),
    .data_in_4(r_if.data_in_4),
    .data_in_5(r_if.data_in_5),
    .data_in_6(r_if.data_in_6),
    .data_in_7(r_if.data_in_7),
    .data_in_8(r_if.data_in_8),
    .data_in_9(r_if.data_in_9),
    .data_in_10(r_if.data_in_10),
    .data_in_11(r_if.data_in_11),
    .data_in_12(r_if.data_in_12),
    .data_in_13(r_if.data_in_13),
    .data_in_14(r_if.data_in_14),
    // Outputs
    .hash_out(r_if.hash_out),
    .done(r_if.done)
    );

    // crypto SVA 
    bind  DUT crypto_SVA CryptoAssertions (
    .clk(cry_if.clk),
    .rst_n(cry_if.rst_n),
    .size(cry_if.size),
    .start(cry_if.start),
    .done(cry_if.done),
    .hash_out(cry_if.hash_out)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end


    // UVM Interface Configuration
    initial begin
        uvm_config_db #(virtual crypto_if)::set(null, "uvm_test_top", "cryptoV", cry_if);
        uvm_config_db #(virtual ref_if)::set(null, "*", "refV", r_if);
        run_test("crypto_test");
    end

    //==================================================================
    // ref crypto interface connections (only inputs data members) 
    //==================================================================
    assign r_if.data_in_0     = cry_if.data_in_0;
    assign r_if.data_in_1     = cry_if.data_in_1;
    assign r_if.data_in_2     = cry_if.data_in_2;
    assign r_if.data_in_3     = cry_if.data_in_3;
    assign r_if.data_in_4     = cry_if.data_in_4;
    assign r_if.data_in_5     = cry_if.data_in_5;
    assign r_if.data_in_6     = cry_if.data_in_6;
    assign r_if.data_in_7     = cry_if.data_in_7;
    assign r_if.data_in_8     = cry_if.data_in_8;
    assign r_if.data_in_9     = cry_if.data_in_9;
    assign r_if.data_in_10    = cry_if.data_in_10;
    assign r_if.data_in_11    = cry_if.data_in_11;
    assign r_if.data_in_12    = cry_if.data_in_12;
    assign r_if.data_in_13    = cry_if.data_in_13;
    assign r_if.data_in_14    = cry_if.data_in_14;

    assign r_if.rst_n     = cry_if.rst_n;
    assign r_if.size      = cry_if.size;
    assign r_if.start     = cry_if.start;

endmodule