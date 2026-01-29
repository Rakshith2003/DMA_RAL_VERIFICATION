class ral_dma_reg_block extends uvm_reg_block;
  `uvm_object_utils(ral_dma_reg_block)

  rand INTR             intr_inst;
  rand CTRL             ctrl_inst;
  rand IO_ADDR          io_addr_inst;
  rand MEM_ADDR         mem_addr_inst;
  rand EXTRA_INFO       extra_info_inst;
  rand STATUS           status_inst;
  rand TRANSFER_COUNT   transfer_count_inst;
  rand DESCRIPTOR_ADDR  descriptor_inst;
  rand ERROR_STATUS     error_status_inst;
  rand CONFIG           config_inst;

  function new(string name = "ral_dma_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  function void build();
     
    uvm_reg::include_coverage("*", UVM_CVR_ALL);
    
    intr_inst = INTR::type_id::create("intr_inst");
    intr_inst.build();
    intr_inst.configure(this);
    intr_inst.add_hdl_path_slice("intr_mask",   16, 16);
	intr_inst.add_hdl_path_slice("intr_status", 0,  16);
    intr_inst.set_coverage(UVM_CVR_FIELD_VALS);
    
    ctrl_inst = CTRL::type_id::create("ctrl_inst");
    ctrl_inst.build();
    ctrl_inst.configure(this);
    ctrl_inst.add_hdl_path_slice("ctrl_start_dma", 0, 1);
    ctrl_inst.add_hdl_path_slice("ctrl_w_count",   1, 15);
    ctrl_inst.add_hdl_path_slice("ctrl_io_mem",   16, 1);
    ctrl_inst.set_coverage(UVM_CVR_FIELD_VALS);

    io_addr_inst = IO_ADDR::type_id::create("io_addr_inst");
    io_addr_inst.build();
    io_addr_inst.configure(this);
    io_addr_inst.add_hdl_path_slice("io_addr", 0, 32);
    io_addr_inst.set_coverage(UVM_CVR_FIELD_VALS);

    mem_addr_inst = MEM_ADDR::type_id::create("mem_addr_inst");
    mem_addr_inst.build();
    mem_addr_inst.configure(this);
    mem_addr_inst.add_hdl_path_slice("mem_addr", 0, 32);
    //mem_addr_inst.set_coverage(UVM_CVR_FIELD_VALS);

    extra_info_inst = EXTRA_INFO::type_id::create("extra_info_inst");
    extra_info_inst.build();
    extra_info_inst.configure(this);
    extra_info_inst.add_hdl_path_slice("extra_info", 0, 32);
    extra_info_inst.set_coverage(UVM_CVR_FIELD_VALS);

    status_inst = STATUS::type_id::create("status_inst");
    status_inst.build();
    status_inst.configure(this);
    status_inst.add_hdl_path_slice("status_busy",          0, 1);
    status_inst.add_hdl_path_slice("status_done",          1, 1);
    status_inst.add_hdl_path_slice("status_error",         2, 1);
    status_inst.add_hdl_path_slice("status_paused",        3, 1);
    status_inst.add_hdl_path_slice("status_current_state", 4, 4);
    status_inst.add_hdl_path_slice("status_fifo_level",    8, 8);
    status_inst.set_coverage(UVM_CVR_FIELD_VALS);

    transfer_count_inst = TRANSFER_COUNT::type_id::create("transfer_count_inst");
    transfer_count_inst.build();
    transfer_count_inst.configure(this);
    transfer_count_inst.add_hdl_path_slice("transfer_count", 0, 32);
   // transfer_count_inst.set_coverage(UVM_CVR_FIELD_VALS);

    descriptor_inst = DESCRIPTOR_ADDR::type_id::create("descriptor_inst");
    descriptor_inst.build();
    descriptor_inst.configure(this);
    descriptor_inst.add_hdl_path_slice("descriptor_addr", 0, 32);
    descriptor_inst.set_coverage(UVM_CVR_FIELD_VALS);

    error_status_inst = ERROR_STATUS::type_id::create("error_status_inst");
    error_status_inst.build();
    error_status_inst.configure(this);
    error_status_inst.add_hdl_path_slice("error_bus",          0, 1);
    error_status_inst.add_hdl_path_slice("error_timeout",      1, 1);
    error_status_inst.add_hdl_path_slice("error_alignment",    2, 1);
    error_status_inst.add_hdl_path_slice("error_overflow",     3, 1);
    error_status_inst.add_hdl_path_slice("error_underflow",    4, 1);
    error_status_inst.add_hdl_path_slice("error_code",         8, 8);
    error_status_inst.add_hdl_path_slice("error_addr_offset", 16, 16);
    //error_status_inst.set_coverage(UVM_CVR_FIELD_VALS);

    config_inst = CONFIG::type_id::create("config_inst");
    config_inst.build();
    config_inst.configure(this);
    config_inst.add_hdl_path_slice("config_priority",         0, 2);
    config_inst.add_hdl_path_slice("config_auto_restart",     2, 1);
    config_inst.add_hdl_path_slice("config_interrupt_enable", 3, 1);
    config_inst.add_hdl_path_slice("config_burst_size",       4, 2);
    config_inst.add_hdl_path_slice("config_data_width",       6, 2);
    config_inst.add_hdl_path_slice("config_descriptor_mode",  8, 1);
    config_inst.set_coverage(UVM_CVR_FIELD_VALS);
    

    default_map = create_map("default_map", 'h400, 4, UVM_LITTLE_ENDIAN);

    default_map.add_reg(intr_inst,           'h00, "RW");
    default_map.add_reg(ctrl_inst,           'h04, "RW");
    default_map.add_reg(io_addr_inst,        'h08, "RW");
    default_map.add_reg(mem_addr_inst,       'h0C, "RW");
    default_map.add_reg(extra_info_inst,     'h10, "RW");
    default_map.add_reg(status_inst,         'h14, "RO");
    default_map.add_reg(transfer_count_inst, 'h18, "RO");
    default_map.add_reg(descriptor_inst,     'h1C, "RW");
    default_map.add_reg(error_status_inst,   'h20, "RW");
    default_map.add_reg(config_inst,         'h24, "RW");

    add_hdl_path ("top.dut", "RTL");
    lock_model();
  endfunction

endclass
