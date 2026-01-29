class TRANSFER_COUNT extends uvm_reg;
    `uvm_object_utils(TRANSFER_COUNT)
    
    rand uvm_reg_field transfer_count;
   
   

  function new(string name = "TRANSFER_COUNT");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  
   
    virtual function void build();
      transfer_count  = uvm_reg_field::type_id::create("transfer_count");
      transfer_count.configure(this, 32, 0, "RO", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
