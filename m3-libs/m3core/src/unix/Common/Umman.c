/* Copyright (C) 1992, Digital Equipment Corporation                         */
/* All rights reserved.                                                      */
/* See the file COPYRIGHT for a full description.                            */

#include "m3core.h"
#define M3MODULE Umman

#ifndef _WIN32

M3WRAP3(int, mprotect, ADDRESS, WORD_T, int)
M3WRAP6(ADDRESS, mmap, ADDRESS, WORD_T, int, int, int, m3_off_t)
M3WRAP2(int, munmap, ADDRESS, WORD_T)

#endif
