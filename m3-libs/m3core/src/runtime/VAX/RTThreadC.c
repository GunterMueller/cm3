/* Copyright (C) 1990, Digital Equipment Corporation           */
/* All rights reserved.                                        */
/* See the file COPYRIGHT for a full description.              */
/* Last modified on Fri Apr 29 16:13:08 PDT 1994 by kalsow     */
/*      modified on Tue Jan 19 15:20:48 PST 1993 by burrows    */

/* This file implements the coroutine transfer: RTThread.Transfer */

extern int WildSetjmp ();
extern int WildLongjmp ();

typedef int wild_jmp_buf[];

RTThread__Transfer (from, to)
wild_jmp_buf *from, *to;
{
  if (WildSetjmp(*from) == 0) WildLongjmp (*to, 1);
}

/* global, per-thread linked list of exception handlers */
void* ThreadF__handlerStack = 0;

