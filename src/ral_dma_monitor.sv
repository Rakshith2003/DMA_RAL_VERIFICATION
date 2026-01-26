class ral_dma_monitor extends uvm_monitor;
  virtual ral_dma_intf vif;
  uvm_analysis_port #(ral_dma_sequence_item) item_collected_port;
  ral_dma_sequence_item seq_item;

  `uvm_component_utils(ral_dma_monitor)

  function new (string name="ral_dma_monitor", uvm_component parent);
    super.new(name, parent);
    seq_item = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ral_dma_intf)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
  
        repeat(1)@(vif.mon_cb);
        forever begin
            seq_item = ral_dma_sequence_item::type_id::create("seq_item");
            repeat(3)@(vif.mon_cb);

            seq_item.wr_en = vif.mon_cb.wr_en;
            seq_item.rd_en = vif.mon_cb.rd_en;
            seq_item.wdata = vif.mon_cb.wdata;
            seq_item.addr  = vif.mon_cb.addr;
            seq_item.rdata = vif.mon_cb.rdata;

            `uvm_info("MON ", $sformatf("\n WR_EN = %0h | RD_EN = %0h | ADDR =%0h | WDATA = %0h | RDATA = %0h \n", seq_item.wr_en, seq_item.rd_en, seq_item.addr, seq_item.wdata, seq_item.rdata ), UVM_LOW)
          //repeat(1)@(vif.mon_cb);
            item_collected_port.write(seq_item);
        end


/*repeat(2)@(posedge vif.mon_cb);
   forever begin
	seq_item = ral_dma_sequence_item::type_id::create("seq_item");
         repeat(2)@(posedge vif.mon_cb);
         seq_item.wr_en=vif.mon_cb.wr_en;
         seq_item.rd_en=vif.mon_cb.rd_en;
         seq_item.wdata=vif.mon_cb.wdata;
         seq_item.addr=vif.mon_cb.addr;
         seq_item.rdata=vif.mon_cb.rdata;
	 			// seq_item.timestamp    = $time; 
	       //seq_item.monitor_name = get_full_name();
     `uvm_info("MON ", $sformatf("\n WR_EN = %0h | RD_EN = %0h | ADDR =%0h | WDATA = %0h | RDATA = %0h \n", seq_item.wr_en, seq_item.rd_en, seq_item.addr, seq_item.wdata, seq_item.rdata ), UVM_LOW)
         repeat(1)@(posedge vif.mon_cb);
   
      item_collected_port.write(seq_item);
	 end*/
  endtask
endclass
