  class ral_dma_adapter extends uvm_reg_adapter;
  `uvm_object_utils (ral_dma_adapter)

  function new (string name = "ral_dma_adapter");
      super.new (name);
   endfunction
  
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    ral_dma_sequence_item tx;    
    tx = ral_dma_sequence_item::type_id::create("tx");
    
    tx.wr_en = (rw.kind == UVM_WRITE);
	 tx.rd_en=(rw.kind==UVM_READ);
    tx.addr  = rw.addr;
  
      tx.wdata =(rw.kind==UVM_WRITE)? rw.data:0;


    //if (tx.wr_en)  $display("[Adapter: reg2bus] WR: Addr=%0h, Data=%0h",tx.addr,tx.wdata);
    //if (!tx.wr_en) $display("[Adapter: reg2bus] RD: Addr=%0h",tx.addr);
    return tx;
  endfunction

  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    ral_dma_sequence_item tx;
    
    assert( $cast(tx, bus_item) )
      else `uvm_fatal("", "A bad thing has just happened in my_adapter")

    rw.addr = tx.addr;
    rw.status = UVM_IS_OK;
    if(tx.wr_en)
		begin
						rw.data=tx.wdata;
						rw.kind=UVM_WRITE;
		end
					if(tx.rd_en)
					begin
									rw.data=tx.rdata;
									rw.kind=UVM_READ;
					end

    //if(rw.kind == UVM_READ) $display("[Adapter: bus2reg] RD: Addr=%0h, Data=%0h",tx.addr,tx.rdata);
  endfunction
endclass    
