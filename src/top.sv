`include "ral_dma_interface.sv"
`include "ral_dma_pkg.sv"
`include "dma_design.sv"
import uvm_pkg::*;
import ral_dma_pkg::*;
module top;
    

    bit clk, rst_n;
    ral_dma_intf intf(clk, rst_n);

    // dut instance
  dma_design dut(.clk(clk), .rst_n(rst_n), .wr_en(intf.wr_en), .rd_en(intf.rd_en), .wdata(intf.wdata), .addr(intf.addr), .rdata(intf.rdata));
   
    always #5 clk = ~clk;
   initial begin
        clk = 0;
        rst_n = 0;
      @(posedge clk)
         rst_n = 1;
    end

    initial begin
      uvm_config_db#(virtual ral_dma_intf)::set(null, "*", "vif", intf);
        run_test("");
    end

endmodule
