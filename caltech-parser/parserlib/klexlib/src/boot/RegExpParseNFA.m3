MODULE RegExpParseNFA;
(* generated by kext *)
IMPORT RegExpParse;
IMPORT NFA;
IMPORT CharCodes;
IMPORT Interval;
IMPORT NFATbl;
IMPORT FileRdErr;
IMPORT RegExpLexStd;

PROCEDURE Init(self: T): T =
  BEGIN
    self.exprMacros := NEW(NFATbl.Default).init();
    RETURN self;
  END Init;

PROCEDURE ParseText(self: T; t: TEXT): NFA.T =
  BEGIN
    <* ASSERT self.exprMacros # NIL *>
    EVAL self.setLex(NEW(RegExpLexStd.T).fromText(t));
    RETURN NARROW(self.parse(), expr).val;
  END ParseText; 

PROCEDURE PutMacro(self: T; name: TEXT; n: NFA.T) =
  BEGIN
    <* ASSERT self.exprMacros # NIL *>
    IF self.exprMacros.put(name, n) THEN
      FileRdErr.E(NIL, "redeclared macro: " & name);
    END;
  END PutMacro;

PROCEDURE Lookup(self: T; name: TEXT): NFA.T =
  VAR
    n: NFA.T;
  BEGIN
    IF NOT self.exprMacros.get(CharCodes.StripDelims(name), n) THEN
      FileRdErr.E(NIL, "undeclared macro: " & name);
    END;
    RETURN NFA.Copy(n);
  END Lookup;

REVEAL
  T = Public BRANDED "RegExpParseNFA" OBJECT
    allocate_expr: Allocator := NIL;
exprMacros : NFATbl.T := NIL;  OVERRIDES
    purge := Proc_Purge;
    parseText := ParseText;
    putMacro := PutMacro;
    init := Init;
    repeat_expr := Proc_repeat_expr;
    ident_expr := Proc_ident_expr;
    or_expr := Proc_or_expr;
    plus_expr := Proc_plus_expr;
    paren_expr := Proc_paren_expr;
    quest_expr := Proc_quest_expr;
    string_expr := Proc_string_expr;
    concat_expr := Proc_concat_expr;
    star_expr := Proc_star_expr;
    charRange_expr := Proc_charRange_expr;
  END;

PROCEDURE Proc_Purge(self: T): INTEGER =
  BEGIN
    RETURN RegExpParse.T.purge(self)
      + Purge(self.allocate_expr);
  END Proc_Purge;

(* rule procedures *)
PROCEDURE Proc_paren_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.paren_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := n1.val
    END;
    p0 := result;
  END Proc_paren_expr;

PROCEDURE Proc_concat_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr; p2: Original_expr) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
    n2 := NARROW(p2, expr);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.concat_expr(self, p0, p1, p2);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.Concat(n1.val, n2.val)
    END;
    p0 := result;
  END Proc_concat_expr;

PROCEDURE Proc_or_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr; p2: Original_expr) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
    n2 := NARROW(p2, expr);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.or_expr(self, p0, p1, p2);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.Or(n1.val, n2.val)
    END;
    p0 := result;
  END Proc_or_expr;

PROCEDURE Proc_plus_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.plus_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.Rept(n1.val, Interval.T{1, NFA.OrMore})
    END;
    p0 := result;
  END Proc_plus_expr;

PROCEDURE Proc_star_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.star_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.Rept(n1.val, Interval.T{0, NFA.OrMore})
    END;
    p0 := result;
  END Proc_star_expr;

PROCEDURE Proc_quest_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.quest_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.Rept(n1.val, Interval.T{0, 1})
    END;
    p0 := result;
  END Proc_quest_expr;

PROCEDURE Proc_repeat_expr(self: T;
 VAR p0: Original_expr; p1: Original_expr; p2: Original_COUNT) =
  VAR
    result: expr;
    n1 := NARROW(p1, expr);
    n2 := NARROW(p2, COUNT);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.repeat_expr(self, p0, p1, p2);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.Rept(n1.val, n2.val)
    END;
    p0 := result;
  END Proc_repeat_expr;

PROCEDURE Proc_ident_expr(self: T;
 VAR p0: Original_expr; p1: Original_IDENTIFIER) =
  VAR
    result: expr;
    n1 := NARROW(p1, IDENTIFIER);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.ident_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := Lookup(self, n1.val)
    END;
    p0 := result;
  END Proc_ident_expr;

PROCEDURE Proc_string_expr(self: T;
 VAR p0: Original_expr; p1: Original_STRING) =
  VAR
    result: expr;
    n1 := NARROW(p1, STRING);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.string_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.FromString(n1.val)
    END;
    p0 := result;
  END Proc_string_expr;

PROCEDURE Proc_charRange_expr(self: T;
 VAR p0: Original_expr; p1: Original_CHAR_RANGE) =
  VAR
    result: expr;
    n1 := NARROW(p1, CHAR_RANGE);
  BEGIN
    IF p0 = NIL THEN
      p0 := NewPT(self.allocate_expr, TYPECODE(expr));
    END;
    RegExpParse.T.charRange_expr(self, p0, p1);
    result := NARROW(p0, expr);
    BEGIN (* user code *)
      result.val := NFA.FromRange(n1.val)
    END;
    p0 := result;
  END Proc_charRange_expr;

BEGIN
END RegExpParseNFA.
