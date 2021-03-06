(* Copyright (c) 2000 California Institute of Technology *)
(* All rights reserved. See the file COPYRIGHT for a full description. *)
(* $Id: RealPoint.i3,v 1.2 2001-09-19 15:30:31 wagner Exp $ *)

INTERFACE RealPoint;
IMPORT Point;

TYPE
  T = RECORD
    h, v: REAL;
  END;

PROCEDURE FromPoint(p: Point.T): T;
PROCEDURE Round(p: T): Point.T;

END RealPoint.
