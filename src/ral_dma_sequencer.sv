class ral_dma_sequencer extends uvm_sequencer#(ral_dma_sequence_item);
`uvm_component_utils(ral_dma_sequencer)
	function new(string name = "ral_dma_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction
endclass
