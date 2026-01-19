class EXTRA_INFO extends uvm_reg;
    `uvm_object_utils(EXTRA_INFO)
    
    rand uvm_reg_field extra_info;
   
    function new(string name = "EXTRA_INFO");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      extra_info  = uvm_reg_field::type_id::create("extra_info");
      extra_info.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
