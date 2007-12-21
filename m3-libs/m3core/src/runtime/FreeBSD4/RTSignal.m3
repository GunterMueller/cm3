(* Copyright (C) 1992, Digital Equipment Corporation          *)
(* All rights reserved.                                       *)
(* See the file COPYRIGHT for a full description.             *)
(*                                                            *)
(* Last modified on Mon Nov 21 10:31:19 PST 1994 by kalsow    *)
(*      modified on Mon Mar 16 18:10:15 PST 1992 by muller    *)

UNSAFE MODULE RTSignal;

IMPORT RTError, (* RTMisc, *) RTProcess, Usignal, Uprocess, Uucontext;
FROM Ctypes IMPORT int;

VAR
  DefaultHandler   : Usignal.SignalActionHandler;
  IgnoreSignal     : Usignal.SignalActionHandler;
  initial_handlers : ARRAY [0..5] OF Usignal.struct_sigaction;

PROCEDURE InstallHandlers () =
  BEGIN
    DefaultHandler := LOOPHOLE (0, Usignal.SignalActionHandler);
    IgnoreSignal   := LOOPHOLE (1, Usignal.SignalActionHandler);

    SetHandler (0, Usignal.SIGHUP,  Shutdown);
    SetHandler (1, Usignal.SIGINT,  Interrupt);
    SetHandler (2, Usignal.SIGQUIT, Quit);
    SetHandler (3, Usignal.SIGSEGV, SegV);
    SetHandler (4, Usignal.SIGPIPE, IgnoreSignal);
    SetHandler (5, Usignal.SIGTERM, Shutdown);
  END InstallHandlers;

PROCEDURE SetHandler (id: INTEGER; sig: int; 
                      handler: Usignal.SignalActionHandler) =
  (* Note: we use the LOOPHOLE to prevent the runtime check for
     nested procedure.  The runtime check crashes when
     handler = IgnoreSignal = 1. *)
  VAR new: Usignal.struct_sigaction;
  BEGIN
    new.sa_sigaction := LOOPHOLE (handler, Usignal.SignalActionHandler);
    new.sa_flags   := 0;
    EVAL Usignal.sigaction (sig, new, initial_handlers[id]);
    IF (initial_handlers[id].sa_sigaction # DefaultHandler) THEN
      (* don't override inherited, non-default handlers *)
      EVAL Usignal.sigaction (sig, initial_handlers[id], new);
    END;
  END SetHandler;

PROCEDURE RestoreHandlers () =
  BEGIN
    RestoreHandler (0, Usignal.SIGHUP);
    RestoreHandler (1, Usignal.SIGINT);
    RestoreHandler (2, Usignal.SIGQUIT);
    RestoreHandler (3, Usignal.SIGSEGV);
    RestoreHandler (4, Usignal.SIGPIPE);
    RestoreHandler (5, Usignal.SIGTERM);
  END RestoreHandlers;

PROCEDURE RestoreHandler (id: INTEGER;  sig: int) =
  VAR dummy: Usignal.struct_sigaction;
  BEGIN
    EVAL Usignal.sigaction (sig, initial_handlers[id], dummy);
  END RestoreHandler;

PROCEDURE Shutdown (sig: int;
         <*UNUSED*> sip: Usignal.siginfo_t_star;
         <*UNUSED*> uap: Uucontext.ucontext_t_star) =
  VAR new, old: Usignal.struct_sigaction;
  BEGIN
    new.sa_sigaction := DefaultHandler;
    new.sa_flags := 0;
    EVAL Usignal.sigemptyset(new.sa_mask);
    RTProcess.InvokeExitors ();                   (* flush stdio... *)
    (* restore default handler *)
    EVAL Usignal.sigaction (sig, new, old);
    EVAL Usignal.kill (Uprocess.getpid (), sig);  (* and resend the signal *)
  END Shutdown;

PROCEDURE Interrupt (sig: int;
                     sip: Usignal.siginfo_t_star;
                     uap: Uucontext.ucontext_t_star) =
  VAR h := RTProcess.OnInterrupt (NIL);
  BEGIN
    IF (h = NIL) THEN
      Shutdown (sig, sip, uap);
    ELSE
      EVAL RTProcess.OnInterrupt (h); (* reinstall the handler *)
      h ();
    END;
  END Interrupt;

PROCEDURE Quit (<*UNUSED*> sig: int;
                <*UNUSED*> sip: Usignal.siginfo_t_star;
                           uap: Uucontext.ucontext_t_star) =
  VAR pc := 0;
  BEGIN
    IF (uap # NIL) THEN pc := uap.uc_mcontext.mc_eip; END;
    RTError.MsgPC (pc, "aborted");
  END Quit;

PROCEDURE SegV (<*UNUSED*> sig: int;
                <*UNUSED*> sip: Usignal.siginfo_t_star;
                           uap: Uucontext.ucontext_t_star) =
  VAR pc := 0;
  BEGIN
    IF (uap # NIL) THEN pc := uap.uc_mcontext.mc_eip; END;
    RTError.MsgPC (pc,
      "Segmentation violation - possible attempt to dereference NIL");
  END SegV;

(*
PROCEDURE Shutdown (sig: int; <*UNUSED*> code: int; <*UNUSED*> scp: SigInfo) =
  VAR new, old: Usignal.struct_sigaction;
  BEGIN
    new.sa_sigaction := DefaultHandler;
    new.sa_flags   := 0;
    RTProcess.InvokeExitors ();                   (* flush stdio... *)
    EVAL Usignal.sigaction (sig, ADR(new), ADR(old));       (* restore default handler *)
    EVAL Usignal.kill (Uprocess.getpid (), sig);  (* and resend the signal *)
  END Shutdown;

PROCEDURE Interrupt (sig: int;  code: int;  scp: SigInfo) =
  VAR h := RTProcess.OnInterrupt (NIL);
  BEGIN
    IF (h = NIL) THEN
      Shutdown (sig, code, scp);
    ELSE
      EVAL RTProcess.OnInterrupt (h); (* reinstall the handler *)
      h ();
    END;
  END Interrupt;

PROCEDURE Quit (<*UNUSED*> sig, code: int; scp: SigInfo) =
  VAR pc := 0;
  BEGIN
    IF (scp # NIL) THEN pc := scp.sc_eip END;
    RTError.Msg (NIL, 0, "aborted");
    (* RTMisc.FatalErrorPC (pc, "aborted"); *)
  END Quit;

PROCEDURE SegV (<*UNUSED*> sig, code: int; scp: SigInfo) =
  VAR pc := 0;
  BEGIN
    IF (scp # NIL) THEN pc := scp.sc_eip END;
    RTError.Msg (NIL, 0,
      "Segmentation violation - possible attempt to dereference NIL");
    (* RTMisc.FatalErrorPC (pc,
      "Segmentation violation - possible attempt to dereference NIL"); *)
  END SegV;
*)

BEGIN
END RTSignal.
