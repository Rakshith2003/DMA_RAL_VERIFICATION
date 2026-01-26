class ral_dma_sequence_item extends uvm_sequence_item;
  
//    input  logic       clk,
//    input  logic       rst_n,
  
   // Register Interface
   rand  logic       wr_en;
   rand  logic       rd_en;
  rand  logic [31:0] wdata;
  rand  logic [31:0] addr;
  logic [31:0] rdata;
				time timestamp;
				string monitor_name;
   `uvm_object_utils_begin( ral_dma_sequence_item )
    
				`uvm_field_string(monitor_name, UVM_ALL_ON)
				`uvm_field_int(wr_en,UVM_DEC)
    `uvm_field_int(rd_en,UVM_DEC)
    `uvm_field_int(wdata,UVM_DEC)
  `uvm_field_int(addr,UVM_DEC)
    `uvm_field_int(rdata, UVM_DEC)
   `uvm_field_int(timestamp, UVM_DEC)
				
				`uvm_object_utils_end
  
    function new(string name = "ral_dma_sequence_item");
       super.new(name);
    endfunction 
 
endclass
