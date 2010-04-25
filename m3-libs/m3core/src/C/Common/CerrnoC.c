/*
 * Helper functions for accessing standard C's "errno" value.
 */

#ifdef _MSC_VER
#pragma optimize("gty", on)
#undef _DLL
#define _MT
#endif

#if !defined(_MSC_VER) && !defined(__cdecl)
#define __cdecl /* nothing */
#endif

#if defined(__INTERIX) && !defined(_REENTRANT)
#define _REENTRANT
#endif

#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif

int
__cdecl
Cerrno__GetErrno(void)
{
    return errno;
}

void
__cdecl
Cerrno__SetErrno(int e)
{
    errno = e;
}

#ifdef __cplusplus
}
#endif
