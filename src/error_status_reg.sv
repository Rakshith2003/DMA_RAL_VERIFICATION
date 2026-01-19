class ERROR_STATUS extends uvm_reg;
    `uvm_object_utils(ERROR_STATUS)
    
  rand uvm_reg_field bus_error;
  rand uvm_reg_field timeout_error;
  rand uvm_reg_field alignment_error;
  rand uvm_reg_field overflow_error;
  rand uvm_reg_field underflow_error;
  rand uvm_reg_field Reserved;
  rand uvm_reg_field error_code;
  rand uvm_reg_field error_addr_offset;
   
    function new(string name = "ERROR_STATUS");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      bus_error  = uvm_reg_field::type_id::create("bus_error");
      bus_error.configure(this, 1, 0, "RW1C", 0, 1'h0, 1, 1, 1);
      
      timeout_error  = uvm_reg_field::type_id::create("timeout_error");
      timeout_error.configure(this, 1, 1, "RW1C", 0, 1'h0, 1, 1, 1);
      
      alignment_error  = uvm_reg_field::type_id::create("alignment_error");
      alignment_error.configure(this, 1, 2, "RW1C", 0, 1'h0, 1, 1, 1);
      
      overflow_error  = uvm_reg_field::type_id::create("overflow_error");
      overflow_error.configure(this, 1, 3, "RW1C", 0, 1'h0, 1, 1, 1);
      
      underflow_error  = uvm_reg_field::type_id::create("underflow_error");
      underflow_error.configure(this, 1, 4, "RW1C", 0, 1'h0, 1, 1, 1);
      
      Reserved  = uvm_reg_field::type_id::create("Reserved");
      Reserved.configure(this, 3, 5, "RO", 0, 3'h0, 1, 1, 1);
      
      error_code  = uvm_reg_field::type_id::create("error_code");
      error_code.configure(this, 8, 8, "RO", 0, 8'h0, 1, 1, 1);
      
      error_addr_offset = uvm_reg_field::type_id::create("error_addr_offset");
      error_addr_offset.configure(this, 16, 16, "RO", 0, 16'h0, 1, 1, 1);
      
    endfunction 
 
endclass
