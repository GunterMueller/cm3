(* Copyright (C) 1994, Digital Equipment Corporation                         *)
(* Digital Internal Use Only                                                 *)
(* All rights reserved.                                                      *)
(*                                                                           *)
(* Last modified on Tue Jul 26 15:34:27 PDT 1994 by najork                   *)
(*       Created on Sun May 22 11:14:17 PDT 1994 by najork                   *)


INTERFACE MarkerTypeProp;

IMPORT AnimHandle, Prop;

TYPE
  Kind = {Dot, Cross, Asterisk, Circle, X};
(* "Kind" enumerates the five possible ways a marker can be drawn: as a dot,
   a cross, an asterisk, a circle, or an X. These are the five marker types
   that are supported by PEX. OpenGL does not have a marker concept. However,
   we could build them up from lines and dots (however, this would not be a
   perfect approximation, as PEX markers always orient themselves towards
   the camera). *)

TYPE
  Name <: PublicName;
  PublicName = Prop.Name OBJECT
  METHODS
    bind (v : Val) : Prop.T;
  END;

  Val <: PublicVal;
  PublicVal = Prop.Val OBJECT
    beh : Beh;
  METHODS
    init (beh : Beh) : Val;
    get () : Kind RAISES {Prop.BadMethod};
    value (time : LONGREAL) : Kind RAISES {Prop.BadMethod};
  END;

  Beh <: PublicBeh;
  PublicBeh = Prop.Beh OBJECT
  METHODS
    init () : Beh;
  END;

  ConstBeh <: PublicConstBeh;
  PublicConstBeh = Beh OBJECT
  METHODS
    init (p : Kind) : ConstBeh;
    set (p : Kind);
  END;

  SyncBeh <: PublicSyncBeh;
  PublicSyncBeh = Beh OBJECT
  METHODS
    init (ah : AnimHandle.T; p : Kind) : SyncBeh;
    addRequest (r : Request) RAISES {Prop.BadInterval};
  (* shortcuts for particular instances of "addRequest" *)
    change (p : Kind; start := 0.0) RAISES {Prop.BadInterval};
  END;

  AsyncBeh <: PublicAsyncBeh;
  PublicAsyncBeh = Beh OBJECT
  METHODS
    init () : AsyncBeh;
    compute (time : LONGREAL) : Kind RAISES {Prop.BadMethod};
  END;

  DepBeh <: PublicDepBeh;
  PublicDepBeh = Beh OBJECT
  METHODS
    init () : DepBeh;
    compute (time : LONGREAL) : Kind RAISES {Prop.BadMethod};
  END;

  Request <: PublicRequest;
  PublicRequest = Prop.Request OBJECT
  METHODS
    init (start, dur : REAL) : Request;
    value (startkind : Kind; reltime : REAL) : Kind RAISES {Prop.BadMethod};
  END;

PROCEDURE NewConst (p : Kind) : Val;
PROCEDURE NewSync (ah : AnimHandle.T; p : Kind) : Val;
PROCEDURE NewAsync (b : AsyncBeh) : Val;
PROCEDURE NewDep (b : DepBeh) : Val;

END MarkerTypeProp.
