(* Copyright (C) 1989, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)

(* Last modified on Tue Jun 15 10:06:38 1993 by gnelson        *)
(*      modified on Thu May 27 17:20:56 PDT 1993 by swart      *)
(*      modified on Fri Feb  7 00:03:04 PST 1992 by muller     *)
(*      modified on Tue Jan 28 12:45:57 PST 1992 by kalsow     *)



(* The UnsafeRd interface is similar to Rd, but GetChar, GetSub and
Eof are the only operations that are sufficiently performance-critical
to be included.

Note that if you import this interface along with RdClass that you must
include the following line:

   REVEAL RdClass.Private <: MUTEX

in order to satisfy the constraint that the revealed supertypes of an
opaque type be totally ordered.  *)

INTERFACE UnsafeRd;
IMPORT Rd; 
IMPORT Thread; 
FROM Thread IMPORT Alerted;
FROM Rd IMPORT Failure, EndOfFile;

REVEAL
  Rd.T <: Thread.Mutex;

PROCEDURE FastGetChar(rd: Rd.T): CHAR RAISES {EndOfFile, Failure, Alerted};
(* Like Rd.GetChar, but rd must be locked. *)

PROCEDURE FastGetWideChar(rd: Rd.T): WIDECHAR RAISES {EndOfFile, Failure, Alerted};
(* Like Rd.GetWideChar, but rd must be locked. *)

PROCEDURE FastGetSub(rd: Rd.T; VAR (*OUT*) str: ARRAY OF CHAR): CARDINAL
    RAISES {Failure, Alerted};
(* Like Rd.GetSub, but rd must be locked. *)

PROCEDURE FastGetWideSub(rd: Rd.T; VAR (*OUT*) str: ARRAY OF WIDECHAR): CARDINAL
    RAISES {Failure, Alerted};
(* Like Rd.GetWideSub, but rd must be locked. *)

PROCEDURE FastEOF(rd: Rd.T): BOOLEAN RAISES {Failure, Alerted};
(* Like Rd.EOF, but rd must be locked. *)

PROCEDURE FastUnGetChar(rd: Rd.T) RAISES {};
(* Like Rd.UnGetChar, but rd must be locked. *)

PROCEDURE FastUnGetCharMulti(rd: Rd.T; n: Rd.UnGetCount:= 1)
  : CARDINAL (* Number actually ungotten.*);
(* Like Rd.UnGetCharMulti, but rd must be locked. *)

PROCEDURE FastCharsReady(rd: Rd.T): CARDINAL RAISES {Failure}; 
(* Like Rd.CharsReady, but rd must be locked. *)

PROCEDURE FastIndex(rd: Rd.T): CARDINAL; 
(* Like Rd.Index, but rd must be locked. *)

PROCEDURE FastLength(rd: Rd.T): INTEGER RAISES {Failure, Alerted};
(* Like Rd.Length, but rd must be locked. *)

PROCEDURE FastIntermittent(rd: Rd.T): BOOLEAN RAISES {};
(* Like Rd.Intermittent, but rd must be locked. *)

PROCEDURE FastSeekable(rd: Rd.T): BOOLEAN RAISES {};
(* Like Rd.Seekabke, but rd must be locked. *)

PROCEDURE FastClosed(rd: Rd.T): BOOLEAN RAISES {};
(* Like Rd.Closed, but rd must be locked. *)

PROCEDURE FastClose(rd: Rd.T) RAISES {Failure, Alerted};
(* Like Rd.Close, but rd must be locked. *)

END UnsafeRd.

