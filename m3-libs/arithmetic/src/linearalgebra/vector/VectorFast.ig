GENERIC INTERFACE VectorFast(R,VB);
(*Copyright (c) 1996, m3na project

Abstract: Vector math

2/17/96  Harry George    Convert from Objects to ADT's
*)
FROM NADefinitions IMPORT Error;
(*==========================*)

CONST
  Brand = VB.Brand;

TYPE
  (*text form: "V6{a0,a1,a2,a3,a4,a5}"*)
  TBody = ARRAY OF R.T;
  T     = REF TBody;

CONST
  New       = VB.New;
  FromArray = VB.FromArray;
  Copy      = VB.Copy;

(*
PROCEDURE Zero(x:T);                   (*set to zero*)
    (*NOTE: you should make unit vectors as needed*)
*)

PROCEDURE IsZero(x:T):BOOLEAN;
PROCEDURE Equal(x,y:T):BOOLEAN RAISES {Error};  (*return x=y*)

PROCEDURE Add(x,y:T):T RAISES {Error};   (*x+y*)
PROCEDURE Sub(x,y:T):T RAISES {Error};   (*x-y*)
PROCEDURE Neg(x:T):T;    (*return -x *)

PROCEDURE Scale(x:T; y:R.T):T;            (*x:=x*factor*)
PROCEDURE Inner(x,y:T):R.T RAISES {Error};   (*<x,y>*)
(*
PROCEDURE Cross(x,y:T):T RAISES {Error}; (*x x y*)
*)

TYPE
  ApplyFtn  = VB.ApplyFtn;
  MapFtn    = VB.MapFtn;
  ReduceFtn = VB.ReduceFtn;

CONST
  Apply  = VB.Apply;
  Map    = VB.Map;
  Reduce = VB.Reduce;

PROCEDURE Sum(READONLY x:TBody):R.T;
PROCEDURE Max(READONLY x:TBody):R.T;
PROCEDURE Min(READONLY x:TBody):R.T;

(*==========================*)
END VectorFast.
