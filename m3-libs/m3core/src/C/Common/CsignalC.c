/* Copyright (C) 1992, Digital Equipment Corporation                         */
/* All rights reserved.                                                      */
/* See the file COPYRIGHT for a full description.                            */

#include "m3core.h"

#ifdef _MSC_VER
#pragma optimize("gty", on)
#endif

#define M3MODULE Csignal

typedef void (__cdecl*SignalHandler)(int s);

M3WRAP2(SignalHandler, signal, int, SignalHandler)
