set FLAG=-v -PALL_LIB --syn-binding --ieee=synopsys --std=93c -fexplicit

rem ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\VHDL\adcin.vhd
rem ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\TEST\tb_adcin.vhd
rem ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\TEST\tb_pwm10b.vhd
ghdl -a --work=TEL_LIB --workdir=ALL_LIB %FLAG% ..\TEST\tb_adctest.vhd

rem ghdl -e --work=TEL_LIB --workdir=ALL_LIB %FLAG% tb_adcin
rem ghdl -r --work=TEL_LIB --workdir=ALL_LIB tb_adcin --wave=tb_adcin.ghw
rem ghdl -e --work=TEL_LIB --workdir=ALL_LIB %FLAG% tb_pwm10b
rem ghdl -r --work=TEL_LIB --workdir=ALL_LIB tb_pwm10b --wave=tb_pwm10b.ghw
ghdl -e --work=TEL_LIB --workdir=ALL_LIB %FLAG% tb_adctest
ghdl -r --work=TEL_LIB --workdir=ALL_LIB tb_adctest --wave=tb_adctest.ghw


