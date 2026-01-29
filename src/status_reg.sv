class STATUS extends uvm_reg;
    `uvm_object_utils(STATUS)
    
    rand uvm_reg_field busy;
   rand uvm_reg_field done;
  rand uvm_reg_field error;
  rand uvm_reg_field paused;
  rand uvm_reg_field current_state;
  rand uvm_reg_field fifo_level;
  rand uvm_reg_field Reserved;
   
  

  function new(string name = "STATUS");
    super.new(name, 32, UVM_NO_COVERAGE);

  endfunction

  
   
    virtual function void build();
      busy  = uvm_reg_field::type_id::create("busy");
      busy.configure(this, 1, 0, "RO", 0, 1'h0, 1, 1, 1);
      
      done  = uvm_reg_field::type_id::create("done");
      done.configure(this, 1, 1, "RO", 0, 1'h0, 1, 1, 1);
      
      error  = uvm_reg_field::type_id::create("error");
      error.configure(this, 1, 2, "RO", 0, 1'h0, 1, 1, 1);
      
      paused  = uvm_reg_field::type_id::create("paused");
      paused.configure(this, 1, 3, "RO", 0, 1'h0, 1, 1, 1);
      
      current_state  = uvm_reg_field::type_id::create("current_state");
      current_state.configure(this, 4, 4, "RO", 0, 4'h0, 1, 1, 1);
      
      fifo_level  = uvm_reg_field::type_id::create("fifo_level");
      fifo_level.configure(this, 8, 8, "RO", 0, 8'h0, 1, 1, 1);
      
      Reserved  = uvm_reg_field::type_id::create("Reserved");
      Reserved.configure(this, 16, 16, "RO", 0, 16'h0, 1, 1, 1);
      
    endfunction 
 
endclass
