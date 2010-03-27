(* Copyright 1999-2003 John D. Polstra.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgment:
 *      This product includes software developed by John D. Polstra.
 * 4. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

MODULE AuthMD5;

IMPORT ASCII, Fmt, IP, MD5, Process, Random, Text, Time;

VAR
  rand: Random.T := NIL;

PROCEDURE CheckResponse(response: TEXT;
		        challenge: TEXT;
		        sharedSecret: TEXT): BOOLEAN =
  BEGIN
    RETURN Text.Equal(response, GenResponse(challenge, sharedSecret));
  END CheckResponse;

PROCEDURE GenChallenge(peerAddr: IP.Address;
		       privateKey: TEXT): TEXT =
  VAR
    md5 := MD5.New();
  BEGIN
    IF rand = NIL THEN
      rand := NEW(Random.Default).init();
    END;
    md5.updateText(Fmt.Int(peerAddr.a[0]));
    md5.updateText(".");
    md5.updateText(Fmt.Int(peerAddr.a[1]));
    md5.updateText(".");
    md5.updateText(Fmt.Int(peerAddr.a[2]));
    md5.updateText(".");
    md5.updateText(Fmt.Int(peerAddr.a[3]));
    md5.updateText(":");
    md5.updateText(Fmt.LongReal(Time.Now(), Fmt.Style.Fix));
    md5.updateText(":");
    md5.updateText(Fmt.Int(Process.GetMyID()));
    md5.updateText(":");
    md5.updateText(Fmt.Int(rand.integer(0)));
    md5.updateText(":");
    md5.updateText(privateKey);
    RETURN md5.finish();
  END GenChallenge;

PROCEDURE GenResponse(challenge: TEXT;
                      sharedSecret: TEXT): TEXT =
  VAR
    md5 := MD5.New();
  BEGIN
    md5.updateText(sharedSecret);
    md5.updateText(":");
    md5.updateText(challenge);
    RETURN md5.finish();
  END GenResponse;

PROCEDURE MakeSecret(realm: TEXT;
                     user: TEXT;
		     password: TEXT): TEXT =
  VAR
    md5 := MD5.New();
  BEGIN
    md5.updateText(ToLower(user));
    md5.updateText(":");
    md5.updateText(ToLower(realm));
    md5.updateText(":");
    md5.updateText(password);
    RETURN "$md5$" & md5.finish();
  END MakeSecret;

PROCEDURE ToLower(t: TEXT): TEXT =
  VAR
    len := Text.Length(t);
    chars := NEW(REF ARRAY OF CHAR, len);
  BEGIN
    Text.SetChars(chars^, t);
    FOR i := 0 TO len-1 DO
      chars[i] := ASCII.Lower[chars[i]];
    END;
    RETURN Text.FromChars(chars^);
  END ToLower;

BEGIN
END AuthMD5.
