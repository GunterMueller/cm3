(* Copyright (c) 2000 California Institute of Technology *)
(* All rights reserved. See the file COPYRIGHT for a full description. *)
(* $Id$ *)

INTERFACE PaneManOp;
IMPORT StarterScan;
(* Using a PaneManOp.T, a pane can enqueue requests to the pane manager,
   without worrying about whether pm.mu is locked. *)
TYPE
  T = OBJECT METHODS
    startPane(s: StarterScan.T);
    print(message: TEXT);
    input(prompt, default: TEXT; result: InputCallback);
  END;
  InputCallback = OBJECT METHODS
    accept(result: TEXT); 
    complete(VAR t: TEXT);
  END;
END PaneManOp.

