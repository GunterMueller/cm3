/* Copyright (C) 1989, Digital Equipment Corporation        */
/* All rights reserved.                                     */
/* See the file COPYRIGHT for a full description.           */

/*
Modula-3 Time.T is LONGREAL aka double counting seconds.
We use gettimeofday() which returns seconds and microseconds.
*/

#include "m3core.h"
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

#if 0

typedef double T;

#define Now Time__Now
#define FromUtime TimePosix__FromUtime
#define ToUtime TimePosix__ToUtime
#define ComputeGrain Time__ComputeGrain

#define MILLION (1000 * 1000)

struct timeval
__cdecl
ToUtime(T t)
{
    struct timeval tv;
    double n = { 0 };

    ZERO_MEMORY(tv); 
    timeout.tv_usec = modf(t, &n) * MILLION;
    timeout.tv_sec = n;
    return tv;
}

T
__cdecl
FromUtime(const struct timeval* tv)
{
    return ((T)tv->tv_sec) + ((T)tv->tv_usec) / (T)MILLION;
}

T
__cdecl
Now(void)
{
    struct timeval tv;
    int i = { 0 };

    ZERO_MEMORY(tv);
    i = gettimeofday(&tv, NULL);
    assert(i == 0);

    return FromUtime(&tv);
}

static
T
ComputeGrainOnce(void)
{
  /* Determine value of "Grain" experimentally.  Note that
     this will fail if this thread is descheduled for a tick during the
     loop below. Omitting volatile leads to the result is 0 on Cygwin if optimized. */
    volatile T t0 = Now();
    while (1)
    {
        volatile T t1 = Now();
        if (t1 != t0)
            return (t1 - t0);
    }
}

T
__cdecl
ComputeGrain(void)
{
/* I have seen the value vary so let's go for a
few times in a row instead of just one or two.
Doing four checks always hangs on Cygwin, odd. */
    while (1)
    {
        T a = ComputeGrainOnce();
        T b = ComputeGrainOnce();
        T c = ComputeGrainOnce();
        if (a == b && a == c)
            return a;
    }
}

#endif

#ifdef __cplusplus
} /* extern C */
#endif

#if 0

int main()
{
    T grain = ComputeGrain();

    printf("%f\n", grain);

    return 0;
}

#endif
