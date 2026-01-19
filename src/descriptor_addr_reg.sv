class DESCRIPTOR_ADDR extends uvm_reg;
    `uvm_object_utils(DESCRIPTOR_ADDR)
    
    rand uvm_reg_field descriptor_addr;
   
    function new(string name = "DESCRIPTOR_ADDR");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      descriptor_addr  = uvm_reg_field::type_id::create("descriptor_addr");
      descriptor_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
