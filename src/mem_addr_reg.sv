class MEM_ADDR extends uvm_reg;
    `uvm_object_utils(MEM_ADDR)
    
    rand uvm_reg_field mem_addr;
   
  covergroup mem_addr_cg;
  option.per_instance = 1;
  addr_align_cp : coverpoint mem_addr.value[1:0] {
  bins aligned_4B = {2'b00};
  bins unaligned_4B = {2'b01, 2'b10, 2'b11};
  }
  endgroup
  
  function new(string name = "MEM_ADDR");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      mem_addr_cg = new();
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    mem_addr_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    mem_addr_cg.sample();
  endfunction
   
    virtual function void build();
      mem_addr  = uvm_reg_field::type_id::create("mem_addr");
      mem_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
