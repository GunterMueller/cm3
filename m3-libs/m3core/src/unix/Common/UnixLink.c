/* Copyright (C) 1993, Digital Equipment Corporation                  */
/* All rights reserved.                                               */
/* See the file COPYRIGHT for a full description.                     */

#include "m3core.h"
#ifdef _WIN32
#include <windows.h>
#endif

#if __GNUC__ >= 4
#ifdef __APPLE__
#pragma GCC visibility push(default)
#else
#pragma GCC visibility push(protected)
#endif
#endif

#ifdef __cplusplus
extern "C"
{
#endif

M3_DLL_EXPORT int __cdecl
Unix__link(const char* ExistingFile, const char* NewLink)
{
#ifdef _WIN32
#ifdef _WIN64
    if (CreateHardLinkA(NewLink, ExistingFile, NULL) == FALSE)
        goto Error;
#else
    typedef BOOL (__stdcall * PFNCreateHardLinkA)(PCSTR NewLink, PCSTR ExistingFile, void* reserved);
    static FARPROC pfnCreateHardLinkA;
    
    if (pfnCreateHardLinkA == NULL)
    {
        const static WCHAR Kernel32Name[] = L"Kernel32.dll";
        HMODULE Kernel32Handle = LoadLibraryW(Kernel32Name);
        if (Kernel32Handle == NULL)
            goto Error;
        pfnCreateHardLinkA = GetProcAddress(Kernel32Handle, "CreateHardLinkA");
        if (pfnCreateHardLinkA == NULL)
            goto Error;
    }
    if ((*(PFNCreateHardLinkA*)&pfnCreateHardLinkA)(NewLink, ExistingFile, NULL) == FALSE)
        goto Error;
#endif
    return 0;
Error:
    errno = (int)GetLastError();
    return -1;
#else
    return link(ExistingFile, NewLink);
#endif
}

#ifdef __cplusplus
} /* extern C */
#endif
