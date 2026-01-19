package ral_dma_pkg;
      import uvm_pkg::*;
    `include "config_reg.sv"
    `include "ctrl_reg.sv"
    `include "descriptor_addr_reg.sv"
    `include "error_status_reg.sv"
    `include "extra_info_reg.sv"
    `include "intr_reg.sv"
    `include "io_addr_reg.sv"
    `include "mem_addr_reg.sv"
    `include "status_reg.sv"
    `include "transfer_count_reg.sv"

    `include "ral_dma_sequence_item.sv"
    `include "ral_dma_reg_block.sv"
    `include "ral_dma_adapter.sv"
    `include "ral_dma_reg_sequence.sv"
    `include "ral_dma_sequencer.sv"

    `include "ral_dma_driver.sv"
    `include "ral_dma_monitor.sv"
    `include "ral_dma_agent.sv"
    `include "ral_dma_environment.sv"
    `include "ral_dma_test.sv"
endpackage
