(* Copyright 1996-2003 John D. Polstra.
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
 *
 * $Id$ *)

UNSAFE MODULE GzipRd;

IMPORT
  GzipError, OSError, Rd, RdClass, StreamRdClass, Thread, Ugzip;
FROM Ctypes IMPORT unsigned_char_star;

REVEAL
  T = Public BRANDED OBJECT
    rd: Rd.T;
    maxChildRead: CARDINAL;
    closeChild: BOOLEAN;
    eof: BOOLEAN := FALSE;
    strmp: Ugzip.z_stream_star := NIL;
  OVERRIDES
    init := Init;
    seek := Seek;
    length := Length;
    close := Close;
  END;

PROCEDURE Cleanup(self: T) =
  BEGIN
    IF self.strmp # NIL THEN
      IF self.strmp.state # NIL THEN
	EVAL Ugzip.inflateEnd(self.strmp);
      END;
      DISPOSE(self.strmp);
    END;
  END Cleanup;

PROCEDURE Close(self: T)
  RAISES {Rd.Failure, Thread.Alerted} =
  VAR
    status: INTEGER;
  BEGIN
    status := Ugzip.inflateEnd(self.strmp);
    DISPOSE(self.strmp);
    IF status # Ugzip.Z_OK THEN
      RAISE Rd.Failure(GzipError.FromStatus(status));
    END;

    IF self.closeChild THEN
      Rd.Close(self.rd);
    END;
  END Close;

PROCEDURE Inflate(strmp: Ugzip.z_stream_star;
                  next_in: unsigned_char_star;
		  avail_in: CARDINAL;
		  next_out: unsigned_char_star;
		  avail_out: CARDINAL;
		  flush: INTEGER): INTEGER =
(* Call "Ugzip.inflate", making sure that pointers into the (traced)
   input and output buffers are on the stack or in registers.  This
   ensures that the collector will not move the buffers. *)
  BEGIN
    strmp.next_in := next_in;
    strmp.avail_in := avail_in;
    strmp.next_out := next_out;
    strmp.avail_out := avail_out;
    RETURN Ugzip.inflate(strmp, flush);
  END Inflate;

PROCEDURE Init(self: T;
               rd: Rd.T;
	       maxChildRead: CARDINAL := LAST(CARDINAL);
	       closeChild: BOOLEAN := TRUE): T
  RAISES {OSError.E} =
  VAR
    status: INTEGER;
  BEGIN
    RdClass.Lock(self);
    TRY
      self.rd := rd;
      self.maxChildRead := maxChildRead;
      self.closeChild := closeChild;

      self.buff := NEW(REF ARRAY OF CHAR, 8192);
      self.st := 0;
      self.seekable := FALSE;
      self.intermittent := TRUE;  (* Because we do not know the length. *)
      self.closed := FALSE;

      self.strmp := NEW(Ugzip.z_stream_star,
	zalloc := Ugzip.SafeAlloc,
	zfree := Ugzip.SafeFree,
	opaque := NIL,
	state := NIL);
      status := Ugzip.inflateInit(self.strmp);
      IF status # Ugzip.Z_OK THEN
	RAISE OSError.E(GzipError.FromStatus(status));
      END;
    FINALLY
      RdClass.Unlock(self);
    END;
    RETURN self;
  END Init;

PROCEDURE Length(<*UNUSED*> self: T): INTEGER =
  BEGIN
    RETURN -1;
  END Length;

PROCEDURE Seek(self: T; n: CARDINAL; dontBlock: BOOLEAN): RdClass.SeekResult
  RAISES {Rd.Failure, Thread.Alerted} =
  VAR
    status: INTEGER;
    rslt: RdClass.SeekResult;
    oldAvailIn: CARDINAL;
    oldAvailOut: CARDINAL;
  BEGIN
    <* ASSERT n = self.cur *>
    <* ASSERT self.cur = self.hi *>

    self.lo := self.cur;

    IF self.eof THEN  (* End of stream already reached on previous call. *)
      RETURN RdClass.SeekResult.Eof;
    END;

    TRY
      LOOP
	oldAvailIn := MIN(self.rd.hi-self.rd.cur, self.maxChildRead);
	oldAvailOut := (NUMBER(self.buff^) - self.st) - (self.hi - self.lo);
	status := Inflate(self.strmp,
	  ADR(self.rd.buff[self.rd.st]) + self.rd.cur - self.rd.lo,
	  oldAvailIn,
	  ADR(self.buff[self.st]) + self.hi - self.lo,
	  oldAvailOut,
	  Ugzip.Z_PARTIAL_FLUSH);
	INC(self.rd.cur, oldAvailIn - self.strmp.avail_in);
	INC(self.hi, oldAvailOut - self.strmp.avail_out);

	IF status = Ugzip.Z_STREAM_END THEN  (* No more data to read *)
	  self.eof := TRUE;
	  IF self.hi # self.lo THEN  (* We got something *)
	    RETURN RdClass.SeekResult.Ready;
	  ELSE
	    RETURN RdClass.SeekResult.Eof;
	  END;
	ELSIF status # Ugzip.Z_OK AND status # Ugzip.Z_BUF_ERROR THEN
	  RAISE Rd.Failure(GzipError.FromStatus(status));
	END;

	IF self.hi # self.lo THEN  (* We got some uncompressed data. *)
	  RETURN RdClass.SeekResult.Ready;
	END;

	(* We haven't generated any uncompressed data.  It must surely be
	   because we need more input. *)
	<* ASSERT self.rd.cur = self.rd.hi *>
	rslt := self.rd.seek(self.rd.cur, dontBlock);
	IF rslt # RdClass.SeekResult.Ready THEN
	  RETURN rslt;
	END;
      END;
    FINALLY
      StreamRdClass.DontOverflow(self);
    END;
  END Seek;

BEGIN
END GzipRd.
