spec: testbench.vcd
	python3 /rtlkon.py testbench.vcd
	java -cp /daikon.jar daikon.Daikon testbench.dtrace testbench.decls >spec.out

testbench.vcd: tb_acw.vvp
	vvp -N $< +vcd >/dev/null

tb_acw.vvp: tb_acw.sv acw.v axi_m_generic_module.v
	iverilog -o $@ $^ -g2012
	chmod -x $@

clean:
	rm -f *.vvp *.vcd *.dtrace *.decls
