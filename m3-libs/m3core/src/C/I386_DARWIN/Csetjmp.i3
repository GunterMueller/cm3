(* Copyright (C) 1990, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)
(*                                                             *)
(* Last modified on Tue Oct 18 08:40:23 PDT 1994 by kalsow     *)
(*      modified on Fri Apr 30 16:25:40 PDT 1993 by muller     *)
(*      Olaf Wagner 12.09.1994                                 *)

INTERFACE Csetjmp;		(* for I386_DARWIN *)

FROM Ctypes IMPORT int;

CONST
  JBLEN = 18;

TYPE 
  sigjmp_buf = ARRAY [0..JBLEN] OF int;
  jmp_buf = sigjmp_buf;			 (* just in case *)

<*EXTERNAL*> PROCEDURE setjmp (VAR env: jmp_buf): int;
<*EXTERNAL*> PROCEDURE longjmp (VAR env: jmp_buf; val: int);

<*EXTERNAL "_setjmp" *>  PROCEDURE usetjmp (VAR env: jmp_buf): int;
<*EXTERNAL "_longjmp" *> PROCEDURE ulongjmp (VAR env: jmp_buf; val: int);

<*EXTERNAL "sigsetjmp" *> PROCEDURE sigsetjmp (VAR env: sigjmp_buf): int;
<*EXTERNAL "siglongjmp"*> PROCEDURE siglongjmp (VAR env: sigjmp_buf; val: int);

END Csetjmp.
