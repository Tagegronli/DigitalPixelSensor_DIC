
plt=python3 ../../py/plot.py

Testbench:
	${MAKE} ngspice	TB=Testbench



ngspice:
	ngspice -a ${TB}.cir
