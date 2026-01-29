QUESTA := /home/share/questa.csh
SHELL := /bin/csh
TEST ?= dma_regression_test
V ?= UVM_MEDIUM

.ONESHELL:	
all:
	source $(QUESTA)
	make compile
	make simulate
	vcover report -html ral_dma_coverage.ucdb -htmldir covReport -details

clean:
	rm -rf work/ transcript vsim.wlf wave.vcd vsim_stacktrace.vstf 
	rm .nco* 
	rm .makefile*
	rm -rf covReport ral_dma_coverage.ucdb 
	rm ral_dma.log simulation.log
	rm ral_dma_coverage.ucdb
	clear
	clear
	clear

compile:
	make clean
	@echo "\t\t\t\t...............................COMPILING CODE..............................."
	source $(QUESTA)
	vlog -sv +acc +cover +fcover -l ral_dma.log top.sv 

wave:
	make compile
	@echo "\t\t\t\t\t...............GENERATING WAVEFORM FOR TEST = $(TEST)..............."
	vsim -novopt work.top +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=$(V)

simulate:
	@echo "\t\t\t\t...........................SIMULATING TEST = $(TEST) WITH VERBOSITY = $(V)..........................."
	vsim -vopt work.top -voptargs=+acc=npr -assertdebug -l simulation.log -coverage -c -do "coverage save -onexit -assert -directive -cvg -codeAll ral_dma_coverage.ucdb; run -all; exit" +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=$(V)

view:
	firefox ./covReport/index.html
