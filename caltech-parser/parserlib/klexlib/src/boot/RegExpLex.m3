MODULE RegExpLex;
(* Generated by klex *)
IMPORT RegExpTok;
IMPORT TextRd;
IMPORT Rd, Thread;
IMPORT SeekRd;
FROM RegExpTok IMPORT Token;
<* FATAL Rd.Failure, Thread.Alerted *>

REVEAL
  T = Public BRANDED "RegExpLex" OBJECT
    textCache: TEXT;
    charCache: CHAR;
    posBeforeToken: INTEGER;
    rd: Rd.T;
    allocate_COUNT: RegExpTok.Allocator := NIL;
    allocate_IDENTIFIER: RegExpTok.Allocator := NIL;
    allocate_CHAR_RANGE: RegExpTok.Allocator := NIL;
    allocate_STRING: RegExpTok.Allocator := NIL;
  OVERRIDES
    init := Init;
    get := Get;
    unget := Unget;
    error := Error;
    rewind := Rewind;
    fromText := FromText;
    getRd := GetRd;
    getText := GetText;
    purge := Purge;
    COUNT := COUNT;
    IDENTIFIER := IDENTIFIER;
    brac_CHAR_RANGE := brac_CHAR_RANGE;
    dot_CHAR_RANGE := dot_CHAR_RANGE;
    STRING := STRING;
    char := char;
    skip := skip;
  END;

TYPE
  Byte = BITS 8 FOR [0..255];
  StateRef = BITS 5 FOR [0..22];
  TransRef = BITS 5 FOR [0..18];
  OutCode = BITS 4 FOR [0..8];

  S = RECORD
    keyBegin, keyEnd: Byte;
    target: StateRef;
    next: TransRef;
    output: OutCode;
  END;
  X = RECORD
    keyBegin, keyEnd: Byte;
    target: StateRef;
    next: TransRef;
  END;

CONST
  First = ARRAY CHAR OF [0..22] {
    0, 2, 2, 2, 2, 2, 2, 2, 2, 3, 4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    2, 2, 2, 2, 2, 2, 2, 3, 2, 5, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 4, 6, 2, 7, 7,
    7, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 4, 2, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
    7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 9, 4, 4, 7, 2, 7, 7, 7,
    7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 10,
    4, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    2, 2, 2, 2, 2, 2, 2};

  States = ARRAY [1..22] OF S {
    S{0,0,0,0,5}, S{1,255,0,0,8}, S{1,255,0,0,7}, S{1,255,0,0,6},
    S{34,34,20,2,8}, S{1,255,0,0,4}, S{92,92,18,7,5}, S{93,93,17,9,6},
    S{10,10,0,10,8}, S{37,37,11,16,8}, S{125,125,22,17,0}, S{48,57,12,18,0},
    S{48,57,13,15,0}, S{1,255,0,0,1}, S{93,93,17,9,0}, S{10,10,0,8,0},
    S{1,255,0,0,3}, S{10,10,0,10,0}, S{34,34,20,2,0}, S{1,255,0,0,5},
    S{10,10,0,1,0}, S{1,255,0,0,2}};

  Trans = ARRAY [1..18] OF X {
    X{1,255,19,0}, X{92,92,21,1}, X{1,255,0,0}, X{97,122,7,3}, X{95,95,7,4},
    X{65,90,7,5}, X{48,57,7,6}, X{1,255,15,0}, X{92,92,16,8}, X{1,255,7,0},
    X{97,122,11,3}, X{95,95,11,11}, X{65,90,11,12}, X{125,125,14,13},
    X{44,44,12,14}, X{48,57,13,15}, X{48,57,11,13}, X{125,125,14,3}};

PROCEDURE Init(self: T; rd: Rd.T): RegExpTok.RdLexer =
  BEGIN
    self.textCache := "";
    self.charCache := '\000';
    self.posBeforeToken := -1;
    self.rd := rd;
    RETURN self;
  END Init;

PROCEDURE NextCode(self: T): OutCode RAISES {Rd.EndOfFile} =
  VAR
    rd := self.rd;
    lastAcceptingOutput: INTEGER := 0;
    lastAcceptingPos: INTEGER := Rd.Index(rd);
    firstChar := Rd.GetChar(rd);
    curState := First[firstChar];
    curTrans: INTEGER;
    c: Byte;
  BEGIN
    self.charCache := firstChar;
    self.posBeforeToken := lastAcceptingPos;
    TRY
      WHILE curState # 0 DO
        WITH state = States[curState] DO
          IF state.output # 0 THEN
            lastAcceptingOutput := state.output;
            lastAcceptingPos := Rd.Index(rd);
          END;
          c := ORD(Rd.GetChar(rd));
          IF c >= state.keyBegin AND c <= state.keyEnd THEN
            curState := state.target;
          ELSE
            curTrans := state.next;
            WHILE curTrans # 0 DO
              WITH trans = Trans[curTrans] DO
                IF c >= trans.keyBegin AND c <= trans.keyEnd THEN
                  curState := trans.target;
                  curTrans := 0;
                ELSE
                  curTrans := trans.next;
                END;
              END;
            END;
          END;
        END;
      END;
    EXCEPT
    | Rd.EndOfFile =>
      IF lastAcceptingOutput = 0 THEN
        Rd.Seek(rd, lastAcceptingPos);
        RAISE Rd.EndOfFile;
      END;
    END;
    Rd.Seek(rd, lastAcceptingPos);
    RETURN lastAcceptingOutput;
  END NextCode;

PROCEDURE Get(self: T): Token RAISES {Rd.EndOfFile} =
  VAR
    result: Token;
  BEGIN
    SeekRd.DiscardPrevious(self.rd);
    REPEAT
      self.textCache := NIL;
      CASE NextCode(self) OF
      | 0 => <* ASSERT FALSE *> (* unmatched *)
      | 1 => result := self.COUNT();
      | 2 => result := self.IDENTIFIER();
      | 3 => result := self.brac_CHAR_RANGE();
      | 4 => result := self.dot_CHAR_RANGE();
      | 5 => result := self.STRING();
      | 6 => result := self.char();
      | 7 => result := self.skip();
      | 8 => result := RegExpTok.NewConstToken(RegExpTok.ERROR);
      END;
    UNTIL result # NIL;
    RETURN result;
  END Get; 

PROCEDURE Unget(self: T) =
  BEGIN     
    <* ASSERT self.posBeforeToken # -1 *>
    Rd.Seek(self.rd, self.posBeforeToken);
    self.posBeforeToken := -1;
  END Unget;

PROCEDURE GetText(self: T): TEXT =
  VAR
    len: INTEGER;
  BEGIN
    IF self.textCache = NIL THEN
      <* ASSERT self.posBeforeToken # -1 *>
      len := Rd.Index(self.rd) - self.posBeforeToken;
      Rd.Seek(self.rd, self.posBeforeToken);
      self.textCache := Rd.GetText(self.rd, len);
    END;
    RETURN self.textCache;
  END GetText;

PROCEDURE Purge(self: T): INTEGER =
  BEGIN
    RETURN 0
    + RegExpTok.Purge(self.allocate_COUNT)
    + RegExpTok.Purge(self.allocate_IDENTIFIER)
    + RegExpTok.Purge(self.allocate_CHAR_RANGE)
    + RegExpTok.Purge(self.allocate_STRING);
  END Purge;

PROCEDURE GetRd(self: T): Rd.T =
  BEGIN RETURN self.rd; END GetRd;

PROCEDURE Rewind(self: T) =
  BEGIN Rd.Seek(self.rd, 0); EVAL self.init(self.rd); END Rewind;

PROCEDURE FromText(self: T; t: TEXT): RegExpTok.Lexer =
  BEGIN RETURN self.init(TextRd.New(t)); END FromText;

PROCEDURE Error(self: T; message: TEXT) =
  BEGIN SeekRd.E(self.rd, message); END Error;

(* default token methods *)
PROCEDURE COUNT(self: T): Token = BEGIN
 RETURN RegExpTok.NewPT(self.allocate_COUNT, TYPECODE(RegExpTok.COUNT));END COUNT;

PROCEDURE IDENTIFIER(self: T): Token = BEGIN
 RETURN RegExpTok.NewPT(self.allocate_IDENTIFIER, TYPECODE(RegExpTok.IDENTIFIER));END IDENTIFIER;

PROCEDURE brac_CHAR_RANGE(self: T): Token = BEGIN
 RETURN RegExpTok.NewPT(self.allocate_CHAR_RANGE, TYPECODE(RegExpTok.CHAR_RANGE));END brac_CHAR_RANGE;

PROCEDURE dot_CHAR_RANGE(self: T): Token = BEGIN
 RETURN RegExpTok.NewPT(self.allocate_CHAR_RANGE, TYPECODE(RegExpTok.CHAR_RANGE));END dot_CHAR_RANGE;

PROCEDURE STRING(self: T): Token = BEGIN
 RETURN RegExpTok.NewPT(self.allocate_STRING, TYPECODE(RegExpTok.STRING));END STRING;

PROCEDURE skip(self: T): Token = BEGIN
 EVAL self; RETURN NIL;END skip;

PROCEDURE char(self: T): Token =
  BEGIN RETURN RegExpTok.NewConstToken(ORD(self.charCache)); END char;

BEGIN
END RegExpLex.
