(* Copyright (C) 1993, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)
(*                                                             *)
(* File: TWord.m3                                              *)
(* Last Modified On Fri Nov 19 09:32:56 PST 1993 By kalsow     *)
(*      Modified On Thu May 20 08:46:32 PDT 1993 By muller     *)

MODULE TWord;

IMPORT Word, TInt;
FROM Target IMPORT Int, IByte, IBytes;

CONST (* IMPORTS *)
  RShift = Word.RightShift;
  LShift = Word.LeftShift;

CONST
  Mask = RShift (Word.Not (0), Word.Size - BITSIZE (IByte));
  Base = Mask + 1;

(*------------------------------------------- unsigned integer operations ---*)

PROCEDURE New (READONLY x: ARRAY OF CHAR; base: [2..16];  n: CARDINAL;
               VAR r: Int): BOOLEAN =
  VAR rr: IBytes;  digit: INTEGER;  ch: CHAR;
  BEGIN
    <*ASSERT n # 0*>
    r := Int{n};
    FOR i := FIRST (x) TO LAST (x) DO
      ch := x [i];
      IF    ('0' <= ch) AND (ch <= '9') THEN  digit := ORD (ch) - ORD ('0');
      ELSIF ('A' <= ch) AND (ch <= 'F') THEN  digit := ORD (ch) - ORD ('A')+10;
      ELSIF ('a' <= ch) AND (ch <= 'f') THEN  digit := ORD (ch) - ORD ('a')+10;
      ELSE  RETURN FALSE;
      END;
  
      (* rr := r * base *)
      rr := IBytes {0,..};
      FOR i := 0 TO n-1 DO
        VAR carry := Word.Times (r.x[i], base);
        BEGIN
          FOR j := i TO n-1 DO
            IF carry = 0 THEN EXIT END;
            INC (carry, rr[j]);
            rr[j] := Word.And (carry, Mask);
            carry := RShift (carry, BITSIZE (IByte));
          END;
          IF carry # 0 THEN RETURN FALSE END;
        END;
      END;

      (* r := rr + digit *)
      VAR carry := digit;
      BEGIN
        FOR i := 0 TO n-1 DO
          INC (carry, rr[i]);
          r.x[i] := Word.And (carry, Mask);
          carry := RShift (carry, BITSIZE (IByte));
        END;
        IF carry # 0 THEN RETURN FALSE END;
      END;
    END;

    RETURN TRUE;
  END New;

PROCEDURE Add (READONLY a, b: Int;  VAR r: Int) =
  VAR carry := 0;  n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    r.n := n;
    FOR i := 0 TO n-1 DO
      carry := a.x[i] + b.x[i] + carry;
      r.x[i] := Word.And (carry, Mask);
      carry := RShift (carry, BITSIZE (IByte));
    END;
  END Add;

PROCEDURE Subtract (READONLY a, b: Int;  VAR r: Int) =
  VAR borrow := 0;  n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    r.n := n;
    FOR i := 0 TO n-1 DO
      borrow := a.x[i] - b.x[i] - borrow;
      r.x[i] := Word.And (borrow, Mask);
      borrow := Word.And (RShift (borrow, BITSIZE (IByte)), 1);
    END;
  END Subtract;

PROCEDURE Multiply (READONLY a, b: Int;  VAR r: Int) =
  VAR carry: INTEGER;  n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    r := Int{n};
    FOR i := 0 TO n-1 DO
      FOR j := 0 TO n-1 DO
        carry := Word.Times (a.x[i], b.x[j]);
        FOR k := i + j TO n-1 DO
          IF carry = 0 THEN EXIT END;
          carry := carry + r.x[k];
          r.x[k] := Word.And (carry, Mask);
          carry := RShift (carry, BITSIZE (IByte));
        END;
      END;
    END;
  END Multiply;

PROCEDURE Div (READONLY num, den: Int;  VAR q: Int): BOOLEAN =
  VAR r: Int;
  BEGIN
    IF TInt.EQ (den, TInt.Zero) THEN  RETURN FALSE;  END;
    IF TInt.EQ (num, TInt.Zero) THEN  q := TInt.Zero;  RETURN TRUE;  END;
    DivMod (num, den, q, r);
    RETURN TRUE;
  END Div;

PROCEDURE Mod (READONLY num, den: Int;  VAR r: Int): BOOLEAN =
  VAR q: Int;
  BEGIN
    IF TInt.EQ (den, TInt.Zero) THEN  RETURN FALSE;  END;
    IF TInt.EQ (num, TInt.Zero) THEN  r := TInt.Zero;  RETURN TRUE;  END;
    DivMod (num, den, q, r);
    RETURN TRUE;
  END Mod;

PROCEDURE DivMod (READONLY x, y: Int;  VAR q, r: Int) =
  VAR
    carry   : INTEGER;
    borrow  : INTEGER;
    tmp     : INTEGER;
    max_den : CARDINAL := 0;
    max_num : CARDINAL := 0;
    scale   : INTEGER;
    quo_est : INTEGER;
    num_hi  : INTEGER;
    x1,x2,x3: INTEGER;
    num, den: ARRAY [0..NUMBER (IBytes)+1] OF INTEGER;
    n := MIN (x.n, y.n);
  BEGIN
    <*ASSERT n # 0*>
    (* initialize the numerator and denominator,
       and find the highest non-zero digits *)
    FOR i := 0 TO n-1 DO
      num[i] := x.x[i];  IF num[i] # 0 THEN max_num := i END;
      den[i] := y.x[i];  IF den[i] # 0 THEN max_den := i END;
    END;
    FOR i := n TO LAST (num) DO
      num[i] := 0;
      den[i] := 0;
    END;

    q := Int{n};
    r := Int{n};

    IF max_den = 0 THEN
      (* single digit denominator case *)
      carry := 0;
      FOR j := max_num TO 0 BY -1 DO
        tmp := carry * Base + num [j];
        q.x [j] := tmp DIV den[0];
        carry := tmp MOD den[0];
      END;
      r.x[0] := carry;
      RETURN;
    END;
      
    (* Insure that the first digit of the divisor is at least Base/2.
       This is required by the quotient digit estimation algorithm.  *)
      
    scale := Base DIV (den [max_den] + 1);
    IF scale > 1 THEN (* scale divisor and dividend *)
      carry := 0;
      FOR i := FIRST (num) TO LAST (num) DO
        tmp := (num[i] * scale) + carry;
        num [i] := Word.And (tmp, Mask);
        carry := RShift (tmp, BITSIZE (IByte));
        IF num[i] # 0 THEN max_num := i; END;
      END;
      
      carry := 0;
      FOR i := FIRST (den) TO LAST (den) DO
        tmp := (den[i] * scale) + carry;
        den[i] := Word.And (tmp, Mask);
        carry := RShift (tmp, BITSIZE (IByte));
        IF den[i] # 0 THEN max_den := i; END;
      END;
    END;
      
    (* Main loop *)
    FOR i := max_num - max_den + 1 TO 1 BY -1 DO
      (* guess the next quotient digit, quo_est, by dividing the first
         two remaining dividend digits by the high order quotient digit.
         quo_est is never low and is at most 2 high.  *)

      num_hi := i + max_den; (* index of highest remaining dividend digit *)
          
      tmp := (num [num_hi] * Base);
      IF num_hi > 0 THEN tmp := tmp + num [num_hi - 1]; END;
      IF num [num_hi] # den [max_den]
        THEN quo_est := tmp DIV den [max_den];
        ELSE quo_est := Base - 1;
      END;
        
      (* refine quo_est so it's usually correct, and at most one high.   *)
      x3 := 0; IF (num_hi > 1) THEN x3 := num[num_hi - 2] END;
      LOOP
        x1 := den[max_den - 1] * quo_est;
        x2 := (tmp - (quo_est * den[max_den])) * Base;
        IF (x1 <= x2 + x3) THEN EXIT END;
        DEC (quo_est);
      END;
          
      (* Try quo_est as the quotient digit, by multiplying the
         denominator by quo_est and subtracting from the remaining
         numerator. Keep in mind that quo_est is the i-1st digit.
         Because we combine the multiply and subtract, borrow
         can be more than 1. *)
      borrow := 0;
      FOR j := 0 TO max_den DO
        tmp := num[i + j - 1] - (quo_est * den[j]) + borrow;
        num [i + j - 1] := tmp MOD Base;
        borrow := tmp DIV Base;
      END; 

      (* if quo_est was high by one, we need to correct things.  *)
      IF -borrow > num [num_hi] THEN
        DEC (quo_est);
        carry := 0;
        FOR j := 0 TO max_den DO 
          tmp := num [i + j - 1] + den [j] + carry;
          num [i + j - 1] := tmp MOD Base;
          carry := tmp DIV Base;
        END;
        INC (num [i + max_den], borrow + carry);
      END;

      (* store the quotient digit.  *)
      q.x [i - 1] := quo_est;
    END;

    (* finally, compute the remainder *)
    Multiply (q, y, r);
    Subtract (x, r, r);
  END DivMod;

PROCEDURE LT (READONLY a, b: Int): BOOLEAN =
  VAR n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    FOR i := n TO a.n-1 DO IF a.x[i] # 0 THEN RETURN FALSE END END;
    FOR i := n TO b.n-1 DO IF b.x[i] # 0 THEN RETURN TRUE  END END;
    FOR i := n-1 TO 0 BY -1 DO
      IF    a.x[i] < b.x[i] THEN RETURN TRUE;
      ELSIF a.x[i] > b.x[i] THEN RETURN FALSE;
      END;
    END;
    RETURN FALSE;
  END LT;

PROCEDURE LE (READONLY a, b: Int): BOOLEAN =
  VAR n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    FOR i := n TO a.n-1 DO IF a.x[i] # 0 THEN RETURN FALSE END END;
    FOR i := n TO b.n-1 DO IF b.x[i] # 0 THEN RETURN TRUE  END END;
    FOR i := n-1 TO 0 BY -1 DO
      IF    a.x[i] < b.x[i] THEN RETURN TRUE;
      ELSIF a.x[i] > b.x[i] THEN RETURN FALSE;
      END;
    END;
    RETURN TRUE;
  END LE;

PROCEDURE And (READONLY a, b: Int;  VAR r: Int) =
  VAR n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    r.n := n;
    FOR i := 0 TO n-1 DO
      r.x[i] := Word.And (a.x[i], b.x[i]);
    END;
  END And;

PROCEDURE Or (READONLY a, b: Int;  VAR r: Int) =
  VAR n := MIN (a.n, b.n);
  BEGIN
    r.n := n;
    FOR i := 0 TO n-1 DO
      r.x[i] := Word.Or (a.x[i], b.x[i]);
    END;
  END Or;

PROCEDURE Xor (READONLY a, b: Int;  VAR r: Int) =
  VAR n := MIN (a.n, b.n);
  BEGIN
    <*ASSERT n # 0*>
    r.n := n;
    FOR i := 0 TO n-1 DO
      r.x[i] := Word.Xor (a.x[i], b.x[i]);
    END;
  END Xor;

PROCEDURE Not (READONLY a: Int;  VAR r: Int) =
  VAR n := a.n;
  BEGIN
    <*ASSERT n # 0*>
    r.n := n;
    FOR i := 0 TO n-1 DO
      r.x[i] := Word.And (Word.Not (a.x[i]), Mask);
    END;
  END Not;

PROCEDURE Shift (READONLY a: Int;  b: INTEGER;  VAR r: Int) =
  VAR w, i, j, z, x1, x2: INTEGER;
      n := a.n;  size := n * BITSIZE (IByte);
  BEGIN
    <*ASSERT n # 0*>
    IF ABS (b) >= size THEN
      r := Int{n};
      RETURN;
    END;

    IF b = 0 THEN (* no shift *)
      r := a;

    ELSIF b > 0 THEN (* left shift *)
      w := b DIV BITSIZE (IByte);
      i := b MOD BITSIZE (IByte);
      j := BITSIZE (IByte) - i;
      FOR k := n-1 TO 0 BY -1 DO
        z := k - w;  x1 := 0;  x2 := 0;
        IF z   >= 0 THEN  x1 := LShift (a.x[z], i);   END;
        IF z-1 >= 0 THEN  x2 := RShift (a.x[z-1], j); END;
        r.x[k] := Word.And (Word.Or (x1, x2), Mask);
      END;
      r.n := a.n;

    ELSE (* right shift *)
      w := (-b) DIV BITSIZE (IByte);
      i := (-b) MOD BITSIZE (IByte);
      j := BITSIZE (IByte) - i;
      FOR k := 0 TO n-1 DO
        z := k + w;  x1 := 0;  x2 := 0;
        IF z   <= n-1 THEN x1 := RShift (a.x[z], i);   END;
        IF z+1 <= n-1 THEN x2 := LShift (a.x[z+1], j); END;
        r.x[k] := Word.And (Word.Or (x1, x2), Mask);
      END;
      r.n := a.n;

    END;
  END Shift;

PROCEDURE Rotate (READONLY a: Int;  b: INTEGER;  VAR r: Int) =
  VAR
    w, i, j, z, x1, x2: INTEGER;
    tmp: IBytes;
    n := a.n;  size := n * BITSIZE (IByte);
  BEGIN
    <*ASSERT n # 0*>
    b := b MOD size;

    IF b = 0 THEN
      r := a;

    ELSIF b > 0 THEN (* left rotate *)
      w := b DIV BITSIZE (IByte);
      i := b MOD BITSIZE (IByte);
      j := BITSIZE (IByte) - i;
      FOR k := 0 TO n-1 DO
        z := k - w;  x1 := 0;  x2 := 0;
        x1 := LShift (a.x[z MOD n], i);
        x2 := RShift (a.x[(z-1) MOD n], j);
        tmp[k] := Word.And (Word.Or (x1, x2), Mask);
      END;
      r := Int {a.n, tmp};

    ELSE (* right rotate *)
      w := (-b) DIV BITSIZE (IByte);
      i := (-b) DIV BITSIZE (IByte);
      j := BITSIZE (IByte) - i;
      FOR k := 0 TO n-1 DO
        z := k + w;  x1 := 0;  x2 := 0;
        x1 := RShift (a.x[z MOD n], i);
        x2 := LShift (a.x[(z+1) MOD n], j);
        tmp[k] := Word.And (Word.Or (x1, x2), Mask);
      END;
      r := Int {a.n, tmp};

    END;
  END Rotate;

PROCEDURE Extract (READONLY x: Int;  i, n: CARDINAL;  VAR r: Int): BOOLEAN =
  VAR w, b: INTEGER;
      size := x.n * BITSIZE (IByte);
  BEGIN
    IF i + n > size THEN RETURN FALSE; END;

    Shift (x, -i, r);

    w := n DIV BITSIZE (IByte);
    b := n MOD BITSIZE (IByte);
    r.x[w] := Word.And (r.x[w], RShift (Mask, BITSIZE (IByte) - b));
    FOR k := w + 1 TO LAST (IBytes) DO r.x[k] := 0; END;

    RETURN TRUE;
  END Extract;

PROCEDURE Insert (READONLY x, y: Int;  i, n: CARDINAL;  VAR r: Int): BOOLEAN =
  VAR yy, yyy, yyyy: Int;
      size := x.n * BITSIZE (IByte);
  BEGIN
    IF i + n > size THEN RETURN FALSE; END;

    Shift (x, -(i + n), yy);
    Shift (yy, n, r);

    Shift (y, size - n, yy);
    Shift (yy, -(size - n), yyy);
    Or (r, yyy, r);
    Shift (r, i, yyyy);
    r := yyyy;

    Shift (x, size - i, yy);
    Shift (yy, -(size - i), yyy);
    Or (r, yyy, r);

    RETURN TRUE;
  END Insert;

BEGIN
END TWord.
