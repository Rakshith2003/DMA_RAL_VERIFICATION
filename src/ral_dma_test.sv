
class dma_base_test extends uvm_test;
  ral_dma_environment env;
  `uvm_component_utils(dma_base_test)
  
  function new(string name="dma_base_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=ral_dma_environment::type_id::create("env",this);

  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
endclass

class dma_reset_test extends dma_base_test;

  `uvm_component_utils(dma_reset_test)

  function new(string name="dma_reset_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    reset_check_sequence trseq;
    phase.raise_objection(this);

    trseq = reset_check_sequence::type_id::create("trseq");
    trseq.regmodel = env.regmodel;
    trseq.start(env.agent_inst.seqr);
     phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
    
  endtask
endclass



class intr_reg_test extends dma_base_test;

  `uvm_component_utils(intr_reg_test)

  function new(string name="intr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    intr_reg_seq trseq;
    phase.raise_objection(this);

    trseq = intr_reg_seq::type_id::create("trseq");
    trseq.regmodel = env.regmodel;
    trseq.start(env.agent_inst.seqr);
     phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
    
  endtask
endclass

//ctrl test
class ctrl_reg_test extends dma_base_test;
  `uvm_component_utils(ctrl_reg_test)

  function new(string name="ctrl_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ctrl_reg_seq seq;

    phase.raise_objection(this);

    seq = ctrl_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

//io_addr test
class io_addr_reg_test extends dma_base_test;
  `uvm_component_utils(io_addr_reg_test)

  function new(string name="io_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    io_addr_reg_seq seq;

    phase.raise_objection(this);

    seq = io_addr_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

//mem addr

class mem_addr_reg_test extends dma_base_test;
  `uvm_component_utils(mem_addr_reg_test)

  function new(string name="mem_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    mem_addr_reg_seq seq;

    phase.raise_objection(this);

    seq = mem_addr_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

//extra info 

class extra_info_reg_test extends dma_base_test;
  `uvm_component_utils(extra_info_reg_test)

  function new(string name="extra_info_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    extra_info_reg_seq seq;

    phase.raise_objection(this);

    seq = extra_info_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

//status reg test

class status_reg_test extends dma_base_test;
  `uvm_component_utils(status_reg_test)

  function new(string name="status_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    status_reg_seq seq;

    phase.raise_objection(this);

    seq = status_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass



//transfer reg test

class transfer_count_reg_test extends dma_base_test;
  `uvm_component_utils(transfer_count_reg_test)

  function new(string name="transfer_count_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    transfer_count_reg_seq seq;

    phase.raise_objection(this);

    seq = transfer_count_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass


//descriptor addr test

class descriptor_addr_reg_test extends dma_base_test;
  `uvm_component_utils(descriptor_addr_reg_test)

  function new(string name="descriptor_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    descriptor_addr_reg_seq seq;

    phase.raise_objection(this);

    seq = descriptor_addr_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

//error stats test

class error_status_reg_test extends dma_base_test;
  `uvm_component_utils(error_status_reg_test)

  function new(string name="error_status_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    error_status_reg_seq seq;

    phase.raise_objection(this);

    seq = error_status_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

//config reg test

class config_reg_test extends dma_base_test;
  `uvm_component_utils(config_reg_test)

  function new(string name="config_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    config_reg_seq seq;

    phase.raise_objection(this);

    seq = config_reg_seq::type_id::create("seq");
    seq.regmodel = env.regmodel;
    seq.start(env.agent_inst.seqr);

    phase.phase_done.set_drain_time(this, 20);
    phase.drop_objection(this);
  endtask
endclass

class dma_regression_test extends dma_base_test;
  `uvm_component_utils(dma_regression_test)

  function new(string name="dma_regression_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    regression_seq reg_seq;

    phase.raise_objection(this);

    reg_seq = regression_seq::type_id::create("reg_seq");
    reg_seq.regmodel = env.regmodel;
    reg_seq.start(env.agent_inst.seqr);
    phase.phase_done.set_drain_time(this, 20);

    phase.drop_objection(this);
  endtask
endclass

/*class intr_dma_test extends uvm_test;
  `uvm_component_utils(intr_dma_test)
  function new( string name = "intr_dma_test", uvm_component parent);
		super.new(name,parent);
  endfunction
ral_dma_environment env;
top_reg_seq trseq;
  
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = ral_dma_environment::type_id::create("env",this);
	trseq = top_reg_seq::type_id::create("trseq");
endfunction
  
virtual task run_phase(uvm_phase phase);
	phase.raise_objection(this);
  
	trseq.regmodel = env.regmodel;
  trseq.start(env.agent_inst.seqr);
  
	phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 20);
endtask
endclass

class ctrl_dma_test extends intr_dma_test;
  `uvm_component_utils(ctrl_dma_test)
  function new( string name = "ctrl_dma_test", uvm_component parent);
		super.new(name,parent);
  endfunction
ctrl_reg_seq trseq;
  
  
virtual task run_phase(uvm_phase phase);
	phase.raise_objection(this);
  
	trseq = ctrl_reg_seq::type_id::create("trseq");
	trseq.regmodel = env.regmodel;
  trseq.start(env.agent_inst.seqr);
  
	phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 20);
endtask
endclass
*/
