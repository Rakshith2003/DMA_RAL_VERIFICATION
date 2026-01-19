class ral_dma_sequence_item extends uvm_sequence_item;
  `uvm_object_utils( ral_dma_sequence_item )
//    input  logic       clk,
//    input  logic       rst_n,
  
   // Register Interface
   rand  logic       wr_en;
   rand  logic       rd_en;
  rand  logic [31:0] wdata;
  rand  logic [31:0] addr;
  logic [31:0] rdata;
   
  
    function new(string name = "ral_dma_sequence_item");
       super.new(name);
    endfunction 
 
endclass
