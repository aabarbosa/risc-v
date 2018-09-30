# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Sat Sep 24 20:04:40 2016
# Designs open: 1
#   V1: /home/pem/Downloads/RISC-V/vcdplus.vpd
# Toplevel windows open: 1
# 	TopLevel.2
#   Wave.1: 49 signals
#   Group count = 1
#   Group Group1 signal count = 49
# End_DVE_Session_Save_Info

# DVE version: K-2015.09-SP1-1_Full64
# DVE build date: Jan 21 2016 22:31:52


#<Session mode="Reload" path="/home/pem/Downloads/RISC-V/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Reload
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all
gui_clear_window -type Wave
gui_clear_window -type List

# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.2

set TopLevel.2 TopLevel.2

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 Wave.1
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 742} {child_wave_right 1812} {child_wave_colname 396} {child_wave_colvalue 342} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/home/pem/Downloads/RISC-V/vcdplus.vpd}] } {
	gui_open_db -design V1 -file /home/pem/Downloads/RISC-V/vcdplus.vpd -nosource
}
gui_set_precision 1s
gui_set_time_units 1s
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {top.cpu}
gui_load_child_values {top.cpu.processador.controller}


set _session_group_7 Group1
gui_sg_create "$_session_group_7"
set Group1 "$_session_group_7"

gui_sg_addsignal -group "$_session_group_7" { top.cpu.z top.cpu.z.pc top.cpu.z.instr top.cpu.z.srcA top.cpu.z.srcB top.cpu.z.ALUResult top.cpu.z.readData top.cpu.z.S top.cpu.z.WD3 top.cpu.z.A3 top.cpu.z.N top.cpu.reset top.cpu.clk top.cpu.E top.cpu.S top.cpu.ALUResult top.cpu.readData top.cpu.writeData top.cpu.memWrite top.cpu.RD top.cpu.WD top.cpu.A top.cpu.WE top.cpu.EN top.cpu.D top.cpu.WIDTH top.cpu.RS_WIDTH top.cpu.processador.controller.RS1 top.cpu.processador.controller.RS2 top.cpu.processador.controller.IMM top.cpu.processador.controller.RD top.cpu.processador.controller.memToReg top.cpu.processador.controller.memWrite top.cpu.processador.controller.regWrite top.cpu.processador.controller.ALUSrc top.cpu.processador.controller.zero top.cpu.processador.controller.ALUControl top.cpu.processador.controller.ra top.cpu.processador.controller.jalSrc top.cpu.processador.controller.pc top.cpu.processador.controller.pc_ top.cpu.processador.controller.instr top.cpu.processador.controller.lw top.cpu.processador.controller.espera top.cpu.processador.controller.PCSrc top.cpu.processador.controller.branch top.cpu.processador.controller.func3 top.cpu.processador.controller.func7 top.cpu.processador.controller.opcode }
gui_set_radix -radix {decimal} -signals {V1:top.cpu.z.N}
gui_set_radix -radix {twosComplement} -signals {V1:top.cpu.z.N}
gui_set_radix -radix {decimal} -signals {V1:top.cpu.WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:top.cpu.WIDTH}
gui_set_radix -radix {decimal} -signals {V1:top.cpu.RS_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:top.cpu.RS_WIDTH}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Global: Watch 'Watch'

gui_watch_page_delete -id Watch -all
gui_watch_page_add -id Watch
gui_watch_page_rename -id Watch -name {Watch 1}
gui_watch_page_add -id Watch
gui_watch_page_rename -id Watch -name {Watch 2}
gui_watch_page_add -id Watch
gui_watch_page_rename -id Watch -name {Watch 3}

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 54



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 0 597
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_select -id ${Wave.1} {top.cpu.z.srcA }
gui_seek_criteria -id ${Wave.1} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group Group1  -item {top.cpu.processador.controller.pc[7:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 54
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

