class ral_dma_agent extends uvm_agent;
`uvm_component_utils(ral_dma_agent)
   function new( string name = "ral_dma_agent", uvm_component parent);
      super.new(name,parent);
   endfunction
ral_dma_driver drv;
ral_dma_sequencer seqr;
ral_dma_monitor mon;
   
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      drv = ral_dma_driver::type_id::create("drv",this);
      mon = ral_dma_monitor::type_id::create("mon",this);
      seqr = ral_dma_sequencer::type_id::create("seqr", this); 
	endfunction
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction
   
endclass
