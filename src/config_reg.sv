class CONFIG extends uvm_reg;
    `uvm_object_utils(CONFIG)
    
  rand uvm_reg_field Priority;
  rand uvm_reg_field auto_restart;
  rand uvm_reg_field interrupt_enable;
  rand uvm_reg_field burst_size;
  rand uvm_reg_field data_width;
  rand uvm_reg_field descriptor_mode;
  rand uvm_reg_field Reserved;
   
    function new(string name = "CONFIG");
      super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
      Priority  = uvm_reg_field::type_id::create("Priority");
      Priority.configure(this, 2, 0, "RW", 0, 2'h0, 1, 1, 1);
      
      auto_restart  = uvm_reg_field::type_id::create("auto_restart");
      auto_restart.configure(this, 1, 2, "RW", 0, 1'h0, 1, 1, 1);
      
      interrupt_enable  = uvm_reg_field::type_id::create("interrupt_enable");
      interrupt_enable.configure(this, 1, 3, "RW", 0, 1'h0, 1, 1, 1);
      
      burst_size  = uvm_reg_field::type_id::create("burst_size");
      burst_size.configure(this, 2, 4, "RW", 0, 2'h0, 1, 1, 1);
      
      data_width  = uvm_reg_field::type_id::create("data_width");
      data_width.configure(this, 2, 6, "RW", 0, 2'h0, 1, 1, 1);
      
      descriptor_mode  = uvm_reg_field::type_id::create("descriptor_mode");
      descriptor_mode.configure(this, 2, 0, "RW", 0, 2'h0, 1, 1, 1);
      
      Reserved  = uvm_reg_field::type_id::create("Reserved");
      Reserved.configure(this, 22, 9, "RO", 0, 22'h0, 1, 1, 1);
      
    endfunction 
endclass
