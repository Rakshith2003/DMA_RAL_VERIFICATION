class CONFIG extends uvm_reg;
    `uvm_object_utils(CONFIG)
    
  rand uvm_reg_field Priority;
  rand uvm_reg_field auto_restart;
  rand uvm_reg_field interrupt_enable;
  rand uvm_reg_field burst_size;
  rand uvm_reg_field data_width;
  rand uvm_reg_field descriptor_mode;
  rand uvm_reg_field Reserved;
   
   covergroup config_cg;
  option.per_instance = 1;
  // Priority: 2-bit
  priority_cp : coverpoint Priority.value {
    bins val = {0,1,2,3};
  }

  // Enable / mode bits
  auto_restart_cp : coverpoint auto_restart.value {
    bins off = {0};
    bins on  = {1};
  }

  interrupt_cp : coverpoint interrupt_enable.value {
    bins disabled = {0};
    bins enabled  = {1};
  }

  descriptor_cp : coverpoint descriptor_mode.value {
    bins off = {0};
    bins on  = {1};
  }

  // Performance-related fields
  burst_size_cp : coverpoint burst_size.value {
    bins b0 = {[0:3]};
  }

  data_width_cp : coverpoint data_width.value {
    bins w0 = {[0:3]};
  }

endgroup

  function new(string name = "CONFIG");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      config_cg = new();
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    config_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    config_cg.sample();
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
      descriptor_mode.configure(this, 1, 8, "RW", 0, 2'h0, 1, 1, 1);
      
      Reserved  = uvm_reg_field::type_id::create("Reserved");
      Reserved.configure(this, 22, 9, "RO", 0, 22'h0, 1, 1, 1);
      
    endfunction 
endclass

