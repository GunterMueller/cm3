(*                            -*- Mode: Modula-3 -*- 
 * 
 * For information about this program, contact Blair MacIntyre            
 * (bm@cs.columbia.edu) or Steven Feiner (feiner@cs.columbia.edu)         
 * at the Computer Science Dept., Columbia University,                    
 * 1214 Amsterdam Ave. Mailstop 0401, New York, NY, 10027.                
 *                                                                        
 * Copyright (C) 1995, 1996 by The Trustees of Columbia University in the 
 * City of New York.  Blair MacIntyre, Computer Science Department.       
 * 
 * Author          : Blair MacIntyre
 * Created On      : Wed Mar 12 12:16:45 1997
 * Last Modified By: Blair MacIntyre
 * Last Modified On: Wed Sep 24 14:59:52 1997
 * Update Count    : 10
 * 
 * $Source: /opt/cvs/cm3/m3-obliq/obliqlibemb/src/ObLoader.i3,v $
 * $Date: 2001-12-02 14:34:46 $
 * $Author: wagner $
 * $Revision: 1.1.1.1.2.1 $
 * 
 * $Log: not supported by cvs2svn $
 * Revision 1.4  1997/10/22 14:21:50  bm
 * fixed typos in the help files.  Changed EmbProxiedObj obliq object to
 * not be protected.
 *
 * Revision 1.3  1997/07/11 17:37:23  bm
 * Potential release version
 *
 * Revision 1.2  1997/03/12 21:34:58  bm
 * Moved sharedobj from coterie
 *
 * 
 * HISTORY
 *)

INTERFACE ObLoader;

IMPORT Bundle, Obliq, ObCommand, TextSeq, SynWr;

(* The generic Obliq Loader class.  This class allows Obliq source and
   help files to be stored in files and/or bundled and be loaded by
   the various Obliq initialization routines.

   The init routines specify a "parent" loader from which the base
   environment is obtained.   If your Obliq package depends on another
   obliq package, you should initialize this other package and then
   pass its loader to your packages init routine.

   The init routines also specify an "alt" (alternate) loader.  If the
   requested file cannot be found in this loader, the "alt" loader is
   searched for the file.  This allows, for example, a set of
   directories to be searched for files, followed by a compiled in
   Bundle.
*)

TYPE
  T <: Public;
  Public = OBJECT
  METHODS
    load (filename : TEXT);
    get (qualname : TEXT) : Obliq.Val;
    writer (): SynWr.T;
    help (wr: SynWr.T; cmd: ObCommand.T; arg: TEXT; 
          pkgname: TEXT; m3name: TEXT := NIL);
  END;

TYPE
  BundleT <: BundlePublic;
  BundlePublic = T OBJECT
  METHODS
    init (wr: SynWr.T; bundle: Bundle.T; parent: T := NIL; alt: T := NIL) : T;
  END;

TYPE
  DirT <: DirPublic;
  DirPublic = T OBJECT
  METHODS
    init (wr: SynWr.T; root: TEXT; parent: T := NIL; alt: T := NIL) : T;
  END;

PROCEDURE NewDirs(wr: SynWr.T; roots: TextSeq.T; parent: T := NIL; 
                  alt: T := NIL): T;
(* A convenience routine to create a sequence of DirT loaders which
   will search the sequence of dirs in "roots" for the requested
   files. *)

PROCEDURE NewDefaultDir(wr: SynWr.T; package: TEXT;
                        parent: T := NIL; alt: T := NIL): T;
(* A convenience routine to create a single DirT loader which
   will search the subdirectory "package/src" in the directory
   specified by the environment variable "M3PACKAGEDIR".  Returns
   "alt" if "M3PACKAGEDIR/package/src" is not found. *)

END ObLoader.
