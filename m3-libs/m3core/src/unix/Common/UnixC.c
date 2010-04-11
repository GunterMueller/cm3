/* Copyright (C) 1993, Digital Equipment Corporation                  */
/* All rights reserved.                                               */
/* See the file COPYRIGHT for a full description.                     */

/*
On some platforms, such as 32bit Linux and 32bit Solaris,
various functions are defined to have 32bit limits by default.
unless #define _FILE_OFFSET_BITS 64, which only affects C source.

Usually they are also available with the name ending in "64" as well.
    open => open64
    stat => stat64
    etc.

It might take a #define to expose those names to C.
(Just to help motivate why there are so many #defines.)

Therefore, saying, e.g.
<*EXTERNAL*> PROCEDURE ftruncate (fd: int; length: off_t): int;

is wrong, unless you constrain off_t to 32 bits, which is not good.

It would be correct to say:
<*EXTERNAL ftruncate64*> PROCEDURE ftruncate (fd: int; length: off_t): int;

However that is not portable.
So use these wrappers instead.
*/

#ifdef _MSC_VER
#undef _DLL
#ifndef _MT
#define _MT
#endif
#endif

#include "m3core.h"
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#ifdef _WIN32
#include <windows.h>
#endif
#define M3MODULE Unix

#ifdef __cplusplus
extern "C"
{
#endif

void __cdecl Unix__Assertions(void)
{
    /* make sure things are normal */
    M3_STATIC_ASSERT(CHAR_BIT == 8);
    M3_STATIC_ASSERT(sizeof(short) == 2);
    M3_STATIC_ASSERT(sizeof(int) == 4);
    M3_STATIC_ASSERT((sizeof(long) == 4) || (sizeof(long) == 8));
    M3_STATIC_ASSERT((sizeof(void*) == 4) || (sizeof(void*) == 8));
    M3_STATIC_ASSERT((sizeof(size_t) == 4) || (sizeof(size_t) == 8));
    M3_STATIC_ASSERT(sizeof(ptrdiff_t) == sizeof(size_t));
    M3_STATIC_ASSERT(sizeof(void*) == sizeof(size_t));
#ifndef _WIN64
    M3_STATIC_ASSERT(sizeof(void*) == sizeof(long));
    M3_STATIC_ASSERT(sizeof(size_t) == sizeof(long));
#endif

#ifdef _MSC_VER
    M3_STATIC_ASSERT(sizeof(__int64) == 8);
#else
    M3_STATIC_ASSERT(sizeof(long long) == 8);
#endif

#ifndef _WIN32

/* make sure all the Modula-3 types are large enough */

#define CHECK_M3_TYPE_SIZE(x) M3_STATIC_ASSERT(sizeof(m3_##x) >= sizeof(x))
#define IS_TYPE_SIGNED(x)  (((x)-1) < (x)0)

    CHECK_M3_TYPE_SIZE(dev_t);
    CHECK_M3_TYPE_SIZE(gid_t);
    CHECK_M3_TYPE_SIZE(ino_t);
    CHECK_M3_TYPE_SIZE(mode_t);
    CHECK_M3_TYPE_SIZE(nlink_t);
    CHECK_M3_TYPE_SIZE(off_t);
    CHECK_M3_TYPE_SIZE(pid_t);
    CHECK_M3_TYPE_SIZE(pthread_t);
    CHECK_M3_TYPE_SIZE(uid_t);

    M3_STATIC_ASSERT(IS_TYPE_SIGNED(pid_t));
#endif
    Utime__Assertions();
    Usocket__Assertions();
}

M3WRAP3_(int, open, const char*, int, m3_mode_t)
M3WRAP1_(m3_mode_t, umask, m3_mode_t)
M3WRAP2_(int, chmod, const char*, m3_mode_t)
M3WRAP2_(int, creat, const char*, m3_mode_t)
M3WRAP1_(int, dup, int)
M3WRAP1(int, system, const char*)
M3WRAP1_(int, isatty, int)
M3WRAP2(int, rename, const char*, const char*)
M3WRAP1_(int, rmdir, const char*)
M3WRAP1_(int, unlink, const char*)
M3WRAP2_(int, access, const char*, int)
M3WRAP1_(int, chdir, const char*)
M3WRAP1_(int, close, int)
M3WRAP2_(int, dup2, int, int)

#ifdef __sun
M3WRAP1(m3_off_t, tell, int)
#endif

#ifndef _WIN32
M3WRAP2(int, fchmod, int, m3_mode_t)
M3WRAP3(int, chown, const char*, m3_uid_t, m3_gid_t)
M3WRAP3(int, fchown, int, m3_uid_t, m3_gid_t)
M3WRAP2(int, truncate, const char*, m3_off_t)
M3WRAP2(int, ftruncate, int, m3_off_t)
M3WRAP3(INTEGER, readlink, const char*, char*, INTEGER)
M3WRAP2(int, symlink, const char*, const char*)
M3WRAP1(int, fsync, int)
M3WRAP0(int, getdtablesize)
M3WRAP0(int, getpagesize)
M3WRAP1(void*, sbrk, INTEGER)
M3WRAP3(int, execve, const char*, char**, char**)
M3WRAP1(unsigned, sleep, unsigned)
M3WRAP3(int, mknod, const char*, m3_mode_t, m3_dev_t)
M3WRAP3(m3_off_t, lseek, int, m3_off_t, int)
M3WRAP2(int, mkdir, const char*, m3_mode_t)
M3WRAP1(int, pipe, int*)
M3WRAP2(int, gethostname, char*, size_t)
M3WRAP2(char*, getcwd, char*, size_t)

m3_pid_t __cdecl Unix__fork(void)
{
#ifdef __sun
    /* Prior to Solaris 2.10, fork() was fork1() or forkall() depending
     * on which library used. In Solaris 2.10, fork() is always fork1(),
     * and a separate forkall() is available. fork1()'s declaration
     * does have some #ifdef guards around it; hopefully ok.
     */
    return fork1();
#else
    return fork();
#endif
}
#endif

void __cdecl Unix__underscore_exit(int exit_code)
{
    _exit(exit_code);
}

void __cdecl Unix__exit(int i)
{
    exit(i);
}

#ifdef _WIN32

#if 0
char* __cdecl Unix__getcwd(char* name, size_t len)
{
    assert(len < INT_MAX);
    return _getcwd(name, (int)len);
}

int __cdecl Unix__gethostname(char* name, size_t len)
{
    assert(len < INT_MAX);
    return gethostname(name, (int)len);
}
#endif

int __cdecl Unix__mkdir(const char* path, m3_mode_t mode)
{
    return _mkdir(path);
}

int __cdecl Unix__pipe(int* files)
{
    return _pipe(files, 0, _O_BINARY);
}

#if _MSC_VER >= 1000

m3_off_t __cdecl Unix__lseek(int fd, m3_off_t offset, int whence)
{
    return _lseeki64(fd, offset, whence);
}

m3_off_t __cdecl Unix__tell(int fd)
{
    return _telli64(fd);
}

#endif

#else

int __cdecl Unix__fcntl(int fd, int request, int arg)
/* fcntl is actually fcntl(fd, request, ...).
 * Wrapper is needed on some systems to handle varargs.
 * See http://edoofus.blogspot.com/2008/08/interesting-bug-unbreaking-cvsupamd64.html.
 */
{
#ifdef __sun
/*
 * This is to work around a bug in the Solaris-2 'libsocket' library 
 * which redefines 'fcntl' in such a way as to zero out 'errno' if the
 * call is successful.
 * See m3-libs/m3core/src/unix/solaris-2-x/Unix.m3.
 */
    int e = errno;
    int r = fcntl(fd, request, arg);
    if (r == 0)
        errno = e;
    return r;
#else
    return fcntl(fd, request, arg);
#endif
}

int __cdecl Unix__ioctl(int fd, int request, void* argp)
/* ioctl is varargs. See fcntl. */
{
#ifdef __sun
/*
 * This is to work around a bug in the Solaris-2 'libsocket' library 
 * which redefines 'ioctl' in such a way as to zero out 'errno' if the
 * call is successful.
 * See m3-libs/m3core/src/unix/solaris-2-x/Unix.m3.
 */
    int e = errno;
    int r = ioctl(fd, request, argp);
    if (r == 0)
        errno = e;
    return r;
#else
    return ioctl(fd, request, argp);
#endif
}

#endif

#ifdef __cplusplus
} /* extern C */
#endif
