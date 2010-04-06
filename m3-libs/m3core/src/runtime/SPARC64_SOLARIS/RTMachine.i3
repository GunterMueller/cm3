(* Copyright (C) 1994, Digital Equipment Corporation.       *)
(* All rights reserved.                                     *)
(* See the file COPYRIGHT for a full description.           *)
(*                                                          *)
(* Last modified on Wed Jul 30 13:55:56 EST 1997 by hosking *)
(*      modified on Tue May  2 11:43:35 PDT 1995 by kalsow  *)

(* This interface defines platform (machine + OS) dependent
   types and constants. *)

INTERFACE RTMachine;

(*------------------------------------------------------------------ heap ---*)

(* The heap page size used to be machine-dependent, since it could depend
   on the architecture's VM page size (if VM was TRUE). VM is now always
   FALSE. Otherwise, 8192 bytes is a reasonable page size. The page size must
   be a power of two. *)

CONST
  BytesPerHeapPage    = 8192;               (* bytes per page *)
  LogBytesPerHeapPage = 13;

(*----------------------------------------------- exception stack walking ---*)
(* The "FrameInfo" type must minimally include fields named "pc" and "sp". *)

CONST
  Has_stack_walker = FALSE;
  (* Indicates whether this platform supports the stack walking functions
     defined in the "RTStack" interface. *)

(* The "FrameInfo" type must minimally include fields named "pc" and "sp". *)
TYPE
  FrameInfo = RECORD
    pc, sp  : ADDRESS;       (* sp here is actually SPARC fp *)
    true_sp : ADDRESS;
    context : ADDRESS;
    lock    : INTEGER;       (* to ensure that ctxt isn't overrun!! *)
  END;

END RTMachine.
