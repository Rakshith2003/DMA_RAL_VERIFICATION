class ral_dma_driver extends uvm_driver #(ral_dma_sequence_item);
`uvm_component_utils(ral_dma_driver) 
  
  virtual dma_intf vif;
  ral_dma_transaction tr; 
  
  function new(string name = "ral_dma_driver", uvm_component parent = null);
        super.new(name, parent);
   endfunction  
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(virtual dma_intf)::get(this, "", "vif", vif))
        `uvm_error("DRV", "Error getting Interface Handle")
    endfunction 
        
    virtual task write();
        @(posedge vif.pclk);
        
    endtask 
  
    virtual task run_phase (uvm_phase phase);        
        forever begin
          seq_item_port.get_next_item (req);
          drive();
          seq_item_port.item_done ();
        end
    endtask 
      
      task drive();
        //driver logic
        
      endtask
endclass
      
