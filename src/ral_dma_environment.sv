class ral_dma_environment extends uvm_env;
`uvm_component_utils(ral_dma_environment)
ral_dma_agent agent_inst;
ral_dma_reg_block regmodel; 
ral_dma_adapter adapter_inst;
uvm_reg_predictor #(ral_dma_transaction) predictor_inst; 
ral_dma_scoreboard score;
  
function new(string name = "ral_dma_environment", uvm_component parent);
	super.new(name, parent);
endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		predictor_inst = uvm_reg_predictor#(transaction)::type_id::create("predictor_inst", this);
		agent_inst = ral_dma_agent::type_id::create("agent_inst", this);
		score = ral_dma_scoreboard::type_id::create("score", this);
      
		regmodel = ral_dma_reg_block::type_id::create("regmodel", this);
		regmodel.build();
      
		adapter_inst = ral_dma_adapter::type_id::create("adapter_inst",, get_full_name());
	endfunction

	function void connect_phase(uvm_phasephase);
		super.connect_phase(phase);
      agent_inst.mon.item_collected_port.connect(s.item_collected_export);    
      regmodel.default_map.set_sequencer(.sequencer(agent_inst.seqr), .adapter(adapter_inst) );
	  regmodel.default_map.set_base_addr(0);
      
      predictor_inst.map= regmodel.default_map;
      predictor_inst.adapter= adapter_inst;

      agent_inst.mon.item_collected_port.connect(predictor_inst.bus_in);
      regmodel.default_map.set_auto_predict(0);
endfunction
endclass
