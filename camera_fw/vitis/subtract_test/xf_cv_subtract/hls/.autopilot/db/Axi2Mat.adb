<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
<!DOCTYPE boost_serialization>
<boost_serialization signature="serialization::archive" version="17">
  <syndb class_id="0" tracking_level="0" version="0">
    <userIPLatency>-1</userIPLatency>
    <userIPName/>
    <cdfg class_id="1" tracking_level="1" version="0" object_id="_0">
      <name>Axi2Mat</name>
      <module_structure>Dataflow</module_structure>
      <ret_bitwidth>0</ret_bitwidth>
      <ports class_id="2" tracking_level="0" version="0">
        <count>3</count>
        <item_version>0</item_version>
        <item class_id="3" tracking_level="1" version="0" object_id="_1">
          <Value class_id="4" tracking_level="0" version="0">
            <Obj class_id="5" tracking_level="0" version="0">
              <type>1</type>
              <id>1</id>
              <name>gmem1</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo class_id="6" tracking_level="0" version="0">
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>32</bitwidth>
          </Value>
          <direction>0</direction>
          <if_type>4</if_type>
          <array_size>0</array_size>
          <bit_vecs class_id="7" tracking_level="0" version="0">
            <count>0</count>
            <item_version>0</item_version>
          </bit_vecs>
        </item>
        <item class_id_reference="3" object_id="_2">
          <Value>
            <Obj>
              <type>1</type>
              <id>2</id>
              <name>din</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo>
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>64</bitwidth>
          </Value>
          <direction>0</direction>
          <if_type>0</if_type>
          <array_size>0</array_size>
          <bit_vecs>
            <count>0</count>
            <item_version>0</item_version>
          </bit_vecs>
        </item>
        <item class_id_reference="3" object_id="_3">
          <Value>
            <Obj>
              <type>1</type>
              <id>3</id>
              <name>imgInput2_data</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo>
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>24</bitwidth>
          </Value>
          <direction>1</direction>
          <if_type>3</if_type>
          <array_size>0</array_size>
          <bit_vecs>
            <count>0</count>
            <item_version>0</item_version>
          </bit_vecs>
        </item>
      </ports>
      <nodes class_id="8" tracking_level="0" version="0">
        <count>5</count>
        <item_version>0</item_version>
        <item class_id="9" tracking_level="1" version="0" object_id="_4">
          <Value>
            <Obj>
              <type>0</type>
              <id>7</id>
              <name>din_read</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo>
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>64</bitwidth>
          </Value>
          <oprand_edges>
            <count>2</count>
            <item_version>0</item_version>
            <item>16</item>
            <item>17</item>
          </oprand_edges>
          <opcode>read</opcode>
          <m_Display>0</m_Display>
          <m_isOnCriticalPath>0</m_isOnCriticalPath>
          <m_isLCDNode>0</m_isLCDNode>
          <m_isStartOfPath>0</m_isStartOfPath>
          <m_delay>0.00</m_delay>
          <m_topoIndex>1</m_topoIndex>
          <m_clusterGroupNumber>-1</m_clusterGroupNumber>
        </item>
        <item class_id_reference="9" object_id="_5">
          <Value>
            <Obj>
              <type>0</type>
              <id>8</id>
              <name>ldata</name>
              <fileName>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</fileName>
              <fileDirectory>../.</fileDirectory>
              <lineNumber>1143</lineNumber>
              <contextFuncName>Axi2Mat</contextFuncName>
              <contextNormFuncName>Axi2Mat</contextNormFuncName>
              <inlineStackInfo>
                <count>1</count>
                <item_version>0</item_version>
                <item class_id="11" tracking_level="0" version="0">
                  <first>D:\design_project-code\SmartSentry\camera_fw\vitis\subtract_test</first>
                  <second class_id="12" tracking_level="0" version="0">
                    <count>1</count>
                    <item_version>0</item_version>
                    <item class_id="13" tracking_level="0" version="0">
                      <first class_id="14" tracking_level="0" version="0">
                        <first>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</first>
                        <second>Axi2Mat</second>
                      </first>
                      <second>1143</second>
                    </item>
                  </second>
                </item>
              </inlineStackInfo>
              <originalName>ldata</originalName>
              <rtlName>ldata_U</rtlName>
              <control>auto</control>
              <opType>fifo</opType>
              <implIndex>srl</implIndex>
              <coreName>FIFO_SRL</coreName>
              <isStorage>1</isStorage>
              <storageDepth>2</storageDepth>
              <coreId>80</coreId>
              <rtlModuleName>xf_cv_subtract_fifo_w32_d2_S</rtlModuleName>
            </Obj>
            <bitwidth>32</bitwidth>
          </Value>
          <oprand_edges>
            <count>1</count>
            <item_version>0</item_version>
            <item>19</item>
          </oprand_edges>
          <opcode>alloca</opcode>
          <m_Display>0</m_Display>
          <m_isOnCriticalPath>0</m_isOnCriticalPath>
          <m_isLCDNode>0</m_isLCDNode>
          <m_isStartOfPath>0</m_isStartOfPath>
          <m_delay>0.00</m_delay>
          <m_topoIndex>2</m_topoIndex>
          <m_clusterGroupNumber>-1</m_clusterGroupNumber>
        </item>
        <item class_id_reference="9" object_id="_6">
          <Value>
            <Obj>
              <type>0</type>
              <id>11</id>
              <name>_ln1155</name>
              <fileName>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</fileName>
              <fileDirectory>../.</fileDirectory>
              <lineNumber>1155</lineNumber>
              <contextFuncName>Axi2Mat</contextFuncName>
              <contextNormFuncName>Axi2Mat</contextNormFuncName>
              <inlineStackInfo>
                <count>1</count>
                <item_version>0</item_version>
                <item>
                  <first>D:\design_project-code\SmartSentry\camera_fw\vitis\subtract_test</first>
                  <second>
                    <count>1</count>
                    <item_version>0</item_version>
                    <item>
                      <first>
                        <first>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</first>
                        <second>Axi2Mat</second>
                      </first>
                      <second>1155</second>
                    </item>
                  </second>
                </item>
              </inlineStackInfo>
              <originalName/>
              <rtlName>Axi2AxiStream_U0</rtlName>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>0</bitwidth>
          </Value>
          <oprand_edges>
            <count>4</count>
            <item_version>0</item_version>
            <item>21</item>
            <item>22</item>
            <item>23</item>
            <item>24</item>
          </oprand_edges>
          <opcode>call</opcode>
          <m_Display>0</m_Display>
          <m_isOnCriticalPath>0</m_isOnCriticalPath>
          <m_isLCDNode>0</m_isLCDNode>
          <m_isStartOfPath>0</m_isStartOfPath>
          <m_delay>7.30</m_delay>
          <m_topoIndex>3</m_topoIndex>
          <m_clusterGroupNumber>-1</m_clusterGroupNumber>
        </item>
        <item class_id_reference="9" object_id="_7">
          <Value>
            <Obj>
              <type>0</type>
              <id>12</id>
              <name>_ln1156</name>
              <fileName>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</fileName>
              <fileDirectory>../.</fileDirectory>
              <lineNumber>1156</lineNumber>
              <contextFuncName>Axi2Mat</contextFuncName>
              <contextNormFuncName>Axi2Mat</contextNormFuncName>
              <inlineStackInfo>
                <count>1</count>
                <item_version>0</item_version>
                <item>
                  <first>D:\design_project-code\SmartSentry\camera_fw\vitis\subtract_test</first>
                  <second>
                    <count>1</count>
                    <item_version>0</item_version>
                    <item>
                      <first>
                        <first>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</first>
                        <second>Axi2Mat</second>
                      </first>
                      <second>1156</second>
                    </item>
                  </second>
                </item>
              </inlineStackInfo>
              <originalName/>
              <rtlName>AxiStream2Mat_U0</rtlName>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>0</bitwidth>
          </Value>
          <oprand_edges>
            <count>5</count>
            <item_version>0</item_version>
            <item>26</item>
            <item>27</item>
            <item>28</item>
            <item>118</item>
            <item>119</item>
          </oprand_edges>
          <opcode>call</opcode>
          <m_Display>0</m_Display>
          <m_isOnCriticalPath>0</m_isOnCriticalPath>
          <m_isLCDNode>0</m_isLCDNode>
          <m_isStartOfPath>0</m_isStartOfPath>
          <m_delay>0.00</m_delay>
          <m_topoIndex>4</m_topoIndex>
          <m_clusterGroupNumber>-1</m_clusterGroupNumber>
        </item>
        <item class_id_reference="9" object_id="_8">
          <Value>
            <Obj>
              <type>0</type>
              <id>13</id>
              <name>_ln1157</name>
              <fileName>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</fileName>
              <fileDirectory>../.</fileDirectory>
              <lineNumber>1157</lineNumber>
              <contextFuncName>Axi2Mat</contextFuncName>
              <contextNormFuncName>Axi2Mat</contextNormFuncName>
              <inlineStackInfo>
                <count>1</count>
                <item_version>0</item_version>
                <item>
                  <first>D:\design_project-code\SmartSentry\camera_fw\vitis\subtract_test</first>
                  <second>
                    <count>1</count>
                    <item_version>0</item_version>
                    <item>
                      <first>
                        <first>D:/Xilinx/Vitis_Libraries/vision/L1/include\common/xf_structs.hpp</first>
                        <second>Axi2Mat</second>
                      </first>
                      <second>1157</second>
                    </item>
                  </second>
                </item>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>0</bitwidth>
          </Value>
          <oprand_edges>
            <count>0</count>
            <item_version>0</item_version>
          </oprand_edges>
          <opcode>ret</opcode>
          <m_Display>0</m_Display>
          <m_isOnCriticalPath>0</m_isOnCriticalPath>
          <m_isLCDNode>0</m_isLCDNode>
          <m_isStartOfPath>0</m_isStartOfPath>
          <m_delay>0.00</m_delay>
          <m_topoIndex>5</m_topoIndex>
          <m_clusterGroupNumber>-1</m_clusterGroupNumber>
        </item>
      </nodes>
      <consts class_id="15" tracking_level="0" version="0">
        <count>3</count>
        <item_version>0</item_version>
        <item class_id="16" tracking_level="1" version="0" object_id="_9">
          <Value>
            <Obj>
              <type>2</type>
              <id>18</id>
              <name>empty</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo>
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>64</bitwidth>
          </Value>
          <const_type>0</const_type>
          <content>1</content>
        </item>
        <item class_id_reference="16" object_id="_10">
          <Value>
            <Obj>
              <type>2</type>
              <id>20</id>
              <name>Axi2AxiStream</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo>
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>0</bitwidth>
          </Value>
          <const_type>6</const_type>
          <content>&lt;constant:Axi2AxiStream&gt;</content>
        </item>
        <item class_id_reference="16" object_id="_11">
          <Value>
            <Obj>
              <type>2</type>
              <id>25</id>
              <name>AxiStream2Mat</name>
              <fileName/>
              <fileDirectory/>
              <lineNumber>0</lineNumber>
              <contextFuncName/>
              <contextNormFuncName/>
              <inlineStackInfo>
                <count>0</count>
                <item_version>0</item_version>
              </inlineStackInfo>
              <originalName/>
              <rtlName/>
              <control/>
              <opType/>
              <implIndex/>
              <coreName/>
              <isStorage>0</isStorage>
              <storageDepth>0</storageDepth>
              <coreId>4294967295</coreId>
              <rtlModuleName/>
            </Obj>
            <bitwidth>0</bitwidth>
          </Value>
          <const_type>6</const_type>
          <content>&lt;constant:AxiStream2Mat&gt;</content>
        </item>
      </consts>
      <blocks class_id="17" tracking_level="0" version="0">
        <count>1</count>
        <item_version>0</item_version>
        <item class_id="18" tracking_level="1" version="0" object_id="_12">
          <Obj>
            <type>3</type>
            <id>14</id>
            <name>Axi2Mat</name>
            <fileName/>
            <fileDirectory/>
            <lineNumber>0</lineNumber>
            <contextFuncName/>
            <contextNormFuncName/>
            <inlineStackInfo>
              <count>0</count>
              <item_version>0</item_version>
            </inlineStackInfo>
            <originalName/>
            <rtlName/>
            <control/>
            <opType/>
            <implIndex/>
            <coreName/>
            <isStorage>0</isStorage>
            <storageDepth>0</storageDepth>
            <coreId>4294967295</coreId>
            <rtlModuleName/>
          </Obj>
          <node_objs>
            <count>5</count>
            <item_version>0</item_version>
            <item>7</item>
            <item>8</item>
            <item>11</item>
            <item>12</item>
            <item>13</item>
          </node_objs>
        </item>
      </blocks>
      <edges class_id="19" tracking_level="0" version="0">
        <count>11</count>
        <item_version>0</item_version>
        <item class_id="20" tracking_level="1" version="0" object_id="_13">
          <id>17</id>
          <edge_type>1</edge_type>
          <source_obj>2</source_obj>
          <sink_obj>7</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_14">
          <id>19</id>
          <edge_type>1</edge_type>
          <source_obj>18</source_obj>
          <sink_obj>8</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_15">
          <id>21</id>
          <edge_type>1</edge_type>
          <source_obj>20</source_obj>
          <sink_obj>11</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_16">
          <id>22</id>
          <edge_type>1</edge_type>
          <source_obj>1</source_obj>
          <sink_obj>11</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_17">
          <id>23</id>
          <edge_type>1</edge_type>
          <source_obj>7</source_obj>
          <sink_obj>11</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_18">
          <id>24</id>
          <edge_type>1</edge_type>
          <source_obj>8</source_obj>
          <sink_obj>11</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_19">
          <id>26</id>
          <edge_type>1</edge_type>
          <source_obj>25</source_obj>
          <sink_obj>12</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_20">
          <id>27</id>
          <edge_type>1</edge_type>
          <source_obj>8</source_obj>
          <sink_obj>12</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_21">
          <id>28</id>
          <edge_type>1</edge_type>
          <source_obj>3</source_obj>
          <sink_obj>12</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_22">
          <id>118</id>
          <edge_type>4</edge_type>
          <source_obj>11</source_obj>
          <sink_obj>12</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
        <item class_id_reference="20" object_id="_23">
          <id>119</id>
          <edge_type>4</edge_type>
          <source_obj>11</source_obj>
          <sink_obj>12</sink_obj>
          <is_back_edge>0</is_back_edge>
        </item>
      </edges>
    </cdfg>
    <cdfg_regions class_id="21" tracking_level="0" version="0">
      <count>1</count>
      <item_version>0</item_version>
      <item class_id="22" tracking_level="1" version="0" object_id="_24">
        <mId>1</mId>
        <mTag>Axi2Mat</mTag>
        <mNormTag>Axi2Mat</mNormTag>
        <mType>0</mType>
        <sub_regions>
          <count>0</count>
          <item_version>0</item_version>
        </sub_regions>
        <basic_blocks>
          <count>1</count>
          <item_version>0</item_version>
          <item>14</item>
        </basic_blocks>
        <mII>-1</mII>
        <mDepth>-1</mDepth>
        <mMinTripCount>-1</mMinTripCount>
        <mMaxTripCount>-1</mMaxTripCount>
        <mMinLatency>4147215</mMinLatency>
        <mMaxLatency>4147215</mMaxLatency>
        <mIsDfPipe>1</mIsDfPipe>
        <mDfPipe class_id="23" tracking_level="1" version="0" object_id="_25">
          <port_list class_id="24" tracking_level="0" version="0">
            <count>3</count>
            <item_version>0</item_version>
            <item class_id="25" tracking_level="1" version="0" object_id="_26">
              <name>gmem1</name>
              <dir>0</dir>
              <type>1</type>
              <need_hs>1</need_hs>
              <top_port class_id="-1"/>
              <chan class_id="-1"/>
            </item>
            <item class_id_reference="25" object_id="_27">
              <name>din</name>
              <dir>0</dir>
              <type>3</type>
              <need_hs>1</need_hs>
              <top_port class_id="-1"/>
              <chan class_id="-1"/>
            </item>
            <item class_id_reference="25" object_id="_28">
              <name>imgInput2_data</name>
              <dir>1</dir>
              <type>0</type>
              <need_hs>0</need_hs>
              <top_port class_id="-1"/>
              <chan class_id="-1"/>
            </item>
          </port_list>
          <process_list class_id="27" tracking_level="0" version="0">
            <count>2</count>
            <item_version>0</item_version>
            <item class_id="28" tracking_level="1" version="0" object_id="_29">
              <type>0</type>
              <name>Axi2AxiStream_U0</name>
              <ssdmobj_id>11</ssdmobj_id>
              <pins class_id="29" tracking_level="0" version="0">
                <count>2</count>
                <item_version>0</item_version>
                <item class_id="30" tracking_level="1" version="0" object_id="_30">
                  <port class_id_reference="25" object_id="_31">
                    <name>gmem1</name>
                    <dir>0</dir>
                    <type>1</type>
                    <need_hs>1</need_hs>
                    <top_port class_id_reference="25" object_id_reference="_26"/>
                    <chan class_id="-1"/>
                  </port>
                  <inst class_id="31" tracking_level="1" version="0" object_id="_32">
                    <type>0</type>
                    <name>Axi2AxiStream_U0</name>
                    <ssdmobj_id>11</ssdmobj_id>
                  </inst>
                </item>
                <item class_id_reference="30" object_id="_33">
                  <port class_id_reference="25" object_id="_34">
                    <name>din</name>
                    <dir>0</dir>
                    <type>3</type>
                    <need_hs>1</need_hs>
                    <top_port class_id_reference="25" object_id_reference="_27"/>
                    <chan class_id="-1"/>
                  </port>
                  <inst class_id_reference="31" object_id_reference="_32"/>
                </item>
              </pins>
              <in_source_fork>1</in_source_fork>
              <in_sink_join>0</in_sink_join>
              <flag_in_gui>0</flag_in_gui>
            </item>
            <item class_id_reference="28" object_id="_35">
              <type>0</type>
              <name>AxiStream2Mat_U0</name>
              <ssdmobj_id>12</ssdmobj_id>
              <pins>
                <count>1</count>
                <item_version>0</item_version>
                <item class_id_reference="30" object_id="_36">
                  <port class_id_reference="25" object_id="_37">
                    <name>imgInput2_data</name>
                    <dir>1</dir>
                    <type>0</type>
                    <need_hs>0</need_hs>
                    <top_port class_id_reference="25" object_id_reference="_28"/>
                    <chan class_id="-1"/>
                  </port>
                  <inst class_id_reference="31" object_id="_38">
                    <type>0</type>
                    <name>AxiStream2Mat_U0</name>
                    <ssdmobj_id>12</ssdmobj_id>
                  </inst>
                </item>
              </pins>
              <in_source_fork>0</in_source_fork>
              <in_sink_join>1</in_sink_join>
              <flag_in_gui>0</flag_in_gui>
            </item>
          </process_list>
          <channel_list class_id="32" tracking_level="0" version="0">
            <count>1</count>
            <item_version>0</item_version>
            <item class_id="26" tracking_level="1" version="0" object_id="_39">
              <type>1</type>
              <name>ldata</name>
              <ssdmobj_id>8</ssdmobj_id>
              <ctype>0</ctype>
              <depth>2</depth>
              <bitwidth>32</bitwidth>
              <suggested_type>0</suggested_type>
              <suggested_depth>2</suggested_depth>
              <source_list>
                <count>1</count>
                <item_version>0</item_version>
                <item class_id_reference="30" object_id="_40">
                  <port class_id_reference="25" object_id="_41">
                    <name>in</name>
                    <dir>0</dir>
                    <type>3</type>
                    <need_hs>0</need_hs>
                    <top_port class_id="-1"/>
                    <chan class_id="-1"/>
                  </port>
                  <inst class_id_reference="31" object_id_reference="_32"/>
                </item>
              </source_list>
              <sink_list>
                <count>1</count>
                <item_version>0</item_version>
                <item class_id_reference="30" object_id="_42">
                  <port class_id_reference="25" object_id="_43">
                    <name>out</name>
                    <dir>1</dir>
                    <type>3</type>
                    <need_hs>0</need_hs>
                    <top_port class_id="-1"/>
                    <chan class_id="-1"/>
                  </port>
                  <inst class_id_reference="31" object_id_reference="_38"/>
                </item>
              </sink_list>
              <bram_cost>0</bram_cost>
              <uram_cost>0</uram_cost>
              <storage_size>32 2 1</storage_size>
            </item>
          </channel_list>
          <net_list class_id="33" tracking_level="0" version="0">
            <count>0</count>
            <item_version>0</item_version>
          </net_list>
        </mDfPipe>
      </item>
    </cdfg_regions>
    <fsm class_id="34" tracking_level="1" version="0" object_id="_44">
      <states class_id="35" tracking_level="0" version="0">
        <count>4</count>
        <item_version>0</item_version>
        <item class_id="36" tracking_level="1" version="0" object_id="_45">
          <id>1</id>
          <operations class_id="37" tracking_level="0" version="0">
            <count>3</count>
            <item_version>0</item_version>
            <item class_id="38" tracking_level="1" version="0" object_id="_46">
              <id>7</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_47">
              <id>8</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_48">
              <id>11</id>
              <stage>2</stage>
              <latency>2</latency>
            </item>
          </operations>
        </item>
        <item class_id_reference="36" object_id="_49">
          <id>2</id>
          <operations>
            <count>1</count>
            <item_version>0</item_version>
            <item class_id_reference="38" object_id="_50">
              <id>11</id>
              <stage>1</stage>
              <latency>2</latency>
            </item>
          </operations>
        </item>
        <item class_id_reference="36" object_id="_51">
          <id>3</id>
          <operations>
            <count>1</count>
            <item_version>0</item_version>
            <item class_id_reference="38" object_id="_52">
              <id>12</id>
              <stage>2</stage>
              <latency>2</latency>
            </item>
          </operations>
        </item>
        <item class_id_reference="36" object_id="_53">
          <id>4</id>
          <operations>
            <count>7</count>
            <item_version>0</item_version>
            <item class_id_reference="38" object_id="_54">
              <id>4</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_55">
              <id>5</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_56">
              <id>6</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_57">
              <id>9</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_58">
              <id>10</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
            <item class_id_reference="38" object_id="_59">
              <id>12</id>
              <stage>1</stage>
              <latency>2</latency>
            </item>
            <item class_id_reference="38" object_id="_60">
              <id>13</id>
              <stage>1</stage>
              <latency>1</latency>
            </item>
          </operations>
        </item>
      </states>
      <transitions class_id="39" tracking_level="0" version="0">
        <count>3</count>
        <item_version>0</item_version>
        <item class_id="40" tracking_level="1" version="0" object_id="_61">
          <inState>1</inState>
          <outState>2</outState>
          <condition class_id="41" tracking_level="0" version="0">
            <id>-1</id>
            <sop class_id="42" tracking_level="0" version="0">
              <count>1</count>
              <item_version>0</item_version>
              <item class_id="43" tracking_level="0" version="0">
                <count>0</count>
                <item_version>0</item_version>
              </item>
            </sop>
          </condition>
        </item>
        <item class_id_reference="40" object_id="_62">
          <inState>2</inState>
          <outState>3</outState>
          <condition>
            <id>-1</id>
            <sop>
              <count>1</count>
              <item_version>0</item_version>
              <item>
                <count>0</count>
                <item_version>0</item_version>
              </item>
            </sop>
          </condition>
        </item>
        <item class_id_reference="40" object_id="_63">
          <inState>3</inState>
          <outState>4</outState>
          <condition>
            <id>-1</id>
            <sop>
              <count>1</count>
              <item_version>0</item_version>
              <item>
                <count>0</count>
                <item_version>0</item_version>
              </item>
            </sop>
          </condition>
        </item>
      </transitions>
    </fsm>
    <res class_id="44" tracking_level="1" version="0" object_id="_64">
      <dp_component_resource class_id="45" tracking_level="0" version="0">
        <count>3</count>
        <item_version>0</item_version>
        <item class_id="46" tracking_level="0" version="0">
          <first>Axi2AxiStream_U0 (Axi2AxiStream)</first>
          <second class_id="47" tracking_level="0" version="0">
            <count>2</count>
            <item_version>0</item_version>
            <item class_id="48" tracking_level="0" version="0">
              <first>FF</first>
              <second>133</second>
            </item>
            <item>
              <first>LUT</first>
              <second>343</second>
            </item>
          </second>
        </item>
        <item>
          <first>AxiStream2Mat_U0 (AxiStream2Mat)</first>
          <second>
            <count>2</count>
            <item_version>0</item_version>
            <item>
              <first>FF</first>
              <second>479</second>
            </item>
            <item>
              <first>LUT</first>
              <second>1642</second>
            </item>
          </second>
        </item>
        <item>
          <first>start_for_AxiStream2Mat_U0_U (start_for_AxiStream2Mat_U0)</first>
          <second>
            <count>0</count>
            <item_version>0</item_version>
          </second>
        </item>
      </dp_component_resource>
      <dp_expression_resource>
        <count>1</count>
        <item_version>0</item_version>
        <item>
          <first>ap_idle ( and ) </first>
          <second>
            <count>4</count>
            <item_version>0</item_version>
            <item>
              <first>(0P0)</first>
              <second>1</second>
            </item>
            <item>
              <first>(1P1)</first>
              <second>1</second>
            </item>
            <item>
              <first>FF</first>
              <second>0</second>
            </item>
            <item>
              <first>LUT</first>
              <second>2</second>
            </item>
          </second>
        </item>
      </dp_expression_resource>
      <dp_fifo_resource>
        <count>1</count>
        <item_version>0</item_version>
        <item>
          <first>ldata_U</first>
          <second>
            <count>5</count>
            <item_version>0</item_version>
            <item>
              <first>(0Depth)</first>
              <second>2</second>
            </item>
            <item>
              <first>(1Bits)</first>
              <second>32</second>
            </item>
            <item>
              <first>(2Size:D*B)</first>
              <second>64</second>
            </item>
            <item>
              <first>FF</first>
              <second>99</second>
            </item>
            <item>
              <first>LUT</first>
              <second>68</second>
            </item>
          </second>
        </item>
      </dp_fifo_resource>
      <dp_memory_resource>
        <count>0</count>
        <item_version>0</item_version>
      </dp_memory_resource>
      <dp_multiplexer_resource>
        <count>0</count>
        <item_version>0</item_version>
      </dp_multiplexer_resource>
      <dp_register_resource>
        <count>0</count>
        <item_version>0</item_version>
      </dp_register_resource>
      <dp_dsp_resource>
        <count>3</count>
        <item_version>0</item_version>
        <item>
          <first>Axi2AxiStream_U0</first>
          <second>
            <count>0</count>
            <item_version>0</item_version>
          </second>
        </item>
        <item>
          <first>AxiStream2Mat_U0</first>
          <second>
            <count>0</count>
            <item_version>0</item_version>
          </second>
        </item>
        <item>
          <first>start_for_AxiStream2Mat_U0_U</first>
          <second>
            <count>0</count>
            <item_version>0</item_version>
          </second>
        </item>
      </dp_dsp_resource>
      <dp_component_map class_id="49" tracking_level="0" version="0">
        <count>2</count>
        <item_version>0</item_version>
        <item class_id="50" tracking_level="0" version="0">
          <first>Axi2AxiStream_U0 (Axi2AxiStream)</first>
          <second>
            <count>1</count>
            <item_version>0</item_version>
            <item>11</item>
          </second>
        </item>
        <item>
          <first>AxiStream2Mat_U0 (AxiStream2Mat)</first>
          <second>
            <count>1</count>
            <item_version>0</item_version>
            <item>12</item>
          </second>
        </item>
      </dp_component_map>
      <dp_expression_map>
        <count>0</count>
        <item_version>0</item_version>
      </dp_expression_map>
      <dp_fifo_map>
        <count>1</count>
        <item_version>0</item_version>
        <item>
          <first>ldata_U</first>
          <second>
            <count>1</count>
            <item_version>0</item_version>
            <item>141</item>
          </second>
        </item>
      </dp_fifo_map>
      <dp_memory_map>
        <count>0</count>
        <item_version>0</item_version>
      </dp_memory_map>
    </res>
    <node_label_latency class_id="51" tracking_level="0" version="0">
      <count>5</count>
      <item_version>0</item_version>
      <item class_id="52" tracking_level="0" version="0">
        <first>7</first>
        <second class_id="53" tracking_level="0" version="0">
          <first>0</first>
          <second>0</second>
        </second>
      </item>
      <item>
        <first>8</first>
        <second>
          <first>0</first>
          <second>0</second>
        </second>
      </item>
      <item>
        <first>11</first>
        <second>
          <first>0</first>
          <second>1</second>
        </second>
      </item>
      <item>
        <first>12</first>
        <second>
          <first>2</first>
          <second>1</second>
        </second>
      </item>
      <item>
        <first>13</first>
        <second>
          <first>3</first>
          <second>0</second>
        </second>
      </item>
    </node_label_latency>
    <bblk_ent_exit class_id="54" tracking_level="0" version="0">
      <count>1</count>
      <item_version>0</item_version>
      <item class_id="55" tracking_level="0" version="0">
        <first>14</first>
        <second class_id="56" tracking_level="0" version="0">
          <first>0</first>
          <second>3</second>
        </second>
      </item>
    </bblk_ent_exit>
    <regions class_id="57" tracking_level="0" version="0">
      <count>1</count>
      <item_version>0</item_version>
      <item class_id="58" tracking_level="1" version="0" object_id="_65">
        <region_name>Axi2Mat</region_name>
        <basic_blocks>
          <count>1</count>
          <item_version>0</item_version>
          <item>14</item>
        </basic_blocks>
        <nodes>
          <count>10</count>
          <item_version>0</item_version>
          <item>4</item>
          <item>5</item>
          <item>6</item>
          <item>7</item>
          <item>8</item>
          <item>9</item>
          <item>10</item>
          <item>11</item>
          <item>12</item>
          <item>13</item>
        </nodes>
        <anchor_node>-1</anchor_node>
        <region_type>16</region_type>
        <interval>0</interval>
        <pipe_depth>0</pipe_depth>
        <mDBIIViolationVec class_id="59" tracking_level="0" version="0">
          <count>0</count>
          <item_version>0</item_version>
        </mDBIIViolationVec>
      </item>
    </regions>
    <dp_fu_nodes class_id="60" tracking_level="0" version="0">
      <count>4</count>
      <item_version>0</item_version>
      <item class_id="61" tracking_level="0" version="0">
        <first>46</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>8</item>
        </second>
      </item>
      <item>
        <first>50</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>7</item>
        </second>
      </item>
      <item>
        <first>56</first>
        <second>
          <count>2</count>
          <item_version>0</item_version>
          <item>11</item>
          <item>11</item>
        </second>
      </item>
      <item>
        <first>65</first>
        <second>
          <count>2</count>
          <item_version>0</item_version>
          <item>12</item>
          <item>12</item>
        </second>
      </item>
    </dp_fu_nodes>
    <dp_fu_nodes_expression class_id="63" tracking_level="0" version="0">
      <count>1</count>
      <item_version>0</item_version>
      <item class_id="64" tracking_level="0" version="0">
        <first>ldata_fu_46</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>8</item>
        </second>
      </item>
    </dp_fu_nodes_expression>
    <dp_fu_nodes_module>
      <count>2</count>
      <item_version>0</item_version>
      <item>
        <first>grp_Axi2AxiStream_fu_56</first>
        <second>
          <count>2</count>
          <item_version>0</item_version>
          <item>11</item>
          <item>11</item>
        </second>
      </item>
      <item>
        <first>grp_AxiStream2Mat_fu_65</first>
        <second>
          <count>2</count>
          <item_version>0</item_version>
          <item>12</item>
          <item>12</item>
        </second>
      </item>
    </dp_fu_nodes_module>
    <dp_fu_nodes_io>
      <count>1</count>
      <item_version>0</item_version>
      <item>
        <first>din_read_read_fu_50</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>7</item>
        </second>
      </item>
    </dp_fu_nodes_io>
    <return_ports>
      <count>0</count>
      <item_version>0</item_version>
    </return_ports>
    <dp_mem_port_nodes class_id="65" tracking_level="0" version="0">
      <count>0</count>
      <item_version>0</item_version>
    </dp_mem_port_nodes>
    <dp_reg_nodes>
      <count>2</count>
      <item_version>0</item_version>
      <item>
        <first>72</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>7</item>
        </second>
      </item>
      <item>
        <first>77</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>8</item>
        </second>
      </item>
    </dp_reg_nodes>
    <dp_regname_nodes>
      <count>2</count>
      <item_version>0</item_version>
      <item>
        <first>din_read_reg_72</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>7</item>
        </second>
      </item>
      <item>
        <first>ldata_reg_77</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>8</item>
        </second>
      </item>
    </dp_regname_nodes>
    <dp_reg_phi>
      <count>0</count>
      <item_version>0</item_version>
    </dp_reg_phi>
    <dp_regname_phi>
      <count>0</count>
      <item_version>0</item_version>
    </dp_regname_phi>
    <dp_port_io_nodes class_id="66" tracking_level="0" version="0">
      <count>3</count>
      <item_version>0</item_version>
      <item class_id="67" tracking_level="0" version="0">
        <first>din</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>
            <first>read</first>
            <second>
              <count>1</count>
              <item_version>0</item_version>
              <item>7</item>
            </second>
          </item>
        </second>
      </item>
      <item>
        <first>gmem1</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>
            <first>call</first>
            <second>
              <count>1</count>
              <item_version>0</item_version>
              <item>11</item>
            </second>
          </item>
        </second>
      </item>
      <item>
        <first>imgInput2_data</first>
        <second>
          <count>1</count>
          <item_version>0</item_version>
          <item>
            <first>call</first>
            <second>
              <count>1</count>
              <item_version>0</item_version>
              <item>12</item>
            </second>
          </item>
        </second>
      </item>
    </dp_port_io_nodes>
    <port2core>
      <count>0</count>
      <item_version>0</item_version>
    </port2core>
    <node2core>
      <count>3</count>
      <item_version>0</item_version>
      <item>
        <first>8</first>
        <second>
          <first>666</first>
          <second>10</second>
        </second>
      </item>
      <item>
        <first>11</first>
        <second>
          <first>-1</first>
          <second>-1</second>
        </second>
      </item>
      <item>
        <first>12</first>
        <second>
          <first>-1</first>
          <second>-1</second>
        </second>
      </item>
    </node2core>
  </syndb>
</boost_serialization>
