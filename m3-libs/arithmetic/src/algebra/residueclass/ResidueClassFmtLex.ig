GENERIC INTERFACE ResidueClassFmtLex(RF, ResC);
(* Arithmetic for Modula-3, see doc for details *)

(* Abstract: Formatting and parsing residue classes *)

(*FROM Arithmetic IMPORT Error;*)
FROM FmtLexSupport IMPORT Precedence;


TYPE T = ResC.T;

TYPE FmtStyle = RECORD elemStyle := RF.FmtStyle{};  END;


PROCEDURE Fmt (READONLY x: T; READONLY style := FmtStyle{}; ): TEXT;
(* outputs as "FRACTION{re:=<r>; im:=<r>}" Uses simple F.Real if x.im=0.0. *)

TYPE
  TexFlag = {ShowDivisor            (* Show the divisor as index *)
            };
  TexFlagSet = SET OF TexFlag;
  TexStyle = RECORD
               flags     := TexFlagSet{};
               elemStyle := RF.TexStyle{};
             END;

PROCEDURE Tex (READONLY x     : T;
               READONLY style       := TexStyle{};
                        within      := Precedence.Sum; ): TEXT;

END ResidueClassFmtLex.
