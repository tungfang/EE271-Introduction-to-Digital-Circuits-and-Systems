transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/concon/workspace/EE\ 271/lab1 {C:/Users/concon/workspace/EE 271/lab1/fullAdder.sv}

