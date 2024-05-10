import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:ffi/ffi.dart';
import 'dart:typed_data';

// double BDL2(double L1, double B1, double A1, double S, int earth);
// double BDB2(double L1, double B1, double A1, double S, int earth);
// double BDA2(double L1, double B1, double A1, double S, int earth);
// double BIA1(double L1, double B1, double L2, double B2, int earth);
// double BIA2(double L1, double B1, double L2, double B2, int earth);
// double BIS(double L1, double B1, double L2, double B2, int earth);
// double GFx(double B, double L, int L_num, int mode, int earth);
// double GFy(double B, double L, int L_num, int mode, int earth);
// double GBB(double x, double y, int L_num, int mode, int earth);
// double GBL(double x, double y, int L_num, int mode, int earth);
// double GCx(double originx, double originy, int originZone, int targetZone, int mode, int earth);
// double GCy(double originx, double originy, int originZone, int targetZone, int mode, int earth)

//Native签名
typedef BDL2Native = Double Function(Double,Double,Double,Double,Int32);
typedef BDB2Native = Double Function(Double,Double,Double,Double,Int32);
typedef BDA2Native = Double Function(Double,Double,Double,Double,Int32);
typedef BIA1Native = Double Function(Double,Double,Double,Double,Int32);
typedef BIA2Native = Double Function(Double,Double,Double,Double,Int32);
typedef BISNative = Double Function(Double,Double,Double,Double,Int32);
typedef GFxNative = Double Function(Double,Double,Int32,Int32,Int32);
typedef GFyNative = Double Function(Double,Double,Int32,Int32,Int32);
typedef GBBNative = Double Function(Double,Double,Int32,Int32,Int32);
typedef GBLNative = Double Function(Double,Double,Int32,Int32,Int32);
typedef GCxNative = Double Function(Double,Double,Int32,Int32,Int32,Int32);
typedef GCyNative = Double Function(Double,Double,Int32,Int32,Int32,Int32);
//Dart函数签名
typedef BDL2Dart = double Function(double,double,double,double,int);
typedef BDB2Dart = double Function(double,double,double,double,int);
typedef BDA2Dart = double Function(double,double,double,double,int);
typedef BIA1Dart = double Function(double,double,double,double,int);
typedef BIA2Dart = double Function(double,double,double,double,int);
typedef BISDart = double Function(double,double,double,double,int);
typedef GFxDart = double Function(double,double,int,int,int);
typedef GFyDart = double Function(double,double,int,int,int);
typedef GBBDart = double Function(double,double,int,int,int);
typedef GBLDart = double Function(double,double,int,int,int);
typedef GCxDart = double Function(double,double,int,int,int,int);
typedef GCyDart = double Function(double,double,int,int,int,int);

var dyn = DynamicLibrary.open("libGA.dll");
BDL2Dart BDL2 = dyn.lookupFunction<BDL2Native,BDL2Dart>("BDL2");
BDB2Dart BDB2 = dyn.lookupFunction<BDB2Native,BDB2Dart>("BDB2");
BDA2Dart BDA2 = dyn.lookupFunction<BDA2Native,BDA2Dart>("BDA2");
BIA1Dart BIA1 = dyn.lookupFunction<BIA1Native,BIA1Dart>("BIA1");
BIA2Dart BIA2 = dyn.lookupFunction<BIA2Native,BIA2Dart>("BIA2");
BISDart BIS = dyn.lookupFunction<BISNative,BISDart>("BIS");
GFxDart GFx= dyn.lookupFunction<GFxNative,GFxDart>("GFx");
GFxDart GFy= dyn.lookupFunction<GFxNative,GFxDart>("GFy");
GFxDart GBB= dyn.lookupFunction<GFxNative,GFxDart>("GBB");
GFxDart GBL= dyn.lookupFunction<GFxNative,GFxDart>("GBL");
GCxDart GCx = dyn.lookupFunction<GCxNative,GCxDart>("GCx");
GCyDart GCy = dyn.lookupFunction<GCxNative,GCxDart>("GCy");