class TRANSFER_COUNT extends uvm_reg;
    `uvm_object_utils(TRANSFER_COUNT)
    
    rand uvm_reg_field transfer_count;
   
   covergroup transfer_count_cg;
    option.per_instance = 1;

    transfer_count_cp : coverpoint transfer_count.value {
      bins zero  = {32'h0};
      bins low = {[1:16]};
      bins mid   = {[17:1023]};
      bins high = {[1024:32'hFFFF_FFFF]};
    }
  endgroup

  function new(string name = "TRANSFER_COUNT");
    super.new(name, 32, UVM_CVR_FIELD_VALS);
    if (has_coverage(UVM_CVR_FIELD_VALS))
      transfer_count_cg = new();
  endfunction

  virtual function void sample(uvm_reg_data_t data,
                               uvm_reg_data_t byte_en,
                               bit is_read,
                               uvm_reg_map map);
    transfer_count_cg.sample();
  endfunction

  virtual function void sample_values();
    super.sample_values();
    transfer_count_cg.sample();
  endfunction
   
    virtual function void build();
      transfer_count  = uvm_reg_field::type_id::create("transfer_count");
      transfer_count.configure(this, 32, 0, "RO", 0, 32'h0, 1, 1, 1);
      
    endfunction 
 
endclass
