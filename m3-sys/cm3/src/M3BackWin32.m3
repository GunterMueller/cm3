(* Copyright (C) 1994, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)
(*                                                             *)
(* Last modified on Wed Oct 12 16:12:57 PDT 1994 by kalsow     *)

MODULE M3BackWin32 EXPORTS M3Backend;

IMPORT Wr, Thread;
IMPORT M3CG, Msg, Utils, NTObjFile, M3x86, M3ObjFile;
IMPORT M3CG_BinWr, Builder, Text;

VAR
  obj_file : M3ObjFile.T := NIL;
  obj_wr   : Wr.T        := NIL;
  obj_name : TEXT        := NIL;
  log      : Wr.T        := NIL;
  log_name : TEXT        := NIL;

PROCEDURE
Open (
    BuilderPublicState: Builder.PublicState;
    target: Wr.T; 
    target_name: TEXT
    ): M3CG.T =
  BEGIN
    <*ASSERT obj_file = NIL *>

    (*
        For NT386GNU, use the gcc backend.
        Checking the target name is surely at the wrong
          level of abstraction.
    *)
    IF Text.Equal(BuilderPublicState.target, "NT386GNU") THEN

      (*
        This is what M3Posix.m3 does.
      *)
      RETURN M3CG_BinWr.New (target);
    END;

    obj_file := NTObjFile.New ();
    obj_wr   := target;
    obj_name := target_name;
    IF (Msg.level >= Msg.Level.Verbose) THEN
      log_name := target_name & "log";
      log := Utils.OpenWriter (log_name, fatal := TRUE);
    END;
    RETURN M3x86.New (log, obj_file);
  END Open;

PROCEDURE Close (<*UNUSED*> cg: M3CG.T) =
  BEGIN
    IF obj_file # NIL THEN
      TRY
        NTObjFile.Dump (obj_file, obj_wr);
      EXCEPT Wr.Failure, Thread.Alerted =>
        Msg.FatalError (NIL, "problem writing object file: ", obj_name);
      END;
      Utils.CloseWriter (log, log_name);
      obj_file := NIL;
      obj_wr   := NIL;
      obj_name := NIL;
      log      := NIL;
      log_name := NIL;
    END;
  END Close;

BEGIN
END M3BackWin32.
