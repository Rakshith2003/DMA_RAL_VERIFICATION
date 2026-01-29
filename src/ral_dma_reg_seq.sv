
class top_reg_seq extends uvm_sequence;
      `uvm_object_utils(top_reg_seq)

        ral_dma_reg_block regmodel;

        function new(string name = "top_reg_seq");
                super.new(name);
        endfunction

        task body();
                `uvm_info(get_type_name(), "Base RAL sequence started (no register access)", UVM_LOW)

        endtask

        
        task do_write(uvm_reg r, uvm_reg_data_t data);
                uvm_status_e status;
                r.write(.status(status), .value(data), .parent(this));
                `uvm_info(get_type_name(),$sformatf("data for write method =%0h",data), UVM_LOW)
                if (status != UVM_IS_OK)
                        `uvm_error("RAL", "Write failed")
        endtask

        task do_read(uvm_reg r, output uvm_reg_data_t data);
                uvm_status_e status;
                r.read(.status(status), .value(data), .parent(this));
                `uvm_info(get_type_name(),$sformatf("data from read method =%0h",data), UVM_LOW)
                if (status != UVM_IS_OK)
                        `uvm_error("RAL", "Read failed")
        endtask

endclass



class reset_check_sequence extends top_reg_seq;
        `uvm_object_utils(reset_check_sequence)

        function new(string name = "reset_check_sequence");
                super.new(name);
        endfunction

    task body();
        // apply reset
	//
	uvm_reg_data_t rdata;
	uvm_status_e status;
	`uvm_info(" RESET-SEQ", "Apply reset to reg", UVM_LOW);
        regmodel.reset();
        regmodel.intr_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("INTR-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
  else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR INTR REG\n "), UVM_LOW)

        regmodel.ctrl_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("CNTR-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR CNTR REG\n "), UVM_LOW)

        regmodel.io_addr_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("IO_ADDR-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR IO_ADDR REG\n "), UVM_LOW)

        regmodel.mem_addr_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("MEM_ADDR-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR MEM_ADDR REG\n "), UVM_LOW)

        regmodel.extra_info_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("EXTRA_INFO-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR EXTRA_INFO REG\n "), UVM_LOW)

        regmodel.status_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("STATUS-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR STATUS REG\n "), UVM_LOW)

        regmodel.transfer_count_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("TRANSFER_COUNT-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR TRANSFER_COUNT REG\n "), UVM_LOW)

        regmodel.descriptor_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("DESCRIPTOR_ADDR-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR DESCRIPTOR_ADDR REG\n "), UVM_LOW)

        regmodel.error_status_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("ERROR_STATUS-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR ERROR_STATUS REG\n "), UVM_LOW)

        regmodel.config_inst.read(status, rdata, UVM_BACKDOOR);
        if(rdata != 32'h0) `uvm_info("CONFIG-RST", $sformatf("\n RESET VALUE IS NOT CORRECT\n "), UVM_LOW)
 else 
	`uvm_info("INTR-RST", $sformatf("\n RESET PASS FOR CONFIG REG\n "), UVM_LOW)

    endtask: body

      /*  task body();
                uvm_reg_data_t data;
                uvm_reg_data_t read_data;

            `uvm_info(get_type_name(), $sformatf("\n\n----------------------RESET CHECK START ----------------------------\n\n"),UVM_LOW)
                
                data = regmodel.intr_inst.get_reset();
                `uvm_info(get_type_name(),$sformatf("data after get reset method =%0h",data), UVM_LOW)
                do_write(regmodel.intr_inst, data);
                do_read(regmodel.intr_inst, read_data);
                //regmodel.intr.reset();

                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("INTR reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

         /*       // CTRL
             data = regmodel.ctrl.get_reset();
                do_write(regmodel.ctrl, data);
                do_read(regmodel.ctrl, read_data);
                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("CTRL reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

                // IO_ADDR
                data = regmodel.io_addr.get_reset();
                do_write(regmodel.io_addr, data);
                do_read(regmodel.io_addr, read_data);
                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("IO_ADDR reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

                // MEM_ADDR
                data = regmodel.mem_addr.get_reset();
                do_write(regmodel.mem_addr, data);
                do_read(regmodel.mem_addr, read_data);
                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("MEM_ADDR reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

                // EXTRA_INFO
                data = regmodel.extra_info.get_reset();
                do_write(regmodel.extra_info, data);
                do_read(regmodel.extra_info, read_data);
                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("EXTRA_INFO reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

                // STATUS (RO) no write; just read
                do_read(regmodel.status, read_data);
                data = regmodel.status.get_reset();
                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("STATUS reset incorrect: expected 0x%0h, read 0x%0h", data, read_data));

                // TRANSFER_COUNT (RO)  same as above
                do_read(regmodel.transfer_count, read_data);
                data = regmodel.transfer_count.get_reset();
                if (read_data !== data)
                        `uvm_error("RESET_CHECK", $sformatf("TRANSFER_COUNT reset incorrect: expected 0x%0h, read 0x%0h", data, read_data));

                // DESCRIPTOR_ADDR
                data = regmodel.descriptor_addr.get_reset();
                do_write(regmodel.descriptor_addr, data);
                do_read(regmodel.descriptor_addr, read_data);
                if (read_data !== data)
                    `uvm_error("RESET_CHECK", $sformatf("DESCRIPTOR_ADDR reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

                // ERROR_STATUS (RW1C/RO)
                data = regmodel.error_status.get_reset();
                do_write(regmodel.error_status, data);
                do_read(regmodel.error_status, read_data);
                if (read_data !== data)
                    `uvm_error("RESET_CHECK", $sformatf("ERROR_STATUS reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

                // CONFIG
                data = regmodel.configg.get_reset();
                do_write(regmodel.configg, data);
                do_read(regmodel.configg, read_data);
                if (read_data !== data)
                    `uvm_error("RESET_CHECK", $sformatf("CONFIG reset failed: wrote 0x%0h, read 0x%0h", data, read_data));

//                 `uvm_info(get_type_name(), "\n\n----------------------RESET CHECK ENDED ---------------------------------------\n\n",UVM_LOW)

    endtask
*/
endclass


class intr_reg_seq extends top_reg_seq;
        `uvm_object_utils(intr_reg_seq)

        function new(string name = "intr_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
                uvm_status_e status;

                `uvm_info(get_type_name(),"\n\n================ INTR REGISTER CHECK START ================\n\n",UVM_LOW)

                wdata = 32'hFFFF_FFFF;

                do_write(regmodel.intr_inst, wdata);
                d_data = regmodel.intr_inst.get();
                m_data = regmodel.intr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
regmodel.intr_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.intr_inst, rdata);
                d_data = regmodel.intr_inst.get();
                m_data = regmodel.intr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

   regmodel.intr_inst.mirror(status, UVM_CHECK);
         // if (m_data !== d_data)
                        //`uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%0h mir=0x%0h",d_data, m_data))

		wdata = 32'h0000_0000;
	        do_write(regmodel.intr_inst, wdata);
                d_data = regmodel.intr_inst.get();
                m_data = regmodel.intr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
		regmodel.intr_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.intr_inst, rdata);
                d_data = regmodel.intr_inst.get();
                m_data = regmodel.intr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

								regmodel.intr_inst.mirror(status, UVM_CHECK);


        `uvm_info(get_type_name(), "\n\n================ INTR REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



//intr_seq
class ctrl_reg_seq extends top_reg_seq;
        `uvm_object_utils(ctrl_reg_seq)

        function new(string name = "ctrl_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
								uvm_status_e status;
               

                `uvm_info(get_type_name(),"\n\n================ CTRL REGISTER CHECK START ================\n\n",UVM_LOW)


                wdata = 32'hFFFF_FFFF;

                do_write(regmodel.ctrl_inst, wdata);
                d_data = regmodel.ctrl_inst.get();
                m_data = regmodel.ctrl_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
regmodel.ctrl_inst.read(status, rdata, UVM_BACKDOOR);

                //do_read(regmodel.ctrl_inst, rdata);
                d_data = regmodel.ctrl_inst.get();
                m_data = regmodel.ctrl_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

 regmodel.ctrl_inst.mirror(status, UVM_CHECK);

		wdata = 32'h0000_0000;
	        do_write(regmodel.ctrl_inst, wdata);
                d_data = regmodel.ctrl_inst.get();
                m_data = regmodel.ctrl_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
		regmodel.intr_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.ctrl_inst, rdata);
                d_data = regmodel.ctrl_inst.get();
                m_data = regmodel.ctrl_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

		regmodel.ctrl_inst.mirror(status, UVM_CHECK);

          //if (m_data !== d_data)
                        //`uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%0h mir=0x%0h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ CTRL REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass


//io_addr_seq
class io_addr_reg_seq extends top_reg_seq;
        `uvm_object_utils(io_addr_reg_seq)

        function new(string name = "io_addr_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
                uvm_status_e status;


                `uvm_info(get_type_name(),"\n\n================ IO_ADDR REGISTER CHECK START ================\n\n",UVM_LOW)

                wdata = 32'hFFFF_FFFF;

                do_write(regmodel.io_addr_inst, wdata);
                d_data = regmodel.io_addr_inst.get();
                m_data = regmodel.io_addr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
regmodel.io_addr_inst.read(status, rdata, UVM_BACKDOOR);

//                do_read(regmodel.io_addr_inst, rdata);
                d_data = regmodel.io_addr_inst.get();
                m_data = regmodel.io_addr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

                
                 regmodel.io_addr_inst.mirror(status, UVM_CHECK);



		wdata = 32'h0000_0000;
	        do_write(regmodel.io_addr_inst, wdata);
                d_data = regmodel.io_addr_inst.get();
                m_data = regmodel.io_addr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
		regmodel.io_addr_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.io_addr_inst, rdata);
                d_data = regmodel.io_addr_inst.get();
                m_data = regmodel.io_addr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

		regmodel.io_addr_inst.mirror(status, UVM_CHECK);
  //              if (m_data !== d_data)
    //                    `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%0h mir=0x%0h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ IO_ADDR REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



class mem_addr_reg_seq extends top_reg_seq;
        `uvm_object_utils(mem_addr_reg_seq)

        function new(string name = "mem_addr_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
		uvm_status_e status;

                `uvm_info(get_type_name(),"\n\n================ MEM_ADDR REGISTER CHECK START ================\n\n",UVM_LOW)

                wdata = 32'hFFFF_FFFF;

                do_write(regmodel.mem_addr_inst, wdata);
                d_data = regmodel.mem_addr_inst.get();
                m_data = regmodel.mem_addr_inst.get_mirrored_value();

               `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
regmodel.mem_addr_inst.read(status, rdata, UVM_BACKDOOR);

//                do_read(regmodel.mem_addr_inst, rdata);
                d_data = regmodel.mem_addr_inst.get();
                m_data = regmodel.mem_addr_inst.get_mirrored_value();

                  `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)
 regmodel.mem_addr_inst.mirror(status, UVM_CHECK);

		wdata = 32'h0000_0000;
	        do_write(regmodel.mem_addr_inst, wdata);
                d_data = regmodel.mem_addr_inst.get();
                m_data = regmodel.mem_addr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
		regmodel.mem_addr_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.mem_addr_inst, rdata);
                d_data = regmodel.mem_addr_inst.get();
                m_data = regmodel.mem_addr_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

		regmodel.mem_addr_inst.mirror(status, UVM_CHECK);

//                if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ MEM_ADDR REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass

class extra_info_reg_seq extends top_reg_seq;
        `uvm_object_utils(extra_info_reg_seq)

        function new(string name = "extra_info_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;

								uvm_status_e status;
                `uvm_info(get_type_name(),"\n\n================ EXTRA_INFO REGISTER CHECK START ================\n\n",UVM_LOW)

                wdata =32'hFFFF_FFFF;

                do_write(regmodel.extra_info_inst, wdata);
                d_data = regmodel.extra_info_inst.get();
                m_data = regmodel.extra_info_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
regmodel.extra_info_inst.read(status, rdata, UVM_BACKDOOR);

//                do_read(regmodel.extra_info_inst, rdata);
                d_data = regmodel.extra_info_inst.get();
                m_data = regmodel.extra_info_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)

 regmodel.extra_info_inst.mirror(status, UVM_CHECK);

		wdata = 32'h0000_0000;
	        do_write(regmodel.extra_info_inst, wdata);
                d_data = regmodel.extra_info_inst.get();
                m_data = regmodel.extra_info_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
		regmodel.extra_info_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.extra_info_inst, rdata);
                d_data = regmodel.extra_info_inst.get();
                m_data = regmodel.extra_info_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

		regmodel.extra_info_inst.mirror(status, UVM_CHECK);

                // Mirrored must match desired after read
//                if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ EXTRA_INFO REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass


//status
class status_reg_seq extends top_reg_seq;
        `uvm_object_utils(status_reg_seq)

        function new(string name = "status_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
								uvm_status_e status;

                `uvm_info(get_type_name(),"\n\n================ STATUS REGISTER CHECK START ================\n\n",UVM_LOW)


                wdata = 32'hFFFF_FFFF;
                do_write(regmodel.status_inst, wdata);
                d_data = regmodel.status_inst.get();
                m_data = regmodel.status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
regmodel.status_inst.read(status, rdata, UVM_BACKDOOR);
//                do_read(regmodel.status_inst, rdata);
                d_data = regmodel.status_inst.get();
                m_data = regmodel.status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)
 regmodel.status_inst.mirror(status, UVM_CHECK);

//                if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ STATUS REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



//transfer_count
class transfer_count_reg_seq extends top_reg_seq;
        `uvm_object_utils(transfer_count_reg_seq)

        function new(string name = "transfer_count_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
								uvm_status_e status;

                `uvm_info(get_type_name(),"\n\n================ TRANSFER_COUNT REGISTER CHECK START ================\n\n",UVM_LOW)

                wdata = 32'hFFFF_FFFF;

                do_write(regmodel.transfer_count_inst, wdata);
                d_data = regmodel.transfer_count_inst.get();
                m_data = regmodel.transfer_count_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
regmodel.transfer_count_inst.read(status, rdata, UVM_BACKDOOR);

//                do_read(regmodel.transfer_count_inst, rdata);
                d_data = regmodel.transfer_count_inst.get();
                m_data = regmodel.transfer_count_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)
 regmodel.transfer_count_inst.mirror(status, UVM_CHECK);

//                if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ TRANSFER_COUNT REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



// descriptor_addr
class descriptor_addr_reg_seq extends top_reg_seq;
        `uvm_object_utils(descriptor_addr_reg_seq)

        function new(string name = "descriptor_addr_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
								uvm_status_e status;
                `uvm_info(get_type_name(),"\n\n================ DESCRIPTOR_ADDR REGISTER CHECK START ================\n\n",UVM_LOW)

                wdata = 32'hFFFF_FFFF;

                do_write(regmodel.descriptor_inst, wdata);
                d_data = regmodel.descriptor_inst.get();
                m_data = regmodel.descriptor_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
regmodel.descriptor_inst.read(status, rdata, UVM_BACKDOOR);

//                do_read(regmodel.descriptor_inst, rdata);
                d_data = regmodel.descriptor_inst.get();
                m_data = regmodel.descriptor_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)
 regmodel.descriptor_inst.mirror(status, UVM_CHECK);
//          if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

        `uvm_info(get_type_name(), "\n\n================ DESCRIPTOR_ADDR REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



//error_status
class error_status_reg_seq extends top_reg_seq;
        `uvm_object_utils(error_status_reg_seq)

        function new(string name = "error_status_reg_seq");
                super.new(name);
        endfunction

        task body();
                uvm_reg_data_t rdata,wdata,d_data,m_data;
								uvm_status_e status;
                `uvm_info(get_type_name(),"\n\n================ ERROR_STATUS REGISTER CHECK START ================\n\n",UVM_LOW)


                wdata =32'hFFFF_FFFF;
                do_write(regmodel.error_status_inst, wdata);
                d_data = regmodel.error_status_inst.get();
                m_data = regmodel.error_status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
regmodel.error_status_inst.read(status, rdata, UVM_BACKDOOR);


//                do_read(regmodel.error_status_inst, rdata);
                d_data = regmodel.error_status_inst.get();
                m_data = regmodel.error_status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)
 regmodel.error_status_inst.mirror(status, UVM_CHECK);
//                if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

		wdata = 32'h0000_0000;
	        do_write(regmodel.error_status_inst, wdata);
                d_data = regmodel.error_status_inst.get();
                m_data = regmodel.error_status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h", wdata, d_data,m_data),UVM_LOW)
		regmodel.error_status_inst.read(status, rdata, UVM_BACKDOOR);
                //do_read(regmodel.error_status_inst, rdata);
                d_data = regmodel.error_status_inst.get();
                m_data = regmodel.error_status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

		regmodel.error_status_inst.mirror(status, UVM_CHECK);
                /*rdata=32'hFFFFFFFF;
                regmodel.error_status_inst.write(status, rdata, UVM_BACKDOOR);
                d_data = regmodel.error_status_inst.get();
                m_data = regmodel.error_status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE BACKDOOR  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)

		regmodel.error_status_inst.read(status, rdata, UVM_BACKDOOR);
                d_data = regmodel.error_status_inst.get();
                m_data = regmodel.error_status_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ BACKDOOR  | DUT=0x%0h DESIRED=0x%0h,  MIRRORED=0x%0h",rdata,d_data, m_data),UVM_LOW)*/

        `uvm_info(get_type_name(), "\n\n================ ERROR_STATUS REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



//config
class config_reg_seq extends top_reg_seq;
        `uvm_object_utils(config_reg_seq)

        function new(string name = "config_reg_seq");
                super.new(name);
        endfunction

        task body();
               uvm_reg_data_t rdata,wdata,d_data,m_data;
								uvm_status_e status;
                `uvm_info(get_type_name(),"\n\n================ CONFIG REGISTER CHECK START ================\n\n",UVM_LOW)


                wdata = 32'hFFFF_FFFF;
                do_write(regmodel.config_inst, wdata);
                d_data = regmodel.config_inst.get();
                m_data = regmodel.config_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
regmodel.config_inst.read(status, rdata, UVM_BACKDOOR);


//                do_read(regmodel.config_inst, rdata);
                d_data = regmodel.config_inst.get();
                m_data = regmodel.config_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)
 regmodel.config_inst.mirror(status, UVM_CHECK);
//                if (m_data !== d_data)
  //                      `uvm_error(get_type_name(),$sformatf("Mirror mismatch: des=0x%08h mir=0x%08h",d_data, m_data))

		wdata = 32'h00000000;
                do_write(regmodel.config_inst, wdata);
                d_data = regmodel.config_inst.get();
                m_data = regmodel.config_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("WRITE | WDATA=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h", wdata, d_data,m_data),UVM_LOW)
		regmodel.config_inst.read(status, rdata, UVM_BACKDOOR);


//                do_read(regmodel.config_inst, rdata);
                d_data = regmodel.config_inst.get();
                m_data = regmodel.config_inst.get_mirrored_value();

                `uvm_info(get_type_name(),$sformatf("READ  | DUT=0x%08h DESIRED=0x%08h,  MIRRORED=0x%08h",rdata,d_data, m_data),UVM_LOW)
 		regmodel.config_inst.mirror(status, UVM_CHECK);

        `uvm_info(get_type_name(), "\n\n================ CONFIG REGISTER CHECK END =================\n\n", UVM_LOW)
    endtask
endclass



//REGRESSION
class regression_seq extends top_reg_seq;

        `uvm_object_utils(regression_seq)

        reset_check_sequence rst_seq;
        intr_reg_seq intr_seq;
        ctrl_reg_seq ctrl_seq;
        io_addr_reg_seq io_addr_seq;
        mem_addr_reg_seq mem_addr_seq;
        extra_info_reg_seq extra_info_seq;
        status_reg_seq status_seq;
        transfer_count_reg_seq transfer_count_seq;
        descriptor_addr_reg_seq descriptor_addr_seq;
        error_status_reg_seq error_status_seq;
        config_reg_seq config_seq;

        function new(string name = "regression_seq");
                super.new(name);
        endfunction

        virtual task body();

                `uvm_info(get_type_name(), "\n\n================ regression start =================\n\n", UVM_LOW)

                `uvm_create(rst_seq)
                rst_seq.regmodel = this.regmodel;
                `uvm_send(rst_seq)

               // individual register tests
                `uvm_create(intr_seq)
                intr_seq.regmodel = this.regmodel;
                `uvm_send(intr_seq)

                `uvm_create(ctrl_seq)
                ctrl_seq.regmodel = this.regmodel;
                `uvm_send(ctrl_seq)

                `uvm_create(io_addr_seq)
                io_addr_seq.regmodel = this.regmodel;
                `uvm_send(io_addr_seq)

                `uvm_create(mem_addr_seq)
                mem_addr_seq.regmodel = this.regmodel;
                `uvm_send(mem_addr_seq)

                `uvm_create(extra_info_seq)
                extra_info_seq.regmodel = this.regmodel;
                `uvm_send(extra_info_seq)

                `uvm_create(status_seq)
                status_seq.regmodel = this.regmodel;
                `uvm_send(status_seq)

                `uvm_create(transfer_count_seq)
                transfer_count_seq.regmodel = this.regmodel;
                `uvm_send(transfer_count_seq)

                `uvm_create(descriptor_addr_seq)
                descriptor_addr_seq.regmodel = this.regmodel;
                `uvm_send(descriptor_addr_seq)

                `uvm_create(error_status_seq)
                error_status_seq.regmodel = this.regmodel;
                `uvm_send(error_status_seq)

                `uvm_create(config_seq)
                config_seq.regmodel = this.regmodel;
                `uvm_send(config_seq)

        endtask
endclass

                                                        


 
