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

UNSAFE MODULE Ugzip;

IMPORT Cstdlib, CText, Scheduler AS SchedulerPosix, UgzipP;

FROM Ctypes IMPORT int, unsigned_int, void_star;

PROCEDURE deflateInit(strm: z_stream_star; level: int): int =
  VAR
    ver := ZLIB_VERSION;
    verStr := CText.SharedTtoS(ver);
    retVal: int;
  BEGIN
    retVal := UgzipP.deflateInit_(strm, level, verStr, BYTESIZE(z_stream));
    CText.FreeSharedS(ver, verStr);
    RETURN retVal;
  END deflateInit;

PROCEDURE inflateInit(strm: z_stream_star): int =
  VAR
    ver := ZLIB_VERSION;
    verStr := CText.SharedTtoS(ver);
    retVal: int;
  BEGIN
    retVal := UgzipP.inflateInit_(strm, verStr, BYTESIZE(z_stream));
    CText.FreeSharedS(ver, verStr);
    RETURN retVal;
  END inflateInit;

PROCEDURE SafeAlloc(<*UNUSED*> opaque: void_star;
                    items: unsigned_int;
		    size: unsigned_int): void_star =
  BEGIN
    SchedulerPosix.DisableSwitching();
    TRY
      RETURN Cstdlib.malloc(items * size);
    FINALLY
      SchedulerPosix.EnableSwitching();
    END;
  END SafeAlloc;

PROCEDURE SafeFree(<*UNUSED*> opaque: void_star;
                   address: void_star) =
  BEGIN
    SchedulerPosix.DisableSwitching();
    TRY
      Cstdlib.free(address);
    FINALLY
      SchedulerPosix.EnableSwitching();
    END;
  END SafeFree;

BEGIN
END Ugzip.
