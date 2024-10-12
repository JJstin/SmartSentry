; ModuleID = 'D:/design_project-code/SmartSentry/camera_fw/vitis/subtract_test/xf_cv_subtract/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<32>" = type { %"struct.ap_int_base<32, false>" }
%"struct.ap_int_base<32, false>" = type { %"struct.ssdm_int<32, false>" }
%"struct.ssdm_int<32, false>" = type { i32 }

; Function Attrs: noinline
define void @apatb_xf_cv_subtract_ir(%"struct.ap_uint<32>"* noalias nocapture nonnull readonly "maxi" %img_in1, %"struct.ap_uint<32>"* noalias nocapture nonnull readonly "maxi" %img_in2, %"struct.ap_uint<32>"* noalias nocapture nonnull "maxi" %img_out) local_unnamed_addr #0 {
entry:
  %malloccall = call i8* @malloc(i64 6220800)
  %img_in1_copy = bitcast i8* %malloccall to [1555200 x i32]*
  %malloccall1 = call i8* @malloc(i64 6220800)
  %img_in2_copy = bitcast i8* %malloccall1 to [1555200 x i32]*
  %malloccall2 = call i8* @malloc(i64 6220800)
  %img_out_copy = bitcast i8* %malloccall2 to [1555200 x i32]*
  %0 = bitcast %"struct.ap_uint<32>"* %img_in1 to [1555200 x %"struct.ap_uint<32>"]*
  %1 = bitcast %"struct.ap_uint<32>"* %img_in2 to [1555200 x %"struct.ap_uint<32>"]*
  %2 = bitcast %"struct.ap_uint<32>"* %img_out to [1555200 x %"struct.ap_uint<32>"]*
  call fastcc void @copy_in([1555200 x %"struct.ap_uint<32>"]* nonnull %0, [1555200 x i32]* %img_in1_copy, [1555200 x %"struct.ap_uint<32>"]* nonnull %1, [1555200 x i32]* %img_in2_copy, [1555200 x %"struct.ap_uint<32>"]* nonnull %2, [1555200 x i32]* %img_out_copy)
  call void @apatb_xf_cv_subtract_hw([1555200 x i32]* %img_in1_copy, [1555200 x i32]* %img_in2_copy, [1555200 x i32]* %img_out_copy)
  call void @copy_back([1555200 x %"struct.ap_uint<32>"]* %0, [1555200 x i32]* %img_in1_copy, [1555200 x %"struct.ap_uint<32>"]* %1, [1555200 x i32]* %img_in2_copy, [1555200 x %"struct.ap_uint<32>"]* %2, [1555200 x i32]* %img_out_copy)
  call void @free(i8* %malloccall)
  call void @free(i8* %malloccall1)
  call void @free(i8* %malloccall2)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([1555200 x %"struct.ap_uint<32>"]* noalias readonly "unpacked"="0", [1555200 x i32]* noalias nocapture "unpacked"="1.0", [1555200 x %"struct.ap_uint<32>"]* noalias readonly "unpacked"="2", [1555200 x i32]* noalias nocapture "unpacked"="3.0", [1555200 x %"struct.ap_uint<32>"]* noalias readonly "unpacked"="4", [1555200 x i32]* noalias nocapture "unpacked"="5.0") unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>"([1555200 x i32]* %1, [1555200 x %"struct.ap_uint<32>"]* %0)
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>"([1555200 x i32]* %3, [1555200 x %"struct.ap_uint<32>"]* %2)
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>"([1555200 x i32]* %5, [1555200 x %"struct.ap_uint<32>"]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a1555200struct.ap_uint<32>"([1555200 x %"struct.ap_uint<32>"]* %dst, [1555200 x %"struct.ap_uint<32>"]* readonly %src, i64 %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [1555200 x %"struct.ap_uint<32>"]* %src, null
  %1 = icmp eq [1555200 x %"struct.ap_uint<32>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [1555200 x %"struct.ap_uint<32>"], [1555200 x %"struct.ap_uint<32>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [1555200 x %"struct.ap_uint<32>"], [1555200 x %"struct.ap_uint<32>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %3, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="0", [1555200 x i32]* noalias nocapture readonly "unpacked"="1.0", [1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="2", [1555200 x i32]* noalias nocapture readonly "unpacked"="3.0", [1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="4", [1555200 x i32]* noalias nocapture readonly "unpacked"="5.0") unnamed_addr #3 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>.81"([1555200 x %"struct.ap_uint<32>"]* %0, [1555200 x i32]* %1)
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>.81"([1555200 x %"struct.ap_uint<32>"]* %2, [1555200 x i32]* %3)
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>.81"([1555200 x %"struct.ap_uint<32>"]* %4, [1555200 x i32]* %5)
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>.81"([1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="0" %dst, [1555200 x i32]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [1555200 x %"struct.ap_uint<32>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a1555200struct.ap_uint<32>.84"([1555200 x %"struct.ap_uint<32>"]* nonnull %dst, [1555200 x i32]* %src, i64 1555200)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a1555200struct.ap_uint<32>.84"([1555200 x %"struct.ap_uint<32>"]* "unpacked"="0" %dst, [1555200 x i32]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [1555200 x %"struct.ap_uint<32>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [1555200 x i32], [1555200 x i32]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [1555200 x %"struct.ap_uint<32>"], [1555200 x %"struct.ap_uint<32>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %1, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>"([1555200 x i32]* noalias nocapture "unpacked"="0.0" %dst, [1555200 x %"struct.ap_uint<32>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #4 {
entry:
  %0 = icmp eq [1555200 x %"struct.ap_uint<32>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a1555200struct.ap_uint<32>.91"([1555200 x i32]* %dst, [1555200 x %"struct.ap_uint<32>"]* nonnull %src, i64 1555200)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a1555200struct.ap_uint<32>.91"([1555200 x i32]* nocapture "unpacked"="0.0" %dst, [1555200 x %"struct.ap_uint<32>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [1555200 x %"struct.ap_uint<32>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [1555200 x %"struct.ap_uint<32>"], [1555200 x %"struct.ap_uint<32>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [1555200 x i32], [1555200 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %1, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_xf_cv_subtract_hw([1555200 x i32]*, [1555200 x i32]*, [1555200 x i32]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="0", [1555200 x i32]* noalias nocapture readonly "unpacked"="1.0", [1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="2", [1555200 x i32]* noalias nocapture readonly "unpacked"="3.0", [1555200 x %"struct.ap_uint<32>"]* noalias "unpacked"="4", [1555200 x i32]* noalias nocapture readonly "unpacked"="5.0") unnamed_addr #3 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a1555200struct.ap_uint<32>.81"([1555200 x %"struct.ap_uint<32>"]* %4, [1555200 x i32]* %5)
  ret void
}

define void @xf_cv_subtract_hw_stub_wrapper([1555200 x i32]*, [1555200 x i32]*, [1555200 x i32]*) #5 {
entry:
  %malloccall = tail call i8* @malloc(i64 6220800)
  %3 = bitcast i8* %malloccall to [1555200 x %"struct.ap_uint<32>"]*
  %malloccall1 = tail call i8* @malloc(i64 6220800)
  %4 = bitcast i8* %malloccall1 to [1555200 x %"struct.ap_uint<32>"]*
  %malloccall2 = tail call i8* @malloc(i64 6220800)
  %5 = bitcast i8* %malloccall2 to [1555200 x %"struct.ap_uint<32>"]*
  call void @copy_out([1555200 x %"struct.ap_uint<32>"]* %3, [1555200 x i32]* %0, [1555200 x %"struct.ap_uint<32>"]* %4, [1555200 x i32]* %1, [1555200 x %"struct.ap_uint<32>"]* %5, [1555200 x i32]* %2)
  %6 = bitcast [1555200 x %"struct.ap_uint<32>"]* %3 to %"struct.ap_uint<32>"*
  %7 = bitcast [1555200 x %"struct.ap_uint<32>"]* %4 to %"struct.ap_uint<32>"*
  %8 = bitcast [1555200 x %"struct.ap_uint<32>"]* %5 to %"struct.ap_uint<32>"*
  call void @xf_cv_subtract_hw_stub(%"struct.ap_uint<32>"* %6, %"struct.ap_uint<32>"* %7, %"struct.ap_uint<32>"* %8)
  call void @copy_in([1555200 x %"struct.ap_uint<32>"]* %3, [1555200 x i32]* %0, [1555200 x %"struct.ap_uint<32>"]* %4, [1555200 x i32]* %1, [1555200 x %"struct.ap_uint<32>"]* %5, [1555200 x i32]* %2)
  ret void
}

declare void @xf_cv_subtract_hw_stub(%"struct.ap_uint<32>"* noalias nocapture nonnull readonly, %"struct.ap_uint<32>"* noalias nocapture nonnull readonly, %"struct.ap_uint<32>"* noalias nocapture nonnull)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
