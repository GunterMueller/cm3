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
 * Created On      : Thu Jul  3 09:18:36 1997
 * Last Modified By: Blair MacIntyre
 * Last Modified On: Thu Jul  3 09:21:23 1997
 * Update Count    : 2
 * 
 * $Source: /opt/cvs/cm3/m3-obliq/obliqrt/src/ObValueField.m3,v $
 * $Date: 2001-12-02 14:34:48 $
 * $Author: wagner $
 * $Revision: 1.1.2.1 $
 * 
 * $Log: not supported by cvs2svn $
 * Revision 1.1  1997/07/11 18:07:04  bm
 * Forgot to add these!
 *
 * 
 * HISTORY
 *)

(* needed for using the ArraySort generic interface *)
MODULE ObValueField;

IMPORT Text;

PROCEDURE  Compare(a, b: T): [-1 .. 1] =
  BEGIN
    RETURN Text.Compare(a.label, b.label);
  END Compare;

BEGIN
END ObValueField.
