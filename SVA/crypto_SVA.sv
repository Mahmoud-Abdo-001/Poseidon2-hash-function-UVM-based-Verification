module crypto_SVA (
    input logic clk,
    input logic rst_n,
    input logic size,
    input logic start,
    input logic done ,
    input logic [255:0] hash_out
);
    
    //----------------------- reset behavior --------------------
    property crypto_reset_behavior();
       @(posedge clk) 
       !rst_n |=> (hash_out == '0 && !done) 
    endproperty
    assert property (crypto_reset_behavior)
        else $error("Reset should resets hash out");
	cove_crypto_reset_behavior : cover property(crypto_reset_behavior);

    // One to Fifteen Elements Behavior with Clock and Reset
    //------------------------------------------
    property one_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 1) |=> ##[1:$] $rose(done);
    endproperty
    assert property (one_element_behavior)
        else $error("Size 1: 'done' did not rise within 10 and 15 cycles");
    cover property (one_element_behavior);
    //------------------------------------------
    property two_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 2) |=> ##[1:$] $rose(done);
    endproperty
    assert property (two_element_behavior)
        else $error("Size 2: 'done' did not rise within 20 and 25 cycles");
    cover property (two_element_behavior);
    //------------------------------------------
    property three_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 3) |=> ##[1:$] $rose(done);
    endproperty
    assert property (three_element_behavior)
        else $error("Size 3: 'done' did not rise within 30 and 35 cycles");
    cover property (three_element_behavior);
    //------------------------------------------
    property four_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 4) |=> ##[1:$] $rose(done);
    endproperty
    assert property (four_element_behavior)
        else $error("Size 4: 'done' did not rise within 40 and 45 cycles");
    cover property (four_element_behavior);
    //------------------------------------------
    property five_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 5) |=> ##[1:$] $rose(done);
    endproperty
    assert property (five_element_behavior)
        else $error("Size 5: 'done' did not rise within 50 and 55 cycles");
    cover property (five_element_behavior);
    //------------------------------------------
    property six_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 6) |=> ##[1:$] $rose(done);
    endproperty
    assert property (six_element_behavior)
        else $error("Size 6: 'done' did not rise within 60 and 65 cycles");
    cover property (six_element_behavior);
    //------------------------------------------
    property seven_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 7) |=> ##[1:$] $rose(done);
    endproperty
    assert property (seven_element_behavior)
        else $error("Size 7: 'done' did not rise within 70 and 75 cycles");
    cover property (seven_element_behavior);
    //------------------------------------------
    property eight_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 8) |=> ##[1:$] $rose(done);
    endproperty
    assert property (eight_element_behavior)
        else $error("Size 8: 'done' did not rise within 80 and 85 cycles");
    cover property (eight_element_behavior);
    //------------------------------------------
    property nine_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 9) |=> ##[1:$] $rose(done);
    endproperty
    assert property (nine_element_behavior)
        else $error("Size 9: 'done' did not rise within 90 and 95 cycles");
    cover property (nine_element_behavior);
    //------------------------------------------
    property ten_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 10) |=> ##[1:$] $rose(done);
    endproperty
    assert property (ten_element_behavior)
        else $error("Size 10: 'done' did not rise within 100 and 105 cycles");
    cover property (ten_element_behavior);
    //------------------------------------------
    property eleven_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 11) |=> ##[1:$] $rose(done);
    endproperty
    assert property (eleven_element_behavior)
        else $error("Size 11: 'done' did not rise within 110 and 115 cycles");
    cover property (eleven_element_behavior);
    //------------------------------------------
    property twelve_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 12) |=> ##[1:$] $rose(done);
    endproperty
    assert property (twelve_element_behavior)
        else $error("Size 12: 'done' did not rise within 120 and 125 cycles");
    cover property (twelve_element_behavior);
    //------------------------------------------
    property thirteen_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 13) |=> ##[1:$] $rose(done);
    endproperty
    assert property (thirteen_element_behavior)
        else $error("Size 13: 'done' did not rise within 130 and 135 cycles");
    cover property (thirteen_element_behavior);
    //------------------------------------------
    property fourteen_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 14) |=> ##[1:$] $rose(done);
    endproperty
    assert property (fourteen_element_behavior)
        else $error("Size 14: 'done' did not rise within 140 and 145 cycles");
    cover property (fourteen_element_behavior);
    //------------------------------------------
    property fifteen_element_behavior();
        disable iff (!rst_n)
        @(posedge clk)
        ($rose(start) && size == 15) |=> ##[1:$] $rose(done);
    endproperty
    assert property (fifteen_element_behavior)
        else $error("Size 15: 'done' did not rise within 150 and 155 cycles");
    cover property (fifteen_element_behavior);





 
endmodule