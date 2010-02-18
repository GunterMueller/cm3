(* Copyright (C) 1993, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)
(*                                                             *)
(* Last modified on Wed Mar 22 08:05:39 PST 1995 by kalsow     *)
(*      modified on Fri Nov 25 11:34:48 PST 1994 by isard      *)
(*      modified on Mon Apr 13 09:55:12 PDT 1992 by muller     *)

INTERFACE Stackx86;

FROM M3CG IMPORT Type, MType, ZType, IType, Sign, ByteOffset;
FROM M3CG_Ops IMPORT ErrorHandler;

IMPORT M3x86Rep, Codex86, Wrx86, M3BackInt AS Target;
FROM M3x86Rep IMPORT Operand, OLoc, MVar, Regno, Force, RegSet, FlToInt;
FROM M3x86Rep IMPORT x86Proc, x86Var, OperandPart;

FROM Codex86 IMPORT Op;

TYPE T <: Public;
TYPE Public = OBJECT
      METHODS
        unlock ();
        clearall ();
        releaseall ();
        all_to_mem ();
        lock (r: Regno);
        find (stackp: INTEGER; force: Force; set := RegSet {};
              hintaddr := FALSE);
        freereg (set := RegSet {}; operandPart: OperandPart): Regno;
        set_reg (stackp: INTEGER; r: Regno; operandPart: OperandPart);
        set_type (stackp: INTEGER; type: Type);
        dealloc_reg (stackp: INTEGER; operandPart: OperandPart);
        corrupt (reg: Regno; operandPart: OperandPart);
        set_fstack (stackp: INTEGER);
        set_mvar (stackp: INTEGER; READONLY mvar: MVar);
        set_imm (stackp: INTEGER; READONLY imm: Target.Int);
        loc (stackp: INTEGER): OLoc;
        op (stackp: INTEGER): Operand;
        pos (depth: INTEGER; place: TEXT): INTEGER;
        discard (depth: INTEGER);
        set_error_handler (err: ErrorHandler);
        push (READONLY mvar: MVar);
        pushnew (type: MType; force: Force; set := RegSet {});
        pushimmI (imm: INTEGER; type: Type);
        pushimmT (imm: Target.Int; type: Type);
        pop (READONLY mvar: MVar);
        doloadaddress (v: x86Var; o: ByteOffset);
        dobin (op: Op; symmetric, overwritesdest: BOOLEAN; type: Type): BOOLEAN;
        dostoreind (o: ByteOffset; type: MType);
        doumul ();
        doimul ();
        dodiv (a, b: Sign);
        domod (a, b: Sign);
        doneg ();
        doabs ();
        domaxmin (type: ZType; maxmin: MaxMin);
        fltoint (mode: FlToInt; type: Type);
        inttoflt ();
        doshift (type: IType): BOOLEAN;
        dorotate (type: IType): BOOLEAN;
        doextract (type: IType; sign: BOOLEAN): BOOLEAN;
        doextract_n (type: IType; sign: BOOLEAN; n: INTEGER): BOOLEAN;
        doextract_mn (type: IType; sign: BOOLEAN; m, n: INTEGER): BOOLEAN;
        doinsert (type: IType): BOOLEAN;
        doinsert_n (type: IType; n: INTEGER): BOOLEAN;
        doinsert_mn (type: IType; m, n: INTEGER): BOOLEAN;
        swap ();
        doloophole (from, to: ZType);
        doindex_address (shift, size: INTEGER; neg: BOOLEAN);
        docopy (type: MType; overlap: BOOLEAN);
        docopy_n (n: INTEGER; type: MType; overlap: BOOLEAN);
        doimm (op: Op; READONLY imm: Target.Int; overwritesdest: BOOLEAN);
        newdest (READONLY op: Operand);
        init ();
        end ();
        set_current_proc (p: x86Proc);
        reg (stackp: INTEGER): Regno;
        lower (reg: Regno): Target.Int;
        set_lower (reg: Regno; low: Target.Int);
        upper (reg: Regno): Target.Int;
        set_upper (reg: Regno; up: Target.Int);
        non_nil (reg: Regno): BOOLEAN;
        set_non_nil (reg: Regno);
      END;

TYPE MaxMin = { Max, Min };

PROCEDURE New (parent: M3x86Rep.U; cg: Codex86.T; debug: BOOLEAN): T;

PROCEDURE Debug (t: T;  tag: TEXT;  wr: Wrx86.T);

END Stackx86.
