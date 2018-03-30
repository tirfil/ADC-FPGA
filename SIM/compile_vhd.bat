set FLAG=-v -PALL_LIB --syn-binding --ieee=synopsys --std=93c -fexplicit

ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\VHDL\adcin.vhd
ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\VHDL\pwm10b.vhd
ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\VHDL\div1024.vhd
ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\VHDL\adctest.vhd
rem ghdl -e --work=TEL_LIB --workdir=ALL_LIB %FLAG% adcin
ghdl -e --work=TEL_LIB --workdir=ALL_LIB %FLAG% adctest 
