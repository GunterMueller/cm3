INTERFACE Range;
(* Arithmetic for Modula-3, see doc for details

   Abstract: Range of integers similar to the built-in subrange type of
   Modula-3.  In contrast to a Modula-3 subrange a Range.T may be
   initialised with numbers at run-time. *)


CONST Brand = "Range";


TYPE
  T = RECORD
        first : INTEGER;
        number: CARDINAL;
      END;

<* INLINE *>
PROCEDURE New (first: INTEGER; number: CARDINAL; ): T;

<* INLINE *>
PROCEDURE First (x: T; ): INTEGER;

<* INLINE *>
PROCEDURE Last (x: T; ): INTEGER;

<* INLINE *>
PROCEDURE Number (x: T; ): CARDINAL;

END Range.
