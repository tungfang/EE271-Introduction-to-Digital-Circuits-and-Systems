transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+U:/271/lab2c/lab2c {U:/271/lab2c/lab2c/DE1_SoC.sv}
vlog -sv -work work +incdir+U:/271/lab2c/lab2c {U:/271/lab2c/lab2c/myDesign.sv}

