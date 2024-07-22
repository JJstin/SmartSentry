set moduleName subtract_0_16_1920_1080_1_2_2_2_s
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {subtract<0, 16, 1920, 1080, 1, 2, 2, 2>}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ imgInput1_data int 24 regular {fifo 0 volatile }  }
	{ imgInput2_data int 24 regular {fifo 0 volatile }  }
	{ imgOutput_data int 24 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "imgInput1_data", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "imgInput2_data", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "imgOutput_data", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 22
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ imgInput1_data_dout sc_in sc_lv 24 signal 0 } 
	{ imgInput1_data_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ imgInput1_data_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ imgInput1_data_empty_n sc_in sc_logic 1 signal 0 } 
	{ imgInput1_data_read sc_out sc_logic 1 signal 0 } 
	{ imgInput2_data_dout sc_in sc_lv 24 signal 1 } 
	{ imgInput2_data_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ imgInput2_data_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ imgInput2_data_empty_n sc_in sc_logic 1 signal 1 } 
	{ imgInput2_data_read sc_out sc_logic 1 signal 1 } 
	{ imgOutput_data_din sc_out sc_lv 24 signal 2 } 
	{ imgOutput_data_num_data_valid sc_in sc_lv 3 signal 2 } 
	{ imgOutput_data_fifo_cap sc_in sc_lv 3 signal 2 } 
	{ imgOutput_data_full_n sc_in sc_logic 1 signal 2 } 
	{ imgOutput_data_write sc_out sc_logic 1 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "imgInput1_data_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "imgInput1_data", "role": "dout" }} , 
 	{ "name": "imgInput1_data_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgInput1_data", "role": "num_data_valid" }} , 
 	{ "name": "imgInput1_data_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgInput1_data", "role": "fifo_cap" }} , 
 	{ "name": "imgInput1_data_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgInput1_data", "role": "empty_n" }} , 
 	{ "name": "imgInput1_data_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgInput1_data", "role": "read" }} , 
 	{ "name": "imgInput2_data_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "imgInput2_data", "role": "dout" }} , 
 	{ "name": "imgInput2_data_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgInput2_data", "role": "num_data_valid" }} , 
 	{ "name": "imgInput2_data_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgInput2_data", "role": "fifo_cap" }} , 
 	{ "name": "imgInput2_data_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgInput2_data", "role": "empty_n" }} , 
 	{ "name": "imgInput2_data_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgInput2_data", "role": "read" }} , 
 	{ "name": "imgOutput_data_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "din" }} , 
 	{ "name": "imgOutput_data_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "num_data_valid" }} , 
 	{ "name": "imgOutput_data_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "fifo_cap" }} , 
 	{ "name": "imgOutput_data_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "full_n" }} , 
 	{ "name": "imgOutput_data_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "subtract_0_16_1920_1080_1_2_2_2_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2083201", "EstimateLatencyMax" : "2083201",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "imgInput1_data", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop_fu_40", "Port" : "imgInput1_data", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "imgInput2_data", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop_fu_40", "Port" : "imgInput2_data", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop_fu_40", "Port" : "imgOutput_data", "Inst_start_state" : "2", "Inst_end_state" : "3"}]}],
		"Loop" : [
			{"Name" : "rowLoop", "PipelineType" : "no",
				"LoopDec" : {"FSMBitwidth" : "3", "FirstState" : "ap_ST_fsm_state2", "LastState" : ["ap_ST_fsm_state3"], "QuitState" : ["ap_ST_fsm_state2"], "PreState" : ["ap_ST_fsm_state1"], "PostState" : ["ap_ST_fsm_state1"], "OneDepthLoop" : "0", "OneStateBlock": ""}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop_fu_40", "Parent" : "0", "Child" : ["2"],
		"CDFG" : "subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "1083", "EstimateLatencyMax" : "1083",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "imgInput1_data", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "imgInput1_data_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "imgInput2_data", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "imgInput2_data_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "imgOutput_data_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "colLoop", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop_fu_40.flow_control_loop_pipe_sequential_init_U", "Parent" : "1"}]}


set ArgLastReadFirstWriteLatency {
	subtract_0_16_1920_1080_1_2_2_2_s {
		imgInput1_data {Type I LastRead 1 FirstWrite -1}
		imgInput2_data {Type I LastRead 1 FirstWrite -1}
		imgOutput_data {Type O LastRead -1 FirstWrite 2}}
	subtract_0_16_1920_1080_1_2_2_2_Pipeline_colLoop {
		imgInput1_data {Type I LastRead 1 FirstWrite -1}
		imgInput2_data {Type I LastRead 1 FirstWrite -1}
		imgOutput_data {Type O LastRead -1 FirstWrite 2}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2083201", "Max" : "2083201"}
	, {"Name" : "Interval", "Min" : "2083201", "Max" : "2083201"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	imgInput1_data { ap_fifo {  { imgInput1_data_dout fifo_data_in 0 24 }  { imgInput1_data_num_data_valid fifo_status_num_data_valid 0 3 }  { imgInput1_data_fifo_cap fifo_update 0 3 }  { imgInput1_data_empty_n fifo_status 0 1 }  { imgInput1_data_read fifo_port_we 1 1 } } }
	imgInput2_data { ap_fifo {  { imgInput2_data_dout fifo_data_in 0 24 }  { imgInput2_data_num_data_valid fifo_status_num_data_valid 0 3 }  { imgInput2_data_fifo_cap fifo_update 0 3 }  { imgInput2_data_empty_n fifo_status 0 1 }  { imgInput2_data_read fifo_port_we 1 1 } } }
	imgOutput_data { ap_fifo {  { imgOutput_data_din fifo_data_in 1 24 }  { imgOutput_data_num_data_valid fifo_status_num_data_valid 0 3 }  { imgOutput_data_fifo_cap fifo_update 0 3 }  { imgOutput_data_full_n fifo_status 0 1 }  { imgOutput_data_write fifo_port_we 1 1 } } }
}
