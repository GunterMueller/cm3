(* Copyright (C) 1994, Digital Equipment Corporation.         *)
(* All rights reserved.                                       *)
(* See the file COPYRIGHT for a full description.             *)

(* $Id: Usched.i3,v 1.1 2008-01-28 15:37:01 jkrell Exp $ *)

INTERFACE Usched;

FROM Ctypes IMPORT int;

(*** <sched.h> ***)

(* Yield the processor.  *)
<*EXTERNAL sched_yield*>
PROCEDURE yield (): int;

(* Get maximum priority value for a scheduler.  *)
<*EXTERNAL sched_get_priority_max*>
PROCEDURE get_priority_max (policy: int): int;

(* Get minimum priority value for a scheduler.  *)
<*EXTERNAL sched_get_priority_min*>
PROCEDURE get_priority_min (policy: int): int;

END Usched.
