class MEM_ADDR extends uvm_reg;
    `uvm_object_utils(MEM_ADDR)
    
    rand uvm_reg_field mem_addr;
   
    function new(string name = "MEM_ADDR");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      mem_addr  = uvm_reg_field::type_id::create("mem_addr");
      mem_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
