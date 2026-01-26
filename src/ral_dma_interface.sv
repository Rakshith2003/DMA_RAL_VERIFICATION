interface ral_dma_intf(input logic clk,input logic rst_n);
    logic wr_en;
    logic rd_en;
    logic [31:0] wdata;
    logic [31:0] addr;
    logic [31:0] rdata;
        
  clocking drv_cb@(posedge clk);
					input rdata;
    output wr_en,rd_en,wdata,addr;
  endclocking
  
  clocking mon_cb@(posedge clk);
    input rdata,wr_en,rd_en,wdata,addr;
  endclocking

endinterface
