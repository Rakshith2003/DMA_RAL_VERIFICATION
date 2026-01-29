class INTR extends uvm_reg;
				
    `uvm_object_utils(INTR)
    
    rand uvm_reg_field intr_status;
    rand uvm_reg_field intr_mask;
  
  covergroup intr_cg;
    option.per_instance = 1;

    intr_mask_cp : coverpoint intr_mask.value{
      
      bins low  = {[16'h0000:16'hFFFF]};

    }
  endgroup
   
    function new(string name = "INTR");
      super.new(name, 32, UVM_CVR_FIELD_VALS);
      if (has_coverage(UVM_CVR_FIELD_VALS))
      intr_cg = new();
    endfunction
  
   virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    intr_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    intr_cg.sample();
  endfunction
   
    virtual function void build();
      intr_status     = uvm_reg_field::type_id::create("intr_status");
      intr_status.configure(this, 16, 0, "RO", 0, 4'h1, 1, 1, 1);
      
      intr_mask     = uvm_reg_field::type_id::create("intr_mask");
      intr_mask.configure(this, 16, 16, "RW", 0, 16'h0, 1, 1, 1);
      
    endfunction 
 
endclass
