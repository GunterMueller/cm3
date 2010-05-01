#if _MSC_VER > 1000
#pragma once
#endif

#define _FILE_OFFSET_BITS 64

#ifndef INCLUDED_M3CORE_H
#define INCLUDED_M3CORE_H

#ifdef __INTERIX
#ifndef _ALL_SOURCE
#define _ALL_SOURCE
#endif
#endif

#ifndef _REENTRANT
#define _REENTRANT
#endif

#ifdef __vms
/* Enable support for files larger than 2GB. */
#ifdef _LARGEFILE
#define _LARGEFILE
#endif
/* Enable 32bit gids and reveal setreuids. */
#ifndef __USE_LONG_GID_T
#define __USE_LONG_GID_T 1
#endif
/* st_ino has three forms that all fit in the
 * same space; pick the one we want.
 */
#ifndef __USE_INO64
#define __USE_INO64 1
#endif
#endif

#if defined(__arm__) && defined(__APPLE__)
/* Reveal the correct struct stat? */
#ifndef _DARWIN_FEATURE_64_ONLY_BIT_INODE
#define _DARWIN_FEATURE_64_ONLY_BIT_INODE
#endif
#endif

#ifdef _MSC_VER
#define _CRT_SECURE_NO_DEPRECATE
#define _CRT_NONSTDC_NO_DEPRECATE
#pragma warning(disable:4616) /* there is no warning x (unavoidable if targeting multiple compiler versions) */
#pragma warning(disable:4619) /* there is no warning x (unavoidable if targeting multiple compiler versions) */
#pragma warning(disable:4115) /* named type definition in parentheses */
#pragma warning(disable:4100) /* unused parameter */
#pragma warning(disable:4201) /* nonstandard extension: nameless struct/union */
#pragma warning(disable:4214) /* nonstandard extension: bitfield other than int */
#pragma warning(disable:4514) /* unused inline function removed */
#pragma warning(disable:4705) /* statement has no effect for merely using assert() at -W4 */
#pragma warning(disable:4209) /* nonstandard extension: benign re-typedef */
#pragma warning(disable:4226) /* nonstandard extension: __export */
#pragma warning(disable:4820) /* padding inserted */
#pragma warning(disable:4255) /* () change to (void) */
#pragma warning(disable:4668) /* #if of undefined symbol */
#endif

#ifdef __OpenBSD__
#define ucontext_t openbsd_ucontext_t
#endif

#if !defined(_MSC_VER) && !defined(__cdecl)
#define __cdecl /* nothing */
#endif

#ifdef __cplusplus
#define M3EXTERNC_BEGIN extern "C" {
#define M3EXTERNC_END }
#else
#define M3EXTERNC_BEGIN
#define M3EXTERNC_END
#endif

#define M3WRAPNAMEx(a, b) a##__##b
#define M3WRAPNAME(a, b) M3WRAPNAMEx(a, b)
#define M3WRAP(ret, name, in, out)     M3EXTERNC_BEGIN ret __cdecl M3WRAPNAME(M3MODULE, name) in { return name out; } M3EXTERNC_END
#ifdef _WIN32
#define M3WRAP_(ret, name, in, out)    M3EXTERNC_BEGIN ret __cdecl M3WRAPNAME(M3MODULE, name) in { return _##name out; } M3EXTERNC_END
#else
#define M3WRAP_(ret, name, in, out)    M3WRAP(ret, name, in, out)
#endif
#define M3WRAP0(ret, name)             M3WRAP(ret, name, (void),               ())
#define M3WRAP1(ret, name, a)          M3WRAP(ret, name, (a i),                (i))
#define M3WRAP2(ret, name, a, b)       M3WRAP(ret, name, (a i, b j),           (i, j))
#define M3WRAP3(ret, name, a, b, c)    M3WRAP(ret, name, (a i, b j, c k),      (i, j, k))
#define M3WRAP4(ret, name, a, b, c, d) M3WRAP(ret, name, (a i, b j, c k, d m), (i, j, k, m))
#define M3WRAP5(ret, name, a, b, c, d, e) M3WRAP(ret, name, (a i, b j, c k, d m, e n), (i, j, k, m, n))
#define M3WRAP6(ret, name, a, b, c, d, e, f) M3WRAP(ret, name, (a i, b j, c k, d m, e n, f o), (i, j, k, m, n, o))

#define M3WRAP0_(ret, name)           M3WRAP_(ret, name, (void),               ())
#define M3WRAP1_(ret, name, a)        M3WRAP_(ret, name, (a i),                (i))
#define M3WRAP2_(ret, name, a, b)     M3WRAP_(ret, name, (a i, b j),           (i, j))
#define M3WRAP3_(ret, name, a, b, c)  M3WRAP_(ret, name, (a i, b j, c k),      (i, j, k))

#include <sys/types.h>
#include <sys/stat.h>
#include <assert.h>
#include <stddef.h>
#include <time.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#include <math.h>

#ifdef _WIN32
#ifndef WIN32
#define WIN32
#endif
#include <direct.h>
#include <io.h>
#include <winsock.h>
#include <process.h>
typedef ptrdiff_t ssize_t;
#else
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <dirent.h>
#include <grp.h>
#include <netdb.h>
#include <pthread.h>
#include <unistd.h>
#include <pwd.h>
#define ZeroMemory(a,b) (memset((a), 0, (b)))
#endif

#define ZERO_MEMORY(a) (ZeroMemory(&(a), sizeof(a)))

#ifdef __INTERIX
#include <utime.h>
#endif

#ifdef __OpenBSD__
#undef ucontext_t
#endif

typedef   signed char       INT8;
typedef unsigned char      UINT8;
typedef   signed short      INT16;
typedef unsigned short     UINT16;
typedef   signed int        INT32;
typedef unsigned int       UINT32;
#if defined(_MSC_VER) || defined(__DECC)
typedef   signed __int64  INT64;
typedef unsigned __int64 UINT64;
#else
typedef   signed long long  INT64;
typedef unsigned long long UINT64;
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* INTEGER is always signed and exactly the same size as a pointer */
#if __INITIAL_POINTER_SIZE == 64
/* VMS with 64 bit pointers but 32bit size_t/ptrdiff_t. */
typedef __int64 INTEGER;
typedef unsigned __int64 WORD_T;
#else
typedef ptrdiff_t INTEGER;
typedef size_t WORD_T;
#endif

/* LONGINT is always signed and exactly 64 bits. */
typedef INT64 LONGINT;

typedef void* ADDRESS;

/* see Utypes.i3; we assert that these are large enough, they don't have
be exactly correctly sizes, and often are not */
typedef LONGINT m3_dev_t;
typedef INTEGER m3_gid_t;
typedef LONGINT m3_ino_t;
typedef INTEGER m3_mode_t;
typedef LONGINT m3_nlink_t;
typedef INTEGER m3_pid_t;
typedef ADDRESS m3_pthread_t;
typedef LONGINT m3_off_t;
typedef INTEGER m3_uid_t;

/*
 m3_pthread_t is void*.
 pthread_t might be any of: size_t, ptrdiff_t, int, void*, another pointer.
 pthread_t will not be larger than a pointer/size_t. (see Unix__Assertions)
 Only convert integers to/from integers, and pointer-sized integers to/from pointers.
 That is, for example, do NOT convert int <=> pointer.
 */
#define PTHREAD_TO_M3(x)   ((m3_pthread_t)(WORD_T)(x))
#define PTHREAD_FROM_M3(x) ((pthread_t)(WORD_T)(x))

#if defined(__APPLE__) || defined(__FreeBSD__) || defined(__NetBSD__) || defined(__OpenBSD__)
#define HAS_STAT_FLAGS
#endif

struct _m3_stat_t;
typedef struct _m3_stat_t m3_stat_t;

int __cdecl Ustat__fstat(int fd, m3_stat_t* m3st);
int __cdecl Ustat__lstat(const char* path, m3_stat_t* m3st);
int __cdecl Ustat__stat(const char* path, m3_stat_t* m3st);
#ifdef HAS_STAT_FLAGS
int __cdecl Ustat__fchflags(int fd, unsigned long flags);
int __cdecl Ustat__chflags(const char* path, unsigned long flags);
#endif

/*
socklen_t
cygwin:
    signed 32 bit
hpux:
    size_t
    therefore:
    hpux32:
        unsigned 32 bit
    hpux64:
        unsigned 64 bit, but again, size_t
everyone else:
    unsigned 32 bit

The values involved are all small positive values, and
we convert carefully.
*/
#if defined(__INTERIX) || (defined(__vms) && defined(_DECC_V4_SOURCE))
typedef int socklen_t;
#elif defined(__vms)
typedef size_t socklen_t;
#endif
typedef WORD_T m3_socklen_t;

typedef struct {
/* verified to exactly match struct linger in UnixC.c, except for Cygwin */
    int onoff;
    int linger;
} m3_linger_t;

int __cdecl Usocket__listen(int s, int backlog);
int __cdecl Usocket__shutdown(int s, int how);
int __cdecl Usocket__socket(int af, int type, int protocol);
int __cdecl Usocket__bind(int s, struct sockaddr* name, m3_socklen_t len);
int __cdecl Usocket__connect(int s, struct sockaddr* name, m3_socklen_t len);
INTEGER __cdecl Usocket__sendto(int s, void* msg, WORD_T length, int flags, struct sockaddr* dest, m3_socklen_t len);
int __cdecl Usocket__setsockopt(int s, int level, int optname, void* optval, m3_socklen_t len);
int __cdecl Usocket__getpeername(int s, struct sockaddr* name, m3_socklen_t* plen);
int __cdecl Usocket__getsockname(int s, struct sockaddr* name, m3_socklen_t* plen);
int __cdecl Usocket__accept(int s, struct sockaddr* addr, m3_socklen_t* plen);
int __cdecl Usocket__getsockopt(int s, int level, int optname, void* optval, m3_socklen_t* plen);
INTEGER __cdecl Usocket__recvfrom(int s, void* buf, WORD_T len, int flags, struct sockaddr* from, m3_socklen_t* plen);

#ifndef _WIN32
DIR* __cdecl Udir__opendir(const char* a);
#endif

int __cdecl Umman__mprotect(ADDRESS addr, WORD_T len, int prot);
ADDRESS __cdecl Umman__mmap(ADDRESS addr, WORD_T len, int prot, int flags, int fd, m3_off_t off);
int __cdecl Umman__munmap(ADDRESS addr, WORD_T len);

typedef INT64 m3_time_t;

#ifndef _WIN32
m3_time_t __cdecl Utime__time(m3_time_t* tloc);
char* __cdecl Utime__ctime(const m3_time_t* m);
#endif
void __cdecl Utime__tzset(void);


/* Some compilers don't like this, will adjust as needed. */
#if 1
#define M3PASTE_(a, b) a ## b
#define M3PASTE(a, b) M3PASTE_(a, b)
#define M3_STATIC_ASSERT(expr) typedef char M3PASTE(m3_static_assert, __LINE__)[(expr)?1:-1]
#else
#define M3_STATIC_ASSERT(expr) assert(expr)
#endif

#define M3_FIELD_SIZE(type, field) (sizeof((type*)0)->field)
#define M3_SIZE_THROUGH_FIELD(type, field) (offsetof(type, field) + M3_FIELD_SIZE(type, field))

void __cdecl Unix__Assertions(void);
void __cdecl Usocket__Assertions(void);


int __cdecl Unix__open(const char* path, int flags, m3_mode_t mode);
int __cdecl Unix__mkdir(const char* path, m3_mode_t mode);
int __cdecl Unix__ftruncate(int fd, m3_off_t length);
m3_off_t __cdecl Unix__lseek(int fd, m3_off_t offset, int whence);
m3_off_t __cdecl Unix__tell(int fd);
int __cdecl Unix__fcntl(int fd, int request, int arg);
int __cdecl Unix__ioctl(int fd, int request, void* argp);
int __cdecl Unix__mknod(const char* path, m3_mode_t mode, m3_dev_t dev);
m3_mode_t __cdecl Unix__umask(m3_mode_t newmask);

struct _m3_hostent_t;
typedef struct _m3_hostent_t m3_hostent_t;

m3_hostent_t* __cdecl Unetdb__gethostbyname(const char* name, m3_hostent_t* m3);
m3_hostent_t* __cdecl Unetdb__gethostbyaddr(const char* addr, int len, int type, m3_hostent_t* m3);


struct _m3_group_t;
typedef struct _m3_group_t m3_group_t;

m3_group_t* __cdecl Ugrp__getgrent(m3_group_t* m3group);
m3_group_t* __cdecl Ugrp__getgrgid(m3_group_t* m3group, m3_gid_t gid);
m3_group_t* __cdecl Ugrp__getgrnam(m3_group_t* m3group, const char* name);
void __cdecl Ugrp__setgrent(void);
void __cdecl Ugrp__endgrent(void);


int __cdecl Unix__link(const char* name1, const char* name2);
int __cdecl Unix__chmod(const char* path, m3_mode_t mode);
int __cdecl Unix__fchmod(int fd, m3_mode_t mode);
int __cdecl Unix__chown(const char* path, m3_uid_t owner, m3_gid_t group);
int __cdecl Unix__fchown(int fd, m3_uid_t owner, m3_gid_t group);
int __cdecl Unix__creat(const char* path, m3_mode_t mode);
int __cdecl Unix__dup(int oldd);

UINT32 __cdecl Uin__ntohl(UINT32 x);
UINT16 __cdecl Uin__ntohs(UINT16 x);
UINT32 __cdecl Uin__htonl(UINT32 x);
UINT16 __cdecl Uin__htons(UINT16 x);

typedef double LONGREAL;
typedef void* TEXT;

const char*
__cdecl
M3toC__SharedTtoS(TEXT);

void
__cdecl
M3toC__FreeSharedS(TEXT, const char*);

TEXT
__cdecl
M3toC__CopyStoT(const char*);

/* This MUST match DatePosix.i3.T.
 * The fields are ordered by size and alphabetically.
 * (They are all the same size.)
 */
typedef struct {
    INTEGER day;
    INTEGER hour;
    INTEGER minute;
    INTEGER month;
    INTEGER offset;
    INTEGER second;
    INTEGER weekDay;
    INTEGER year;
    TEXT    zone;
    INTEGER zzalign;
} Date_t;

void
__cdecl
DatePosix__FromTime(double t, const INTEGER* zone, Date_t* date, TEXT unknown, TEXT gmt);

double
__cdecl
DatePosix__ToTime(const Date_t* date);

void
__cdecl
DatePosix__TypeCheck(const Date_t* d, WORD_T sizeof_DateT);

void
__cdecl
Scheduler__DisableScheduling(void);

void
__cdecl
Scheduler__EnableScheduling(void);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif
