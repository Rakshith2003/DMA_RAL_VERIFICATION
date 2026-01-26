class ral_dma_predictor#(type BUSTYPE = int) extends uvm_reg_predictor#(ral_dma_sequence_item);
				  `uvm_component_param_utils(ral_dma_predictor#(BUSTYPE))
				  
				  function new(string name = "ral_dma_predictor", uvm_component parent = null);
									    super.new(name, parent);
									  endfunction
										  
										  virtual function void write(ral_dma_sequence_item tr);
															    uvm_reg rg;
															    uvm_reg_bus_op rw;
															    
															    super.write(tr);
															    
															    adapter.bus2reg(tr, rw);
															    rg = map.get_reg_by_offset(rw.addr, (rw.kind == UVM_READ));
															    
															    rg.sample_values();
															  endfunction
																  
endclass
    
