class ral_dma_reg_block extends uvm_reg_block;
  `uvm_object_utils(ral_dma_reg_block)
  rand INTR intr_inst;
  rand CTRL ctrl_inst;
  rand IO_ADDR io_addr_inst;
  rand MEM_ADDR mem_addr_inst;
  rand EXTRA_INFO extra_info_inst;
  rand STATUS status_inst;
  rand TRANSFER_COUNT transfer_count_inst;
  rand DESCRIPTOR_ADDR descriptor_inst;
  rand ERROR_STATUS error_status_inst;
  rand CONFIG config_inst;

  function new(string name="ral_dma_reg_block");
    super.new(name,UVM_NO_COVERAGE);
  endfunction
  
  function void build();
    intr_inst=INTR::type_id::create("intr_inst");
    intr_inst.build();
    intr_inst.configure(this);
    
    ctrl_inst=CTRL::type_id::create("ctrl_inst");
    ctrl_inst.build();
    ctrl_inst.configure(this);
    
    io_addr_inst=IO_ADDR::type_id::create("io_addr_inst");
    io_addr_inst.build();
    io_addr_inst.configure(this);
    
    mem_addr_inst=MEM_ADDR::type_id::create("mem_addr_inst");
    mem_addr_inst.build();
    mem_addr_inst.configure(this);
    
    extra_info_inst=EXTRA_INFO::type_id::create("extra_info_inst");
    extra_info_inst.build();
    extra_info_inst.configure(this);
    
    status_inst=STATUS::type_id::create("status_inst");
    status_inst.build();
    status_inst.configure(this);
    
    transfer_count_inst=TRANSFER_COUNT::type_id::create("transfer_count_inst");
    transfer_count_inst.build();
    transfer_count_inst.configure(this);
    
    descriptor_inst=DESCRIPTOR_ADDR::type_id::create("descriptor_inst");
    descriptor_inst.build();
    descriptor_inst.configure(this);
    
    error_status_inst=ERROR_STATUS::type_id::create("error_status_inst");
    error_status_inst.build();
    error_status_inst.configure(this);
    
    config_inst=CONFIG::type_id::create("config_inst");
    config_inst.build();
    config_inst.configure(this);
    
    default_map = create_map("default_map",'h400,4,UVM_LITTLE_ENDIAN);
    
    default_map.add_reg(intr_inst, 'h00, "RO");  
	default_map.add_reg(ctrl_inst,'h04, "RW");
	default_map.add_reg(io_addr_inst,'h08, "RW");
	default_map.add_reg(mem_addr_inst,'h0C, "RW");
	default_map.add_reg(extra_info_inst,'h10, "RW");
	default_map.add_reg(status_inst,'h14, "RO");
	default_map.add_reg(transfer_count_inst,  'h18, "RO");
	default_map.add_reg(descriptor_inst, 'h1C, "RW");
    default_map.add_reg(error_status_inst, 'h20, "RW1C"); 
	default_map.add_reg(config_inst, 'h24, "RW");

    lock_model();
  endfunction
endclass

//sequencer

class ral_dma_sequencer extends uvm_sequencer#(ral_dma_transaction);
`uvm_component_utils(ral_dma_sequencer)
	function new(string name = "ral_dma_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction
endclass
