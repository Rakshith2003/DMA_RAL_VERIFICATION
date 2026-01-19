class IO_ADDR extends uvm_reg;
    `uvm_object_utils(IO_ADDR)
    
    rand uvm_reg_field io_addr;
   
    function new(string name = "IO_ADDR");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      io_addr  = uvm_reg_field::type_id::create("io_addr");
      io_addr.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
