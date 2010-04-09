/* Copyright (C) 1989, Digital Equipment Corporation           */
/* All rights reserved.                                        */
/* See the file COPYRIGHT for a full description.              */

#include "m3core.h"

#ifdef __cplusplus
extern "C" {
#endif

/* assert that *plen fits in a 32 bit signed integer, no matter
if it is unsigned or signed, or 32 bits or 64 bits */

#define ASSERT_PLEN \
    assert((plen == NULL) || (((*plen) >= 0) && ((*plen) < (m3_socklen_t)(1UL << 30))));

#define ASSERT_LEN \
    assert((len >= 0) && (len < (m3_socklen_t)(1UL << 30)));

void Usocket__Assertions(void)
{
#ifndef _WIN32
    /* assert that struct linger is literally { int l_onoff, l_linger },
    those types (or at least sizes), that order, no padding, except on Cygwin */
    
    typedef struct linger T;
    typedef m3_linger_t M;
    
    M3_STATIC_ASSERT(sizeof(M) == 8);
    M3_STATIC_ASSERT(offsetof(M, onoff) == 0);
    M3_STATIC_ASSERT(M3_FIELD_SIZE(M, onoff) == 4);
    M3_STATIC_ASSERT(offsetof(M, linger) == 4);
    M3_STATIC_ASSERT(M3_FIELD_SIZE(M, linger) == 4);
    M3_STATIC_ASSERT(sizeof(T) == (M3_FIELD_SIZE(T, l_onoff) + M3_FIELD_SIZE(T, l_linger)));
#ifndef __CYGWIN__
    M3_STATIC_ASSERT(sizeof(T) == 8);
    M3_STATIC_ASSERT(offsetof(T, l_onoff) == 0);
    M3_STATIC_ASSERT(M3_FIELD_SIZE(T, l_onoff) == 4);
    M3_STATIC_ASSERT(offsetof(T, l_linger) == 4);
    M3_STATIC_ASSERT(M3_FIELD_SIZE(T, l_linger) == 4);
#endif
#endif
}

#ifndef _WIN32

/* wrap everything */

#define M3MODULE Usocket
M3WRAP2(int, listen, int, int)
M3WRAP2(int, shutdown, int, int)
M3WRAP3(int, socket, int, int, int)

/* wrap everything taking input socklen_t */

int Usocket__bind(int s, struct sockaddr* name, m3_socklen_t len)
{
    ASSERT_LEN
    return bind(s, name, len);
}

int Usocket__connect(int s, struct sockaddr* name, m3_socklen_t len)
{
    ASSERT_LEN
    return connect(s, name, len);
}

int Usocket__sendto(int s, void* msg, size_t length, int flags, struct sockaddr* dest, m3_socklen_t len)
{
    ASSERT_LEN
    return sendto(s, msg, length, flags, dest, len);
}

int Usocket__setsockopt(int s, int level, int optname, void* optval, m3_socklen_t len)
{
    ASSERT_LEN
#ifdef __CYGWIN__
    if (optname == SO_LINGER && optval != NULL)
    {
        struct linger b;
        m3_linger_t* a = (m3_linger_t*)optval;
        assert(len == sizeof(*a));
        b.l_onoff = a->onoff;
        b.l_linger = a->linger;
        return setsockopt(s, level, optname, &b, sizeof(b));
    }
#endif
    return setsockopt(s, level, optname, optval, len);
}

/* wrap everything taking input/output socklen_t */

int Usocket__getpeername(int s, struct sockaddr* name, m3_socklen_t* plen)
{
    ASSERT_PLEN
    {
        socklen_t len = plen ? *plen : 0;
        int r = getpeername(s, name, plen ? &len : 0);
        if (plen) *plen = len;
        return r;
    }
}

int Usocket__getsockname(int s, struct sockaddr* name, m3_socklen_t* plen)
{
    ASSERT_PLEN
    {
        socklen_t len = plen ? *plen : 0;
        int r = getsockname(s, name, plen ? &len : 0);
        if (plen) *plen = len;
        return r;
    }
}

int Usocket__accept(int s, struct sockaddr* addr, m3_socklen_t* plen)
{
    ASSERT_PLEN
    {
        socklen_t len = plen ? *plen : 0;
        int r = accept(s, addr, plen ? &len : 0);
        if (plen) *plen = len;
        return r;
    }
}

int Usocket__getsockopt(int s, int level, int optname, void* optval, m3_socklen_t* plen)
/*
Posix says l_onoff and l_linger are int, but they aren't on Cygwin.
As usual Posix does not mandate the order of the fields or that there aren't
all fields, but all known implementations have no additional fields and use
the same order. This is checked in Usocket__Assertions.
*/
{
    ASSERT_PLEN
    {
        int r;
        socklen_t len = plen ? *plen : 0;

#ifdef __CYGWIN__
        m3_linger_t* a = { 0 };
        struct linger b;

        if (optname == SO_LINGER && optval != NULL)
        {
            assert(plen);
            assert(len == sizeof(*a));
            a = (m3_linger_t*)optval;
            optval = &b;
            ZeroMemory(&b, sizeof(b));
            ZeroMemory(a, sizeof(*a));
            len = sizeof(b);
        }
#endif

        r = getsockopt(s, level, optname, optval, plen ? &len : 0);
        if (plen) *plen = len;

#ifdef __CYGWIN__
        if (a)
        {
            assert(len == sizeof(b));
            *plen = sizeof(*a);
            a->onoff = b.l_onoff;
            a->linger = b.l_linger;
        }
#endif
        return r;
    }
}

int Usocket__recvfrom(int s, void* buf, size_t length, int flags, struct sockaddr* address, m3_socklen_t* plen)
{
    ASSERT_PLEN
    {
        socklen_t len = plen ? *plen : 0;
        int r = recvfrom(s, buf, length, flags, address, plen ? &len : 0);
        if (plen) *plen = len;
        return r;
    }
}

#endif

#ifdef __cplusplus
} /* extern "C" */
#endif
