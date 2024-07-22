set moduleName xfMat2Array_32_16_1920_1080_1_2_1_s
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
set C_modelName {xfMat2Array<32, 16, 1920, 1080, 1, 2, 1>}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ imgOutput_data int 24 regular {fifo 0 volatile }  }
	{ gmem2 int 32 regular {axi_master 1}  }
	{ dstPtr int 64 regular {fifo 0}  }
}
set hasAXIMCache 0
set hasAXIML2Cache 0
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "imgOutput_data", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "gmem2", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "img_out","offset": { "type": "dynamic","port_name": "img_out","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "dstPtr", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 63
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ imgOutput_data_dout sc_in sc_lv 24 signal 0 } 
	{ imgOutput_data_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ imgOutput_data_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ imgOutput_data_empty_n sc_in sc_logic 1 signal 0 } 
	{ imgOutput_data_read sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem2_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem2_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem2_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem2_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem2_AWLEN sc_out sc_lv 32 signal 1 } 
	{ m_axi_gmem2_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem2_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem2_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem2_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem2_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem2_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem2_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem2_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_gmem2_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem2_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem2_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem2_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem2_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem2_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem2_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem2_ARLEN sc_out sc_lv 32 signal 1 } 
	{ m_axi_gmem2_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem2_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem2_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem2_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem2_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem2_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem2_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem2_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem2_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_gmem2_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem2_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem2_RFIFONUM sc_in sc_lv 9 signal 1 } 
	{ m_axi_gmem2_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem2_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem2_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem2_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem2_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem2_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem2_BUSER sc_in sc_lv 1 signal 1 } 
	{ dstPtr_dout sc_in sc_lv 64 signal 2 } 
	{ dstPtr_num_data_valid sc_in sc_lv 3 signal 2 } 
	{ dstPtr_fifo_cap sc_in sc_lv 3 signal 2 } 
	{ dstPtr_empty_n sc_in sc_logic 1 signal 2 } 
	{ dstPtr_read sc_out sc_logic 1 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "imgOutput_data_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "dout" }} , 
 	{ "name": "imgOutput_data_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "num_data_valid" }} , 
 	{ "name": "imgOutput_data_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "fifo_cap" }} , 
 	{ "name": "imgOutput_data_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "empty_n" }} , 
 	{ "name": "imgOutput_data_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imgOutput_data", "role": "read" }} , 
 	{ "name": "m_axi_gmem2_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem2_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem2_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem2_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem2_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem2", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem2_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem2_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem2_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem2_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem2_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem2_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem2_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem2_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem2_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem2_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem2_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem2", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem2_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem2_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem2_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WID" }} , 
 	{ "name": "m_axi_gmem2_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem2_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem2_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem2_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem2_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem2_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem2", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem2_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem2_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem2_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem2_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem2_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem2_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem2_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem2_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem2_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem2_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem2_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem2", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem2_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem2_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RID" }} , 
 	{ "name": "m_axi_gmem2_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem2", "role": "RFIFONUM" }} , 
 	{ "name": "m_axi_gmem2_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem2_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem2_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem2_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem2_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem2_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BID" }} , 
 	{ "name": "m_axi_gmem2_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BUSER" }} , 
 	{ "name": "dstPtr_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstPtr", "role": "dout" }} , 
 	{ "name": "dstPtr_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "dstPtr", "role": "num_data_valid" }} , 
 	{ "name": "dstPtr_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "dstPtr", "role": "fifo_cap" }} , 
 	{ "name": "dstPtr_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstPtr", "role": "empty_n" }} , 
 	{ "name": "dstPtr_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstPtr", "role": "read" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "xfMat2Array_32_16_1920_1080_1_2_1_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2073607", "EstimateLatencyMax" : "2073607",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_Mat2Axi_fu_44", "Port" : "imgOutput_data", "Inst_start_state" : "1", "Inst_end_state" : "2"}]},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_Mat2Axi_fu_44", "Port" : "gmem2", "Inst_start_state" : "1", "Inst_end_state" : "2"}]},
			{"Name" : "dstPtr", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstPtr_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44", "Parent" : "0", "Child" : ["2", "3", "7", "10", "11", "12"],
		"CDFG" : "Mat2Axi",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2073606", "EstimateLatencyMax" : "2073606",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"InputProcess" : [
			{"ID" : "2", "Name" : "entry_proc_U0"},
			{"ID" : "3", "Name" : "Mat2AxiStream_U0"}],
		"OutputProcess" : [
			{"ID" : "7", "Name" : "AxiStream2Axi_U0"}],
		"Port" : [
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "Mat2AxiStream_U0", "Port" : "imgOutput_data"}]},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "7", "SubInstance" : "AxiStream2Axi_U0", "Port" : "gmem2"}]},
			{"Name" : "dout", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.entry_proc_U0", "Parent" : "1",
		"CDFG" : "entry_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "dout", "Type" : "None", "Direction" : "I"},
			{"Name" : "dout_c", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["7"], "DependentChan" : "10", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dout_c_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.Mat2AxiStream_U0", "Parent" : "1", "Child" : ["4"],
		"CDFG" : "Mat2AxiStream",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2073606", "EstimateLatencyMax" : "2073606",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"InputProcess" : [
			{"ID" : "4", "Name" : "MatStream2AxiStream_2_U0"}],
		"OutputProcess" : [
			{"ID" : "4", "Name" : "MatStream2AxiStream_2_U0"}],
		"Port" : [
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "MatStream2AxiStream_2_U0", "Port" : "imgOutput_data"}]},
			{"Name" : "ldata", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["7"], "DependentChan" : "11", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "MatStream2AxiStream_2_U0", "Port" : "ldata"}]}]},
	{"ID" : "4", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.Mat2AxiStream_U0.MatStream2AxiStream_2_U0", "Parent" : "3", "Child" : ["5"],
		"CDFG" : "MatStream2AxiStream_2_s",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2073606", "EstimateLatencyMax" : "2073606",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "imgOutput_data", "Type" : "Fifo", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "grp_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol_fu_39", "Port" : "imgOutput_data", "Inst_start_state" : "1", "Inst_end_state" : "2"}]},
			{"Name" : "ldata", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["7"], "DependentChan" : "11", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "ldata_blk_n", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "grp_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol_fu_39", "Port" : "ldata", "Inst_start_state" : "1", "Inst_end_state" : "2"}]}]},
	{"ID" : "5", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.grp_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol_fu_39", "Parent" : "4", "Child" : ["6"],
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
	{"ID" : "6", "Level" : "5", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.Mat2AxiStream_U0.MatStream2AxiStream_2_U0.grp_MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol_fu_39.flow_control_loop_pipe_sequential_init_U", "Parent" : "5"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.AxiStream2Axi_U0", "Parent" : "1", "Child" : ["8"],
		"CDFG" : "AxiStream2Axi",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "1555211", "EstimateLatencyMax" : "1555211",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"StartSource" : "2",
		"StartFifo" : "start_for_AxiStream2Axi_U0_U",
		"Port" : [
			{"Name" : "ldata", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["3","4"], "DependentChan" : "11", "DependentChanDepth" : "2", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "grp_AxiStream2Axi_Pipeline_MMIterOutLoop2_fu_64", "Port" : "ldata", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "gmem2_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "gmem2_blk_n_B", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "grp_AxiStream2Axi_Pipeline_MMIterOutLoop2_fu_64", "Port" : "gmem2", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "dout", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["2"], "DependentChan" : "10", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dout_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "8", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.AxiStream2Axi_U0.grp_AxiStream2Axi_Pipeline_MMIterOutLoop2_fu_64", "Parent" : "7", "Child" : ["9"],
		"CDFG" : "AxiStream2Axi_Pipeline_MMIterOutLoop2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "1555203", "EstimateLatencyMax" : "1555203",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "gmem2_blk_n_W", "Type" : "RtlSignal"}]},
			{"Name" : "sext_ln1379", "Type" : "None", "Direction" : "I"},
			{"Name" : "ldata", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "ldata_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "MMIterOutLoop2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "9", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.AxiStream2Axi_U0.grp_AxiStream2Axi_Pipeline_MMIterOutLoop2_fu_64.flow_control_loop_pipe_sequential_init_U", "Parent" : "8"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.dout_c_U", "Parent" : "1"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.ldata_U", "Parent" : "1"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_Mat2Axi_fu_44.start_for_AxiStream2Axi_U0_U", "Parent" : "1"}]}


set ArgLastReadFirstWriteLatency {
	xfMat2Array_32_16_1920_1080_1_2_1_s {
		imgOutput_data {Type I LastRead 1 FirstWrite -1}
		gmem2 {Type O LastRead 4 FirstWrite 2}
		dstPtr {Type I LastRead 0 FirstWrite -1}}
	Mat2Axi {
		imgOutput_data {Type I LastRead 1 FirstWrite -1}
		gmem2 {Type O LastRead 4 FirstWrite 2}
		dout {Type I LastRead 1 FirstWrite -1}}
	entry_proc {
		dout {Type I LastRead 0 FirstWrite -1}
		dout_c {Type O LastRead -1 FirstWrite 0}}
	Mat2AxiStream {
		imgOutput_data {Type I LastRead 1 FirstWrite -1}
		ldata {Type O LastRead -1 FirstWrite 2}}
	MatStream2AxiStream_2_s {
		imgOutput_data {Type I LastRead 1 FirstWrite -1}
		ldata {Type O LastRead -1 FirstWrite 2}}
	MatStream2AxiStream_2_Pipeline_MMIterOutRow_MMIterOutCol {
		imgOutput_data {Type I LastRead 1 FirstWrite -1}
		ldata {Type O LastRead -1 FirstWrite 3}
		localbuffer_1_out {Type O LastRead -1 FirstWrite 2}
		filled_1_out {Type O LastRead -1 FirstWrite 2}}
	AxiStream2Axi {
		ldata {Type I LastRead 1 FirstWrite -1}
		gmem2 {Type O LastRead 4 FirstWrite 2}
		dout {Type I LastRead 0 FirstWrite -1}}
	AxiStream2Axi_Pipeline_MMIterOutLoop2 {
		gmem2 {Type O LastRead -1 FirstWrite 2}
		sext_ln1379 {Type I LastRead 0 FirstWrite -1}
		ldata {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2073607", "Max" : "2073607"}
	, {"Name" : "Interval", "Min" : "2073607", "Max" : "2073607"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	imgOutput_data { ap_fifo {  { imgOutput_data_dout fifo_data_in 0 24 }  { imgOutput_data_num_data_valid fifo_status_num_data_valid 0 3 }  { imgOutput_data_fifo_cap fifo_update 0 3 }  { imgOutput_data_empty_n fifo_status 0 1 }  { imgOutput_data_read fifo_port_we 1 1 } } }
	 { m_axi {  { m_axi_gmem2_AWVALID VALID 1 1 }  { m_axi_gmem2_AWREADY READY 0 1 }  { m_axi_gmem2_AWADDR ADDR 1 64 }  { m_axi_gmem2_AWID ID 1 1 }  { m_axi_gmem2_AWLEN SIZE 1 32 }  { m_axi_gmem2_AWSIZE BURST 1 3 }  { m_axi_gmem2_AWBURST LOCK 1 2 }  { m_axi_gmem2_AWLOCK CACHE 1 2 }  { m_axi_gmem2_AWCACHE PROT 1 4 }  { m_axi_gmem2_AWPROT QOS 1 3 }  { m_axi_gmem2_AWQOS REGION 1 4 }  { m_axi_gmem2_AWREGION USER 1 4 }  { m_axi_gmem2_AWUSER DATA 1 1 }  { m_axi_gmem2_WVALID VALID 1 1 }  { m_axi_gmem2_WREADY READY 0 1 }  { m_axi_gmem2_WDATA FIFONUM 1 32 }  { m_axi_gmem2_WSTRB STRB 1 4 }  { m_axi_gmem2_WLAST LAST 1 1 }  { m_axi_gmem2_WID ID 1 1 }  { m_axi_gmem2_WUSER DATA 1 1 }  { m_axi_gmem2_ARVALID VALID 1 1 }  { m_axi_gmem2_ARREADY READY 0 1 }  { m_axi_gmem2_ARADDR ADDR 1 64 }  { m_axi_gmem2_ARID ID 1 1 }  { m_axi_gmem2_ARLEN SIZE 1 32 }  { m_axi_gmem2_ARSIZE BURST 1 3 }  { m_axi_gmem2_ARBURST LOCK 1 2 }  { m_axi_gmem2_ARLOCK CACHE 1 2 }  { m_axi_gmem2_ARCACHE PROT 1 4 }  { m_axi_gmem2_ARPROT QOS 1 3 }  { m_axi_gmem2_ARQOS REGION 1 4 }  { m_axi_gmem2_ARREGION USER 1 4 }  { m_axi_gmem2_ARUSER DATA 1 1 }  { m_axi_gmem2_RVALID VALID 0 1 }  { m_axi_gmem2_RREADY READY 1 1 }  { m_axi_gmem2_RDATA FIFONUM 0 32 }  { m_axi_gmem2_RLAST LAST 0 1 }  { m_axi_gmem2_RID ID 0 1 }  { m_axi_gmem2_RFIFONUM LEN 0 9 }  { m_axi_gmem2_RUSER DATA 0 1 }  { m_axi_gmem2_RRESP RESP 0 2 }  { m_axi_gmem2_BVALID VALID 0 1 }  { m_axi_gmem2_BREADY READY 1 1 }  { m_axi_gmem2_BRESP RESP 0 2 }  { m_axi_gmem2_BID ID 0 1 }  { m_axi_gmem2_BUSER DATA 0 1 } } }
	dstPtr { ap_fifo {  { dstPtr_dout fifo_data_in 0 64 }  { dstPtr_num_data_valid fifo_status_num_data_valid 0 3 }  { dstPtr_fifo_cap fifo_update 0 3 }  { dstPtr_empty_n fifo_status 0 1 }  { dstPtr_read fifo_port_we 1 1 } } }
}
