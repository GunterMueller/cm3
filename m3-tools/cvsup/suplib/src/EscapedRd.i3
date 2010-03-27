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
 *)

(* The "EscapedRd" interface provides a subclass of "Rd.T" which
   decodes the record-oriented stream produced by an "EscapedWr.T".  See
   that interface for details of the protocol. *)

INTERFACE EscapedRd;

IMPORT Atom, Rd;

TYPE
  T <: Public;

  Public = Rd.T OBJECT METHODS
    init(rd: Rd.T;
	 maxChildRead: CARDINAL := LAST(CARDINAL);
	 closeChild: BOOLEAN := TRUE): T;
  END;

(* The optional parameter "maxChildRead" may be used to limit the
   amount of read-ahead done on the child when filling the buffer.
   That sacrifices some efficiency, but it tightens the relationship
   between the number of bytes read from the parent and the number
   of bytes read from the child.  (It is useful when statistics
   are being gathered.)

   If "closeChild" is "TRUE" (the default), then closing the escaped
   reader will also cause the child reader to be closed.  If it is
   "FALSE", then the child reader will be left open. *)

VAR (* CONST *)
  InvalidEscape: Atom.T;
  PrematureEOF: Atom.T;

(* If the escaped reader detects a violation of the protocol, it raises
   "Rd.Failure" with an error list containing "InvalidEscape" or
   "PrematureEOF". *)

END EscapedRd.
