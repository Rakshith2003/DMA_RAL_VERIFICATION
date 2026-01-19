class CTRL extends uvm_reg;
    `uvm_object_utils(CTRL)
    
    rand uvm_reg_field start_dma;
    rand uvm_reg_field w_count;
    rand uvm_reg_field io_mem;
    rand uvm_reg_field Reserved;
  
   
    function new(string name = "CTRL");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      start_dma     = uvm_reg_field::type_id::create("start_dma");
      start_dma.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 1);
      
      w_count     = uvm_reg_field::type_id::create("w_count");
      w_count.configure(this, 15, 1, "RW", 0, 15'h0, 1, 1, 1);
      
      io_mem     = uvm_reg_field::type_id::create("io_mem");
      io_mem.configure(this, 1, 16, "RW", 0, 1'h0, 1, 1, 1);
      
      Reserved     = uvm_reg_field::type_id::create("Reserved");
      Reserved.configure(this, 15, 1, "RW", 0, 15'h0, 1, 1, 1);
      
    endfunction 
 
endclass
