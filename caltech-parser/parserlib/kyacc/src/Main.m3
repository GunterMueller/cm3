(* Copyright (c) 2000 California Institute of Technology *)
(* All rights reserved. See the file COPYRIGHT for a full description. *)
(* $Id$ *)

MODULE Main;
IMPORT TokParams;
IMPORT FileWr, Wr, Thread, OSError;
IMPORT FileRdErr;
IMPORT Pathname;
IMPORT TextSubs;
IMPORT YaccParse;
IMPORT yaccformBundle;
IMPORT Bundle;
IMPORT PDA;
IMPORT PDATransListFlat;
IMPORT RuleList;
IMPORT Fmt;

 IMPORT Term, PDATransListOp, Env; 
<* FATAL Thread.Alerted, Wr.Failure, OSError.E *>

VAR
  Debug := Env.Get("yaccDEBUG") # NIL;

  Form := yaccformBundle.Get();
  tp := TokParams.Get("yacc", ".y", "Parse.i3");
PROCEDURE RenumberRules(rules: RuleList.T; inc: INTEGER) =
  VAR
    cur := rules;
  BEGIN
    WHILE cur # NIL DO
      INC(cur.head.number, inc);
      cur := cur.tail;
    END;
  END RenumberRules;

PROCEDURE CodeRanges(subs: TextSubs.T;
                     symCodeLast, actionLast, stateLast: INTEGER) =
  VAR
    last := ARRAY [1..3] OF INTEGER{symCodeLast, actionLast, stateLast};
    bits :  ARRAY [1..3] OF INTEGER;
    base := ARRAY [1..3] OF TEXT{"%symCode", "%action", "%state"};
  VAR
    b, rep: INTEGER;
  BEGIN
    FOR i := 1 TO 3 DO
      b := 0;
      rep := 1;
      WHILE rep <= last[i] DO
        INC(b);
        INC(rep, rep);
      END;
      bits[i] := b;
    END;
    (* SRC Modula-3 packed type alignment *)
    b := bits[1] + bits[2];
    <* ASSERT b <= 32 *>
    IF b + bits[3] > 32 THEN
      bits[2] := 32 - bits[1];
    END;
    FOR i := 1 TO 3 DO
      subs.add(base[i] & "Last", Fmt.Int(last[i]));
      subs.add(base[i] & "Bits", Fmt.Int(bits[i]));
    END;
  END CodeRanges;

PROCEDURE TriNum(subs: TextSubs.T; prag: TEXT; val: INTEGER) =
  BEGIN
    FOR i := 0 TO 2 DO
      subs.add(prag & Fmt.Int(i), Fmt.Int(val+i));
    END;
  END TriNum;

PROCEDURE Subs(): TextSubs.T =
  VAR
    subs := NEW(TextSubs.T).init();
    rd := FileRdErr.Open(tp.source);
    tok := TokParams.ReadTokens(tp);
    yp := NEW(YaccParse.T).init(rd, tok, tp.outBase);
    rules := yp.getRules();
    numRules := RuleList.Length(rules);
    pda := PDA.New(rules, tok, yp.getCodes());
    lastShift := pda.lastShift;
    lastReduce := lastShift + numRules + 1;
    numSym, lastSymCode: INTEGER;
  BEGIN
    RenumberRules(yp.getRules(), lastShift+1);
    subs.add("\\\n", "");
    subs.add("%tok", tp.tokOutBase);
    subs.add("%yacc", tp.outBase);
    subs.add("%gen", "(* Generated by kyacc *)");
    subs.add("%prot",yp.fmtRules("    %name(VAR result: %return%sparams);\n"));
    subs.add("%defimpl", yp.fmtRules(Bundle.Get(Form, "yaccform.proc.m3")));
    subs.add("%type", yp.fmtTypes(Bundle.Get(Form,"yaccform.type.m3"),FALSE));
    subs.add("%orig", yp.fmtTypes(Bundle.Get(Form,"yaccform.orig.m3"),FALSE));
    subs.add("%ovr", yp.fmtRules("    %name := %name;\n"));
    subs.add("%gettok", tok.fmtVar("  %name = " &tp.tokOutBase& ".%name;\n"));
    subs.add("%tokOrig", tok.fmtOrig(NIL));
    pda.symInfo(numSym, lastSymCode);
    subs.add("%States", PDATransListFlat.Format(pda.statesArray,
                                                lastShift+1,
                                                lastReduce+1,
                                                lastSymCode+1));
    subs.add("%Symbols", pda.fmtSymbols());
    subs.add("%DECaction", Fmt.Int(numRules+1));
    subs.add("%Rules", yp.fmtRules(Bundle.Get(Form, "yaccform.rule.m3")));
    subs.add("%reduce", yp.fmtRules(Bundle.Get(Form, "yaccform.reduce.m3")));
   subs.add("%case",yp.fmtTypes(Bundle.Get(Form,"yaccform.typecase.m3"),TRUE));

    subs.add("%numSym", Fmt.Int(numSym));
    subs.add("%symCodePenult", Fmt.Int(lastSymCode));
    
    CodeRanges(subs, lastSymCode + 1, lastReduce + numRules + 1,
               LAST(pda.statesArray^));
    TriNum(subs, "%lastShift", lastShift);
    TriNum(subs, "%lastReduce", lastReduce);

    subs.add("%alloc", yp.fmtTypes("    allocate_%name: " &
      tp.tokOutBase & ".Allocator;\n", FALSE));
    subs.add("%purge", yp.fmtTypes("\n      + " &
      tp.tokOutBase & ".Purge(self.allocate_%name)", FALSE));

    IF Debug THEN
      PDATransListOp.PrintArray(pda.statesArray);
      Term.WrLn(yp.fmtRules("%debug\n"));
      RenumberRules(yp.getRules(), -(lastShift+1));
      PDA.Test(pda);
    END;

    RETURN subs;    
  END Subs;

VAR
  subs := Subs();
PROCEDURE WriteFile(pathName: Pathname.T; formName: TEXT) =
  VAR
    wr := FileWr.Open(pathName);
  BEGIN
    Wr.PutText(wr, subs.apply(Bundle.Get(Form, formName)));
    Wr.Close(wr);
  END WriteFile;
BEGIN
  WriteFile(tp.out, "yaccform.i3");
  WriteFile(Pathname.ReplaceExt(tp.out, "m3"), "yaccform.m3");
END Main.
