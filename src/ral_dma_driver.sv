class ral_dma_driver extends uvm_driver #(ral_dma_sequence_item);
 `uvm_component_utils(ral_dma_driver) 
  
  virtual ral_dma_intf vif;
  ral_dma_sequence_item tr; 
  
  function new(string name = "ral_dma_driver", uvm_component parent = null);
        super.new(name, parent);
   endfunction  
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(virtual ral_dma_intf)::get(this, "", "vif", vif))
        `uvm_error("DRV", "Error getting Interface Handle")
    endfunction 
 
  
    virtual task run_phase (uvm_phase phase);  
      repeat(1)@(posedge vif.drv_cb);
        forever begin
          seq_item_port.get_next_item (req);
          drive();
          seq_item_port.item_done ();
        end
    endtask 

        task drive();
        //driver logic
	//							$display("driver task t=%t wr=%d add=%d",$time,req.wr_en,req.addr);
	vif.drv_cb.rd_en <= req.rd_en;
	vif.drv_cb.wr_en <= req.wr_en;
	vif.drv_cb.addr  <= req.addr;
	if(req.wr_en && !req.rd_en) //write
	begin
	repeat(1)@(posedge vif.drv_cb);
	vif.drv_cb.wdata <= req.wdata;
	`uvm_info(" DRV WRITE ", $sformatf("\n WR_EN = %0h | RD_EN = %0h | ADDR = %0h | WDATA = %0h | \n", req.wr_en, req.rd_en, req.addr, req.wdata), UVM_LOW)
        repeat(2)@(posedge vif.drv_cb);
	end 
	else 
	vif.drv_cb.wdata <= 0;
												        
	if(!req.wr_en && req.rd_en) //read
	begin
          repeat(2)@(posedge vif.drv_cb);
          req.rdata = vif.drv_cb.rdata;
          `uvm_info(" DRV READ ", $sformatf("\n WR_EN = %0d | RD_EN = %0d | ADDR = %0h | WDATA = %0h | RDATA = %0h  \n", req.wr_en, req.rd_en, req.addr, req.wdata, req.rdata), UVM_LOW)
	  repeat(1)@(posedge vif.drv_cb);
        end
				endtask
        /*repeat(1)@(posedge vif.drv_cb);
        if(req.wr_en && !req.rd_en)
	begin
	vif.drv_cb.addr  <= req.addr;
	vif.drv_cb.wr_en <= req.wr_en;
	vif.drv_cb.rd_en <= req.rd_en;
        vif.drv_cb.wdata <= req.wdata;
        `uvm_info(" DRV WRITE ", $sformatf("\n WR_EN = %0h | RD_EN = %0h | ADDR = %0h | WDATA = %0h | \n", req.wr_en, req.rd_en, req.addr, req.wdata), UVM_LOW)
	repeat(2)@(posedge vif.drv_cb);
	end
	
	if(!req.wr_en && req.rd_en) //read
	begin
          repeat(2)@(posedge vif.drv_cb);
          req.rdata = vif.drv_cb.rdata;
          `uvm_info(" DRV READ ", $sformatf("\n WR_EN = %0d | RD_EN = %0d | ADDR = %0h | WDATA = %0h | RDATA = %0h  \n", req.wr_en, req.rd_en, req.addr, req.wdata, req.rdata), UVM_LOW)
	  
        end
    endtask*/
  /*    repeat(1)@(posedge vif.drv_cb);
        
         vif.drv_cb.wr_en<=req.wr_en;
         vif.drv_cb.rd_en<=req.rd_en;
         vif.drv_cb.wdata<=req.wdata;
         vif.drv_cb.addr<=req.addr;
				 req.timestamp    = $time; 
				 req.monitor_name = get_full_name();
         //vif.drv_cb.rdata<=req.rdata;
 //       `uvm_info(get_type_name,$sformatf("wr_en=%d rd_en=%d wdata=%d addr=%d rdata=%d",req.wr_en,req.rd_en,req.wdata,req.addr,req.rdata),UVM_LOW);
        req.print();
        repeat(2)@(posedge vif.drv_cb);
      endtask*/
endclass
