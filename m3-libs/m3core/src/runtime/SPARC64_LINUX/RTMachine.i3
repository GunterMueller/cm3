(* Copyright (C) 1994, Digital Equipment Corporation.       *)
(* All rights reserved.                                     *)
(* See the file COPYRIGHT for a full description.           *)
(*                                                          *)
(* Last modified on Tue May  2 11:42:57 PDT 1995 by kalsow  *)

(* This interface defines platform (machine + OS) dependent
   types and constants. *)

INTERFACE RTMachine;

IMPORT Csetjmp;
IMPORT Usignal;
FROM Upthread IMPORT pthread_t;

(*--------------------------------------------------------- thread state ---*)

(* TBD: remove userthread and gcvm support, which includes much
of the below *)

TYPE
  State = Csetjmp.jmp_buf;
  (* The machine state is saved in a "State".  This is opaque to the client. *)

<*EXTERNAL "_setjmp" *>
PROCEDURE SaveState (VAR s: State): INTEGER;
(* Capture the currently running thread's state *)

CONST
  FramePadBottom = 2;
  FramePadTop    = 0;
  (* Additional padding words from above and below an existing
     thread's stack pointer to copy when creating a new thread *)

(*------------------------------------------------------------------ heap ---*)

(* The heap page size is machine-dependent, since it might depend on the
   architecture's VM page size (if VM is TRUE).  Otherwise, 8192 bytes is a
   reasonable page size.  The page size must be a power of two. *)

  BytesPerHeapPage    = 8192;        (* bytes per page *)
  LogBytesPerHeapPage = 13;
  AdrPerHeapPage      = 8192;        (* addresses per page *)
  LogAdrPerHeapPage   = 13;

(*--------------------------------------------------------- thread stacks ---*)

  PointerAlignment = BYTESIZE(INTEGER);
  (* The C compiler allocates all pointers on 'PointerAlignment'-byte
     boundaries.  The garbage collector scans thread stacks, but only
     looks at these possible pointer locations.  Setting this value
     smaller than is needed will only make your system run slower.
     Setting it too large will cause the collector to collect storage
     that is not free. *)

(*----------------------------------------------- exception stack walking ---*)
(* The "FrameInfo" type must minimally include fields named "pc" and "sp". *)

  Has_stack_walker = FALSE;
  (* Indicates whether this platform supports the stack walking functions
     defined in the "RTStack" interface. *)

TYPE FrameInfo = RECORD pc, sp: ADDRESS END;

CONST
  SIG_SUSPEND = Usignal.NSIG-1; (* SIGRTMAX *)
  SuspendThread: PROCEDURE(t: pthread_t): BOOLEAN = NIL;
  RestartThread: PROCEDURE(t: pthread_t) = NIL;
  GetState: PROCEDURE(t: pthread_t; VAR state: ThreadState): ADDRESS = NIL;
  SaveRegsInStack: PROCEDURE(): ADDRESS = NIL;

TYPE ThreadState = RECORD END;

END RTMachine.
