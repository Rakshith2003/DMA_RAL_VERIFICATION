class CTRL extends uvm_reg;
    `uvm_object_utils(CTRL)
    
    rand uvm_reg_field start_dma;
    rand uvm_reg_field w_count;
    rand uvm_reg_field io_mem;
    rand uvm_reg_field Reserved;
   covergroup ctrl_cg;
    option.per_instance = 1;

    start_cp : coverpoint start_dma.value {bins zero = {0}; bins one = {1};}

    io_mem_cp : coverpoint io_mem.value {bins io = {0}; bins mem = {1};}

    w_count_cp : coverpoint w_count.value {
      bins low = {[0:15]};
      bins mid  = {[16:255]};
      bins high  = {[256:32767]};
    }
  endgroup
   
    function new(string name = "CTRL");
      super.new(name, 32, UVM_CVR_FIELD_VALS);
      if (has_coverage(UVM_CVR_FIELD_VALS))
      ctrl_cg = new();
    endfunction
  
  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    ctrl_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    ctrl_cg.sample();
  endfunction
   
    virtual function void build();
      start_dma     = uvm_reg_field::type_id::create("start_dma");
      start_dma.configure(this, 1, 0, "RW", 0, 1'h0, 1, 1, 1);
      
      w_count     = uvm_reg_field::type_id::create("w_count");
      w_count.configure(this, 15, 1, "RW", 0, 15'h0, 1, 1, 1);
      
      io_mem     = uvm_reg_field::type_id::create("io_mem");
      io_mem.configure(this, 1, 16, "RW", 0, 1'h0, 1, 1, 1);
      
      Reserved     = uvm_reg_field::type_id::create("Reserved");
      Reserved.configure(this, 15, 17, "RO", 0, 15'h0, 1, 1, 1);
      
    endfunction 
 
endclass
