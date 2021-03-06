(* Copyright (C) 1993 Digital Equipment Corporation.                   *)
(* All rights reserved. See the file COPYRIGHT for a full description. *)

(* Last modified on Wed Oct 27 14:28:44 1993 by luca *)

MODULE Main;
IMPORT ObliqOnline, IO;

(* ========= Add or remove imports here ========= *)
IMPORT ObLibM3, ObLibM3Help; (* rd,wr,lex,fmt,pickle,process,thread *)
(* ============================================== *)

  CONST Greetings = 
    "  Obliq* (with standard libraries) (say \'help;\' for help)";

  PROCEDURE RegisterLibraries() =
  BEGIN
(* ========= Add or remove libraries here ========= *)
    IO.Put("[Obliq* Runtime Initializing] [Basic libraries]\r");
    ObLibM3.PackageSetup();    ObLibM3Help.Setup();
(* ================================================ *)
  END RegisterLibraries;

BEGIN
  IO.Put("[Obliq* Runtime Initializing]\r");
  ObliqOnline.Setup();
  RegisterLibraries();
  IO.Put("                                                    \r");
  ObliqOnline.Interact(ObliqOnline.New(Greetings));
END Main.

