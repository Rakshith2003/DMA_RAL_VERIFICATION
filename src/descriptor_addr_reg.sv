class DESCRIPTOR_ADDR extends uvm_reg;
    `uvm_object_utils(DESCRIPTOR_ADDR)
    
    rand uvm_reg_field descriptor_addr;
   
  covergroup descriptor_addr_cg;
  option.per_instance = 1;


  addr_cp : coverpoint descriptor_addr.value[1:0] {
  bins aligned_4B = {2'b00};
  bins unaligned_4B = {2'b01, 2'b10, 2'b11};
  }
  endgroup

  function new(string name = "DESCRIPTOR_ADDR");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      descriptor_addr_cg = new();
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    descriptor_addr_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    descriptor_addr_cg.sample();
  endfunction
   
    virtual function void build();
      descriptor_addr  = uvm_reg_field::type_id::create("descriptor_addr");
      descriptor_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
