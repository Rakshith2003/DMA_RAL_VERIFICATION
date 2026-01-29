class EXTRA_INFO extends uvm_reg;
    `uvm_object_utils(EXTRA_INFO)
    
    rand uvm_reg_field extra_info;
   
  covergroup extra_info_cg;
    option.per_instance = 1;

    info_cp : coverpoint extra_info.value {
      //bins zero = {32'h0};
      bins val = {[32'h0:32'hFFFF_FFFF]};
    }
  endgroup
  
  function new(string name = "EXTRA_INFO");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      extra_info_cg = new();
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    extra_info_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    extra_info_cg.sample();
  endfunction
   
    virtual function void build();
      extra_info  = uvm_reg_field::type_id::create("extra_info");
      extra_info.configure(this, 32, 0, "RW", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
