class ral_dma_monitor extends uvm_monitor;
  virtual dma_intf vif;
  uvm_analysis_port #(ral_dma_sequence_item) item_collected_port;
  ral_dma_transaction seq_item;

  `uvm_component_utils(ral_dma_monitor)

  function new (string name="ral_dma_monitor", uvm_component parent);
    super.new(name, parent);
    seq_item = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dma_intf)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    
   forever begin
     repeat(1)@(posedge vif.mon_cb);
     
     
      item_collected_port.write(seq_item); 
   end
  endtask
endclass
