class ral_dma_test extends uvm_test;
  `uvm_component_utils(ral_dma_test)
  function new( string name = "ral_dma_test", uvm_component parent);
		super.new(inst,parent);
  endfunction
ral_dma_environment env;
ral_dma_reg_sequence trseq;
  
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = ral_dma_environment::type_id::create("env",this);
	trseq = ral_dma_reg_sequence::type_id::create("trseq");
endfunction
  
virtual task run_phase(uvm_phase phase);
	phase.raise_objection(this);
  
	trseq.regmodel = e.regmodel;
  trseq.start(env.agent_inst.seqr);
  
	phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 20);
endtask
endclass
