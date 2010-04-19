/* Copyright (C) 1993, Digital Equipment Corporation           */
/* All rights reserved.                                        */
/* See the file COPYRIGHT for a full description.              */
/*                                                             */
/* Last modified on Mon Sep 20 11:46:17 PDT 1993 by kalsow     */
/*      modified on Thu Jul 15 16:23:08 PDT 1993 by swart      */

#include "m3core.h"
#include <unistd.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#ifdef __sun
#include <sys/sockio.h>
#endif
#ifndef __CYGWIN__
#include <net/if.h>
#include <net/if_arp.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(__aix) \
 || defined(__hpux) \
 || defined(__INTERIX) \
 || defined(__irix) \
 || defined(__osf__) \
 || defined(__sgi) \
 || defined(__vms)
/* osf might already work */
#error Please test/port this.
#endif

#if !(defined(__APPLE__)    \
   || defined(__CYGWIN__)   \
   || defined(__FreeBSD__)  \
   || defined(__linux__)    \
   || defined(__NetBSD__)   \
   || defined(__OpenBSD__)  \
   || defined(__sun))
#error Please test/port this.
#endif

#ifdef __sun
/* need works but keep the old version */
#endif

#if defined(__OpenBSD__) || defined(__NetBSD__) || defined(__FreeBSD__) || defined(__APPLE__)
#define HAS_GETIFADDRS
#endif

#ifdef HAS_GETIFADDRS
#include <net/if_dl.h>
#include <ifaddrs.h>
#endif

#ifdef __APPLE__
#ifndef _SIZEOF_ADDR_IFREQ
#error Apple => _SIZEOF_ADDR_IFREQ
#endif
#else
#ifdef _SIZEOF_ADDR_IFREQ
#error !Apple => !_SIZEOF_ADDR_IFREQ
#endif
#define _SIZEOF_ADDR_IFREQ(a) (sizeof(a))
#endif

#ifdef __cplusplus
extern "C" {
#endif

static
char
ToPrintable(unsigned char a)
{
    if (a >= 32 && a < 127)
        return a;
    return '.';
}

static
void
dump(void* a, size_t n)
{
    char buffer[256];
    unsigned char* b = (unsigned char*)a;
    size_t i;
    size_t j;
    size_t k = 0;
    const static char hex[] = "0123456789ABCDEF";

    for (i = 0; i < n; ++i)
    {
        buffer[k++] = hex[b[i] >> 4];
        buffer[k++] = hex[b[i] & 0xF];
        buffer[k++] = ' ';
        if (((i + 1) % 8) == 0)
            buffer[k++] = ' ';
        if (((i + 1) % 16) == 0)
        {
            for (j = i - 15; j <= i; ++j)
            {
                buffer[k++] = ToPrintable(b[j]);
                if (((j + 1) % 8) == 0)
                    buffer[k++] = ' ';
            }
            buffer[k++] = '\n';
            buffer[k++] = 0;
            printf("%s", buffer);
            k = 0;
        }
    }
}

static
UINT32
get_ipv4_address(void)
{
    char hostname[256];

    if (gethostname(hostname, sizeof(hostname)) == 0)
    {
        struct hostent* hostent = gethostbyname(hostname);
        if (hostent && hostent->h_length == 4)
        {
            return *(UINT32*)hostent->h_addr;
        }
    }
    return 0;
}

int/*boolean*/
__cdecl
MachineIDPosixC__CanGet(unsigned char *id)
{
    int result = { 0 };
    int sock = { 0 };
#ifdef HAS_GETIFADDRS
    struct ifaddrs* if1 = { 0 };
    struct ifaddrs* if2 = { 0 };
#elif defined(__linux__) || defined(__osf__) || defined(__CYGWIN__)
    union {
        struct ifreq req[64];
        unsigned char b[4096];
    } buf;
    struct ifconf list;
    struct ifreq* req1 = { 0 };
    size_t i = { 0 };
    struct ifreq req2;
    ZeroMemory(&list, sizeof(list));
    ZeroMemory(&req2, sizeof(req2));
#endif

    ZeroMemory(id, 6);

    /* try to find an ethernet hardware address */
#ifdef __sun
    sock = socket(AF_INET, SOCK_DGRAM, 0);
#else
    sock = socket(PF_UNIX, SOCK_STREAM, AF_UNSPEC);
#endif
    if (sock >= 0)
    {
#ifdef HAS_GETIFADDRS
        if (getifaddrs(&if1) == 0)
        {
            for (if2 = if1; (!result) && if2; if2 = if2->ifa_next)
            {
                if (((if2->ifa_flags & IFF_LOOPBACK) == 0) && (if2->ifa_addr->sa_family == AF_LINK))
                {
                    struct sockaddr_dl* dl = (struct sockaddr_dl*)if2->ifa_addr;
                    unsigned char* mac = (unsigned char*)LLADDR(dl);
                    if (dl->sdl_alen == 6) /* 48 bits */
                    {
                        memcpy(id, mac, 6);
                        result = 1;
                    }
                }
            }
            freeifaddrs(if1);
        }
        else
        {
            perror("getifaddrs");
        }
#elif defined(__linux__) || defined(__CYGWIN__) || defined(__osf__)
        list.ifc_len = sizeof(buf);
        list.ifc_req = (struct ifreq*)&buf;
        if (ioctl(sock, SIOCGIFCONF, &list) >= 0)
        {
            for (i = 0; (!result) && (i < list.ifc_len); i += _SIZEOF_ADDR_IFREQ(*req1))
            {
                req1 = (struct ifreq*)&buf.b[i];
                memcpy(req2.ifr_name, req1->ifr_name, IFNAMSIZ);
                if (ioctl(sock, SIOCGIFFLAGS, &req2) < 0)
                {
                    perror("ioctl SIOCGIFFLAGS");
                    continue;
                }
                if ((req2.ifr_flags & IFF_LOOPBACK) != 0)
                    continue;
                memcpy(req2.ifr_name, req1->ifr_name, IFNAMSIZ);
#if defined(__linux__) || defined(__CYGWIN__)
                if (ioctl(sock, SIOCGIFHWADDR, &req2) < 0)
                {
                    perror("ioctl SIOCGIFHWADDR");
                    continue;
                }
                memcpy(id, req2.ifr_hwaddr.sa_data, 6);
#elif defined(__osf__)
                if (ioctl(sock, SIOCRPHYSADDR, &req2) < 0)
                {
                    perror("ioctl SIOCRPHYSADDR");
                    continue;
                }
                memcpy(id, req2.default_pa, 6);
#else
#error unknown system
#endif
                result = 1;
            }
        }
        else
        {
            perror("ioctl SIOCGIFCONF");
        }
#elif defined(__sun)
        /* Use ARP on Solaris. */
        if (result == 0)
        {
            struct arpreq arp;
            struct sockaddr_in* in = (struct sockaddr_in*)&arp.arp_pa; /* protocol address */
            ZeroMemory(&arp, sizeof(arp));
            arp.arp_pa.sa_family = AF_INET;
            arp.arp_ha.sa_family = AF_UNSPEC;
            in->sin_addr.s_addr = get_ipv4_address();
            if (ioctl(sock, SIOCGARP, &arp) == -1)
            {
                perror("ioctl SIOCGARP");
            }
            else
            {
                memcpy(id, arp.arp_ha.sa_data, 6); /* hardware address */
                result = 1;
            }
        }
#else
#error unknown system
#endif
        close(sock);
    }
    else
    {
        perror("socket");
    }

    /* really lame fallback */
    if (result == 0)
    {
        union
        {
            UINT32 a;
            unsigned char b[4];
        } u;
        u.a = get_ipv4_address();
        memcpy(&id[2], u.b, 4);
        result = (u.a != 0);
    }

    return result;
}


#ifdef __cplusplus
} /* extern "C" */
#endif

#if 0 /* test code */

int main()
{
    unsigned char id[6] = { 0 };
    int i = { 0 };
    
    i = MachineIDPosixC__CanGet(id);
    printf("%d %02X-%02X-%02X-%02X-%02X-%02X\n", i, id[0], id[1], id[2], id[3], id[4], id[5]);
    printf("   %u.%u.%u.%u.%u.%u\n", id[0], id[1], id[2], id[3], id[4], id[5]);
#if defined(__sun)
    system("/usr/sbin/arp -a | grep L"); /* L for local */
#elif defined(__CYGWIN__)
    system("getmac");
#else
    system("/sbin/ifconfig -a | grep addr");
    system("/sbin/ifconfig -a | grep ether");
#endif
    return 0;
}

#endif
