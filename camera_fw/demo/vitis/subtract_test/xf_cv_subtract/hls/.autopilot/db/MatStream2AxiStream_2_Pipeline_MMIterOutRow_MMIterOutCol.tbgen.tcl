set moduleName MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {MatStream2AxiStream<2>_Pipeline_MMIterOutRow_MMIterOutCol}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ imgOutput_data int 24 regular {fifo 0 volatile }  }
	{ ldata int 32 regular {fifo 1 volatile }  }
	{ localbuffer_1_out int 32 regular {pointer 1}  }
	{ filled_1_out int 6 regular {pointer 1}  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "imgOutput_data", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "ldata", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "localbuffer_1_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "filled_1_out", "interface" : "wire", "bitwidth" : 6, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 20
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ imgOutput_data_dout sc_in sc_lv 24 signal 0 } 
	{ imgOutput_data_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ imgOutput_data_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ imgOutput_data_empty_n sc_in sc_logic 1 signal 0 } 
	{ imgOutput_data_read sc_out sc_logic 1 signal 0 } 
	{ ldata_din sc_out sc_lv 32 signal 1 } 
	{ ldata_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ ldata_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ ldata_full_n sc_in sc_logic 1 signal 1 } 
	{ ldata_write sc_out sc_logic 1 signal 1 } 
	{ localbuffer_1_out sc_out sc_lv 32 signal 2 } 
	{ localbuffer_1_out_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ filled_1_out sc_out sc_lv 6 signal 3 } 
	{ filled_1_out_ap_vld sc_out sc_logic 1 outvld 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "imgOutput_data_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "dout" }} , 
 	{ "name": "imgOutput_data_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "num_data_valid" }} , 
 	{ "name": "imgOutput_data_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "fifo_cap" }} , 
 	{ "name": "imgOutput_data_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "empty_n" }} , 
 	{ "name": "imgOutput_data_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "read" }} , 
 	{ "name": "ldata_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ldata", "role": "din" }} , 
 	{ "name": "ldata_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "ldata", "role": "num_data_valid" }} , 
 	{ "name": "ldata_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "ldata", "role": "fifo_cap" }} , 
 	{ "name": "ldata_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ldata", "role": "full_n" }} , 
 	{ "name": "ldata_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ldata", "role": "write" }} , 
 	{ "name": "localbuffer_1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "localbuffer_1_out", "role": "default" }} , 
 	{ "name": "localbuffer_1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "localbuffer_1_out", "role": "ap_vld" }} , 
 	{ "name": "filled_1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "filled_1_out", "role": "default" }} , 
 	{ "name": "filled_1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "filled_1_out", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2073604", "EstimateLatencyMax" : "2073604",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "imgOutput_data_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ldata", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "ldata_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "localbuffer_1_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "filled_1_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "MMIterOutRow_MMIterOutCol", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter3", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter3", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol {
		imgOutput_data {Type I LastRead 1 FirstWrite -1}
		ldata {Type O LastRead -1 FirstWrite 3}
		localbuffer_1_out {Type O LastRead -1 FirstWrite 2}
		filled_1_out {Type O LastRead -1 FirstWrite 2}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2073604", "Max" : "2073604"}
	, {"Name" : "Interval", "Min" : "2073604", "Max" : "2073604"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	imgOutput_data { ap_fifo {  { imgOutput_data_dout fifo_data_in 0 24 }  { imgOutput_data_num_data_valid fifo_status_num_data_valid 0 3 }  { imgOutput_data_fifo_cap fifo_update 0 3 }  { imgOutput_data_empty_n fifo_status 0 1 }  { imgOutput_data_read fifo_port_we 1 1 } } }
	ldata { ap_fifo {  { ldata_din fifo_data_in 1 32 }  { ldata_num_data_valid fifo_status_num_data_valid 0 3 }  { ldata_fifo_cap fifo_update 0 3 }  { ldata_full_n fifo_status 0 1 }  { ldata_write fifo_port_we 1 1 } } }
	localbuffer_1_out { ap_vld {  { localbuffer_1_out out_data 1 32 }  { localbuffer_1_out_ap_vld out_vld 1 1 } } }
	filled_1_out { ap_vld {  { filled_1_out out_data 1 6 }  { filled_1_out_ap_vld out_vld 1 1 } } }
}
