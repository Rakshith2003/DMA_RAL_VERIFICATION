class INTR extends uvm_reg;
    `uvm_object_utils(INTR)
    
    rand uvm_reg_field intr_status;
    rand uvm_reg_field intr_mask;
  
   
    function new(string name = "INTR");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      intr_status     = uvm_reg_field::type_id::create("intr_status");
      intr_status.configure(this, 16, 0, "RO", 0, 4'h0, 1, 1, 1);
      
      intr_mask     = uvm_reg_field::type_id::create("intr_mask");
      intr_mask.configure(this, 16, 16, "RW", 0, 16'h0, 1, 1, 1);
      
    endfunction 
 
endclass
