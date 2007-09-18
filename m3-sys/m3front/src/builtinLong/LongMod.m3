(* Copyright (C) 1992, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)

(* File: LongMod.m3                                            *)
(* Last Modified On Mon Dec  5 15:30:47 PST 1994 By kalsow     *)
(*      Modified On Tue Apr 10 11:14:57 1990 By muller         *)

MODULE LongMod;

IMPORT CG, CallExpr, Expr, ExprRep, Procedure, ProcType, TInt;
IMPORT IntegerExpr, Value, Formal, Target, TWord;
FROM LInt IMPORT T;
IMPORT LongPlus AS Plus;

VAR Z: CallExpr.MethodList;
VAR formals: Value.T;

PROCEDURE Check (ce: CallExpr.T;  VAR cs: Expr.CheckState) =
  BEGIN
    EVAL Formal.CheckArgs (cs, ce.args, formals, ce.proc);
    ce.type := T;
  END Check;

PROCEDURE Compile (ce: CallExpr.T) =
  BEGIN
    Expr.Compile (ce.args[0]);
    Expr.Compile (ce.args[1]);
    CG.Mod (Target.Long.cg_type, Expr.GetSign (ce.args[0]),
                                 Expr.GetSign (ce.args[1]));
  END Compile;

PROCEDURE Fold (ce: CallExpr.T): Expr.T =
  VAR w0, w1, result: Target.Int;
  BEGIN
    IF Plus.GetArgs (ce.args, w0, w1) AND TWord.Mod (w0, w1, result) THEN
      RETURN IntegerExpr.New (T, result);
    END;
    RETURN NIL;
  END Fold;

PROCEDURE GetBounds (ce: CallExpr.T;  VAR min, max: Target.Int) =
  VAR min_b, max_b: Target.Int;
  BEGIN
    Expr.GetBounds (ce.args[1], min_b, max_b);
    IF TInt.LT (min_b, TInt.Zero) OR TInt.LT (max_b, TInt.Zero) THEN
      (* almost anything is possible *)
      min := Target.Longint.min;
      max := Target.Longint.max;
    ELSE
      min := TInt.Zero;
      TWord.Subtract (max_b, TInt.One, max);
    END;
  END GetBounds;

PROCEDURE Initialize () =
  VAR
    x0 := Formal.NewBuiltin ("x", 0, T);
    y0 := Formal.NewBuiltin ("y", 1, T);
    t0 := ProcType.New (T, x0, y0);
  BEGIN
    Z := CallExpr.NewMethodList (2, 2, TRUE, TRUE, TRUE, T,
                                 NIL,
                                 CallExpr.NotAddressable,
                                 Check,
                                 CallExpr.PrepArgs,
                                 Compile,
                                 CallExpr.NoLValue,
                                 CallExpr.NoLValue,
                                 CallExpr.NotBoolean,
                                 CallExpr.NotBoolean,
                                 Fold,
                                 GetBounds,
                                 CallExpr.IsNever, (* writable *)
                                 CallExpr.IsNever, (* designator *)
                                 CallExpr.NotWritable (* noteWriter *));
    Procedure.Define ("Mod", Z, FALSE, t0);
    formals := ProcType.Formals (t0);
  END Initialize;

BEGIN
END LongMod.
