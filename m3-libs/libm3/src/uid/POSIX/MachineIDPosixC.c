/* Copyright (C) 1993, Digital Equipment Corporation           */
/* All rights reserved.                                        */
/* See the file COPYRIGHT for a full description.              */
/*                                                             */
/* Last modified on Mon Sep 20 11:46:17 PDT 1993 by kalsow     */
/*      modified on Thu Jul 15 16:23:08 PDT 1993 by swart      */

#include <unistd.h>
#include <netdb.h>
#include <string.h>

#if defined(__linux__) || defined(__osf__) || defined(__CYGWIN__)

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>

#endif

#ifdef __cplusplus
extern "C" {
#endif

int MachineID__CanGet(char *id)
{
    int i;
    char hostname[128];
    struct hostent *hostent;

#if defined(__linux__) || defined(__osf__) || defined(__CYGWIN__)

    struct ifreq req;
    struct ifconf list;
    int s;
    struct ifreq buf[10];

    /* try to find an ethernet hardware address */
    s = socket(PF_UNIX, SOCK_STREAM, AF_UNSPEC);
    if (s >= 0)
    {
        list.ifc_len = sizeof buf;
        list.ifc_req = buf;

        if (ioctl(s, SIOCGIFCONF, &list) >= 0)
        {
            for (i = 0; i < list.ifc_len / sizeof(struct ifreq); i++)
            {
                strncpy(req.ifr_name, buf[i].ifr_name, IFNAMSIZ);
#if defined(__linux__) || defined(__CYGWIN__)
                if (ioctl(s, SIOCGIFHWADDR, &req) < 0)
                    continue;
                memcpy(id, req.ifr_hwaddr.sa_data, 6);
#elif defined(__osf__)
                if (ioctl(s, SIOCRPHYSADDR, &req) < 0)
                    continue;
                memcpy(id, req.default_pa, 6);
#endif
                close(s);
                return 1;
            }
        }
        close(s);
    }
#endif

    memset(id, 0, 6);

    /* try using the machine's internet address */
    if (gethostname(hostname, 128) == 0)
    {
        hostent = gethostbyname(hostname);
        if (hostent && hostent->h_length == 4)
        {
            id[2] = hostent->h_addr[0];
            id[3] = hostent->h_addr[1];
            id[4] = hostent->h_addr[2];
            id[5] = hostent->h_addr[3];
            return 1;
        }
    }

    return 0;
}


#ifdef __cplusplus
} /* extern "C" */
#endif

#if 0 /* test code */

#include <stdio.h>

int main()
{
    unsigned char id[6];
    int i;
    
    i = MachineIDPosixC__CanGet((char*)id);
    printf("%d %02x%02x%02x%02x%02x%02x\n", i, id[0], id[1], id[2], id[3], id[4], id[5]);

    return 0;
}

#endif
