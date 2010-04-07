(* Copyright (C) 2005, Purdue Research Foundation                  *)
(* All rights reserved.                                            *)
(* See the file COPYRIGHT-PURDUE for a full description.           *)
(*                                                                 *)
(* Copyright (C) 1994, Digital Equipment Corporation               *)
(* All rights reserved.                                            *)
(* See the file COPYRIGHT for a full description.                  *)

UNSAFE INTERFACE RTThread;

IMPORT FloatMode, RTHeapRep;

(*--------------------------------------------- garbage collector support ---*)

PROCEDURE MyHeapState(): UNTRACED REF RTHeapRep.ThreadState;

PROCEDURE SuspendOthers ();
(* Suspend all threads except the caller's.  NOTE: Once the other threads
   are suspended, the remaining thread cannot use any of the synchronization
   operations (Signal, Wait, Broadcast, Pause).  Otherwise, it may deadlock
   with one of the suspended threads (by trying to acquire the internal
   lock "cm"). *)

PROCEDURE ResumeOthers ();
(* Resume the threads suspended by "SuspendOthers" *)

(* We assume that the compiler ensures pointers are stored at aligned
   locations in the stacks.  The garbage collector scans thread stacks, but
   only looks at these possible pointer locations. *)
CONST PointerAlignment = BYTESIZE(ADDRESS);

PROCEDURE ProcessStacks (p: PROCEDURE (start, limit: ADDRESS));
(* Apply p to each thread stack, with [start..limit) being the limits
   of the stack.  All other threads must be suspended.  ProcessStacks
   exists solely for the garbage collector.  *)
(* Feature:  Windows threads not created by Thread.Fork are not suspended
   or resumed, and their stacks are not processed. *)

PROCEDURE ProcessEachStack (p: PROCEDURE (start, limit: ADDRESS));
(* Apply p to each thread stack, with [start..limit) being the limits
   of the stack.  Each thread is suspended individually.  ProcessEachStack
   exists solely for the garbage collector.  *)

(*------------------------------------------------ floating point support ---*)

(* access to the saved floating point state for the current thread. *)

PROCEDURE MyFPState (): UNTRACED REF FloatMode.ThreadState;

(*---------------------------------------------------- exception delivery ---*)

PROCEDURE GetCurrentHandlers(): ADDRESS;
(* == RETURN WinBase.TlsGetValue(handlersIndex) *)

PROCEDURE SetCurrentHandlers(h: ADDRESS);
(* == WinBase.TlsSetValue(handlersIndex, h) *)

(*---------------------------------------------------------------------------*)

PROCEDURE Init();

END RTThread.
