(* Copyright (C) 1993, Digital Equipment Corporation         *)
(* All rights reserved.                                      *)
(* See the file COPYRIGHT for a full description.            *)
(*                                                           *)
(*  Portions Copyright 1996-2000, Critical Mass, Inc.        *)
(* See file COPYRIGHT-CMASS for details.                     *)
(*                                                           *)
(*| Last modified on Thu May  4 14:02:27 PDT 1995 by kalsow  *)
(*|      modified on Wed Jun  2 15:00:17 PDT 1993 by muller  *)
(*|      modified on Wed Apr 21 13:14:37 PDT 1993 by mcjones *)
(*|      modified on Wed Mar 10 11:01:47 PST 1993 by mjordan *)
(*|      modified on Tue Mar  9 08:45:18 PST 1993 by jdd     *)

UNSAFE MODULE RTAllocator
EXPORTS RTAllocator, RTAllocCnts, RTHooks, RTHeapRep;

IMPORT Cstdlib, RT0, RTHeap, RTMisc, RTOS, RTType, ThreadF;
IMPORT RuntimeError AS RTE, Word;
FROM RTType IMPORT Typecode;

(* In the following procedures, "RTType.Get(tc)" will fail if "tc" is not
   proper. *)

TYPE
  TK = RT0.TypeKind;

(*----------------------------------------------------------- RTAllocator ---*)

PROCEDURE NewTraced(tc: Typecode): REFANY
  RAISES {OutOfMemory} =
  BEGIN
    TRY
      RETURN GetTraced(RTType.Get(tc));
    EXCEPT RTE.E(v) =>
      IF v = RTE.T.OutOfMemory THEN RAISE OutOfMemory;
      ELSE RAISE RTE.E(v);
      END;
    END;
  END NewTraced;

PROCEDURE NewUntraced(tc: Typecode): ADDRESS
  RAISES {OutOfMemory} =
  BEGIN
    TRY
      RETURN GetUntracedRef(RTType.Get(tc));
    EXCEPT RTE.E(v) =>
      IF v = RTE.T.OutOfMemory THEN RAISE OutOfMemory;
      ELSE RAISE RTE.E(v);
      END;
    END;
  END NewUntraced;

PROCEDURE NewUntracedObject(tc: Typecode): UNTRACED ROOT
  RAISES {OutOfMemory} =
  BEGIN
    TRY
      RETURN GetUntracedObj(RTType.Get(tc));
    EXCEPT RTE.E(v) =>
      IF v = RTE.T.OutOfMemory THEN RAISE OutOfMemory;
      ELSE RAISE RTE.E(v);
      END;
    END;
  END NewUntracedObject;

PROCEDURE NewTracedArray(tc: Typecode; READONLY s: Shape): REFANY
  RAISES {OutOfMemory} =
  BEGIN
    TRY
      RETURN GetOpenArray(RTType.Get(tc), s);
    EXCEPT RTE.E(v) =>
      IF v = RTE.T.OutOfMemory THEN RAISE OutOfMemory;
      ELSE RAISE RTE.E(v);
      END;
    END;
  END NewTracedArray;

PROCEDURE NewUntracedArray(tc: Typecode; READONLY s: Shape): ADDRESS
  RAISES {OutOfMemory} =
  BEGIN
    TRY
      RETURN GetUntracedOpenArray(RTType.Get(tc), s);
    EXCEPT RTE.E(v) =>
      IF v = RTE.T.OutOfMemory THEN RAISE OutOfMemory;
      ELSE RAISE RTE.E(v);
      END;
    END;
  END NewUntracedArray;

PROCEDURE Clone (ref: REFANY): REFANY
  RAISES {OutOfMemory} =
  VAR x: REFANY;  defn: RT0.TypeDefn;  tc: INTEGER;
  BEGIN
    IF (ref = NIL) THEN RETURN NIL; END;

    tc := TYPECODE (ref);
    defn := RTType.Get (tc);

    CASE defn.kind OF
    | ORD (RT0.TypeKind.Ref), ORD (RT0.TypeKind.Obj) =>
        x := NewTraced (tc);
    | ORD (RT0.TypeKind.Array) =>
        VAR nDims: INTEGER;  shape: UnsafeArrayShape;  BEGIN
          UnsafeGetShape (ref, nDims, shape);
          x := NewTracedArray (tc, SUBARRAY (shape^, 0, nDims));
        END;
    ELSE
        x := NIL; (* force a crash *)
    END;

    (* finally, copy the data into the new object *)
    RTMisc.Copy (RTHeap.GetDataAdr (ref), RTHeap.GetDataAdr (x),
                 RTHeap.GetDataSize (ref));

    RETURN x;
  END Clone;

(*--------------------------------------------------------------- RTHooks ---*)

PROCEDURE Allocate (defn: ADDRESS): REFANY =
  BEGIN
    RETURN GetTraced(defn);
  END Allocate;

PROCEDURE AllocateUntracedRef (defn: ADDRESS): ADDRESS =
  BEGIN
    RETURN GetUntracedRef(defn);
  END AllocateUntracedRef;

PROCEDURE AllocateUntracedObj (defn: ADDRESS): UNTRACED ROOT =
  BEGIN
    RETURN GetUntracedObj(defn);
  END AllocateUntracedObj;

PROCEDURE AllocateOpenArray (defn: ADDRESS; READONLY s: Shape): REFANY =
  BEGIN
    RETURN GetOpenArray(defn, s);
  END AllocateOpenArray;

PROCEDURE AllocateUntracedOpenArray (defn : ADDRESS;
                            READONLY s    : Shape): ADDRESS =
  BEGIN
    RETURN GetUntracedOpenArray(defn, s);
  END AllocateUntracedOpenArray;

PROCEDURE DisposeUntracedRef (VAR a: ADDRESS) =
  BEGIN
    RTOS.LockHeap();
    IF a # NIL THEN Cstdlib.free(a); a := NIL; END;
    RTOS.UnlockHeap();
  END DisposeUntracedRef;

PROCEDURE DisposeUntracedObj (VAR a: UNTRACED ROOT) =
  VAR def: RT0.TypeDefn;
  BEGIN
    RTOS.LockHeap();
    IF a # NIL THEN
      def := RTType.Get (TYPECODE (a));
      Cstdlib.free (a - MAX(BYTESIZE(Header), def.dataAlignment));
      a := NIL;
    END;
    RTOS.UnlockHeap();
  END DisposeUntracedObj;

(*-------------------------------------------------------------- internal ---*)

PROCEDURE GetTraced (def: RT0.TypeDefn): REFANY =
  BEGIN
    IF (def.kind # ORD(TK.Obj)) THEN
      RETURN GetTracedRef (def);
    ELSE
      RETURN GetTracedObj (def);
    END;
  END GetTraced;

PROCEDURE GetTracedRef (def: RT0.TypeDefn): REFANY =
  VAR
    tc  : Typecode := def.typecode;
    res : ADDRESS;
    pool:= ThreadF.MyAllocPool();
  BEGIN
    IF (tc = 0) OR (def.traced = 0) OR (def.kind # ORD (TK.Ref)) THEN
      <*NOWARN*> EVAL VAL (-1, CARDINAL); (* force a range fault *)
    END;

    pool.busy := TRUE;
    BEGIN
      res := AllocTraced(def, def.dataSize, def.dataAlignment, def.initProc, pool^);
      <*ASSERT pool.busy*>
    END;
    pool.busy := FALSE;

    IF (callback # NIL) THEN callback (LOOPHOLE (res, REFANY)); END;
    RETURN LOOPHOLE(res, REFANY);
  END GetTracedRef;

PROCEDURE GetTracedObj (def: RT0.TypeDefn): REFANY =
  PROCEDURE initProc (res: ADDRESS) =
    BEGIN
      InitObj (res, LOOPHOLE(def, RT0.ObjectTypeDefn));
    END initProc;
  VAR
    tc  : Typecode := def.typecode;
    res : ADDRESS;
    pool:= ThreadF.MyAllocPool();
  BEGIN
    IF (tc = 0) OR (def.traced = 0) OR (def.kind # ORD (TK.Obj)) THEN
      <*NOWARN*> EVAL VAL (-1, CARDINAL); (* force a range fault *)
    END;

    pool.busy := TRUE;
    BEGIN
      res := AllocTraced(def, def.dataSize, def.dataAlignment, initProc, pool^);
      <*ASSERT pool.busy*>
    END;
    pool.busy := FALSE;

    IF (callback # NIL) THEN callback (LOOPHOLE (res, REFANY)); END;
    RETURN LOOPHOLE(res, REFANY);
  END GetTracedObj;

PROCEDURE GetUntracedRef (def: RT0.TypeDefn): ADDRESS =
  VAR
    tc  : Typecode := def.typecode;
    res : ADDRESS;
  BEGIN
    IF (tc = 0) OR (def.traced # 0) OR (def.kind # ORD (TK.Ref)) THEN
      <*NOWARN*> EVAL VAL (-1, CARDINAL); (* force a range fault *)
    END;
    RTOS.LockHeap();
    BEGIN
      res := Cstdlib.malloc(def.dataSize);
      IF (res = NIL) THEN
        RTOS.UnlockHeap();
        RAISE RTE.E(RTE.T.OutOfMemory);
      END;
      BumpCnt (tc);
    END;
    RTOS.UnlockHeap();
    RTMisc.Zero (res, def.dataSize);
    IF def.initProc # NIL THEN def.initProc(res); END;
    RETURN res;
  END GetUntracedRef;

PROCEDURE GetUntracedObj (def: RT0.TypeDefn): UNTRACED ROOT =
  (* NOTE: result requires special treatment by DisposeUntracedObj *)
  VAR
    hdrSize := MAX(BYTESIZE(Header), def.dataAlignment);
    tc      : Typecode := def.typecode;
    res     : ADDRESS;
  BEGIN
    IF (tc = 0) OR (def.traced # 0) OR (def.kind # ORD (TK.Obj)) THEN
      <*NOWARN*> EVAL VAL (-1, CARDINAL); (* force a range fault *)
    END;
    RTOS.LockHeap();
    BEGIN
      res := Cstdlib.malloc(hdrSize + def.dataSize);
      IF (res = NIL) THEN
        RTOS.UnlockHeap();
        RAISE RTE.E(RTE.T.OutOfMemory);
      END;
      res := res + hdrSize;
      BumpCnt (tc);
    END;
    RTOS.UnlockHeap();
    LOOPHOLE(res - ADRSIZE(Header), RefHeader)^ :=
        Header{typecode := def.typecode};
    InitObj (res, LOOPHOLE(def, RT0.ObjectTypeDefn));
    RETURN res;
  END GetUntracedObj;

PROCEDURE InitObj (res: ADDRESS;  def: RT0.ObjectTypeDefn) =
  BEGIN
    LOOPHOLE(res, UNTRACED REF ADDRESS)^ := def.defaultMethods;
    WHILE def # NIL DO
      IF def.common.initProc # NIL THEN def.common.initProc(res); END;
      IF def.common.kind # ORD (TK.Obj) THEN EXIT; END;
      def := LOOPHOLE (def.parent, RT0.ObjectTypeDefn);
    END;
  END InitObj;

PROCEDURE GetOpenArray (def: RT0.TypeDefn; READONLY s: Shape): REFANY =
  PROCEDURE initProc (res: ADDRESS) =
    BEGIN
      InitArray (res, LOOPHOLE(def, RT0.ArrayTypeDefn), s);
    END initProc;
  VAR
    tc    : Typecode := def.typecode;
    res   : ADDRESS;
    pool := ThreadF.MyAllocPool();
  BEGIN
    IF (tc = 0) OR (def.traced = 0) OR (def.kind # ORD(TK.Array)) THEN
      <*NOWARN*> EVAL VAL (-1, CARDINAL); (* force a range fault *)
    END;

    pool.busy := TRUE;
    WITH nBytes = ArraySize(LOOPHOLE(def, RT0.ArrayTypeDefn), s) DO
      res := AllocTraced(def, nBytes, def.dataAlignment, initProc, pool^);
      <*ASSERT pool.busy*>
    END;
    pool.busy := FALSE;

    IF (callback # NIL) THEN callback (LOOPHOLE (res, REFANY)); END;
    RETURN LOOPHOLE(res, REFANY);
  END GetOpenArray;

PROCEDURE GetUntracedOpenArray (def: RT0.TypeDefn; READONLY s: Shape): ADDRESS =
  VAR
    tc  : Typecode := def.typecode;
    res : ADDRESS;
  BEGIN
    IF (tc = 0) OR (def.traced # 0) OR (def.kind # ORD(TK.Array)) THEN
      <*NOWARN*> EVAL VAL (-1, CARDINAL); (* force a range fault *)
    END;

    RTOS.LockHeap();
    WITH nBytes = ArraySize(LOOPHOLE(def, RT0.ArrayTypeDefn), s) DO
      res := Cstdlib.malloc(nBytes);
      IF (res = NIL) THEN
        RTOS.UnlockHeap();
        RAISE RTE.E(RTE.T.OutOfMemory);
      END;
      RTMisc.Zero (res, nBytes);
      BumpSize (def.typecode, nBytes);
    END;
    RTOS.UnlockHeap();

    InitArray (res, LOOPHOLE(def, RT0.ArrayTypeDefn), s);
    RETURN res;
  END GetUntracedOpenArray;

PROCEDURE InitArray (res: ADDRESS; def: RT0.ArrayTypeDefn; READONLY s: Shape) =
  BEGIN
    WITH data_start = res + def.common.dataSize DO
      LOOPHOLE(res, UNTRACED REF ADDRESS)^ := data_start;
    END;
    FOR i := 0 TO NUMBER(s) - 1 DO
      LOOPHOLE(res + ADRSIZE(ADDRESS) + i * ADRSIZE(INTEGER),
               UNTRACED REF INTEGER)^ := s[i];
    END;
    IF def.common.initProc # NIL THEN def.common.initProc(res) END;
  END InitArray;

PROCEDURE ArraySize (def: RT0.ArrayTypeDefn;  READONLY s: Shape): CARDINAL =
  VAR n_elts := 1;  c: CARDINAL;
  BEGIN
    FOR i := 0 TO NUMBER(s) - 1 DO
      c := s[i];  (* force a range check *)
      n_elts := c * n_elts;
    END;
    RETURN RTMisc.Upper(def.common.dataSize + def.elementSize * n_elts,
                        BYTESIZE(Header));
  END ArraySize;

(*---------------------------------------------------------- RTAllocCnts ---*)

PROCEDURE BumpCnt (tc: RT0.Typecode) =
  BEGIN
    IF (tc >= n_types) THEN ExpandCnts (tc); END;
    WITH z = n_objects[tc] DO z := Word.Plus (z, 1) END;
  END BumpCnt;

PROCEDURE BumpSize (tc: RT0.Typecode;  size: INTEGER) =
  BEGIN
    IF (tc >= n_types) THEN ExpandCnts (tc); END;
    WITH z = n_objects[tc] DO z := Word.Plus (z, 1)    END;
    WITH z = n_bytes[tc]   DO z := Word.Plus (z, size) END;
  END BumpSize;

PROCEDURE ExpandCnts (tc: RT0.Typecode) =
  VAR
    goal      := MAX (tc, RTType.MaxTypecode ());
    new_cnt   : INTEGER := 512;
    new_mem   : INTEGER;
    new_cnts  : ADDRESS;
    new_sizes : ADDRESS;
    old_cnts  := n_objects;
    old_sizes := n_bytes;
  BEGIN
    IF (n_types > 0) THEN new_cnt := n_types; END;
    WHILE (new_cnt <= goal) DO INC (new_cnt, new_cnt); END;

    new_mem   := new_cnt * BYTESIZE (INTEGER);
    new_cnts  := Malloc (new_mem);
    new_sizes := Malloc (new_mem);

    IF (old_cnts # NIL) THEN
      RTMisc.Copy (old_cnts,  new_cnts,  n_types * BYTESIZE (INTEGER)); 
      RTMisc.Copy (old_sizes, new_sizes, n_types * BYTESIZE (INTEGER));
    END;

    n_objects := new_cnts;
    n_bytes   := new_sizes;
    n_types   := new_cnt;
    (* "n_types" is assigned last in case anyone is reading the arrays
       while we're updating them... *)

    IF (old_cnts # NIL) THEN
      Cstdlib.free (old_cnts);
      Cstdlib.free (old_sizes);
    END;
  END ExpandCnts;
    
PROCEDURE Malloc (size: INTEGER): ADDRESS =
  VAR res := Cstdlib.malloc (size);
  BEGIN
    IF (res = NIL) THEN RAISE RTE.E (RTE.T.OutOfMemory); END;
    RTMisc.Zero (res, size);
    RETURN res;
  END Malloc;

BEGIN
END RTAllocator.
