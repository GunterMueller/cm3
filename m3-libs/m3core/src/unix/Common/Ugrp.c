/* Copyright (C) 1994, Digital Equipment Corporation.         */
/* All rights reserved.                                       */
/* See the file COPYRIGHT for a full description.             */
/*                                                            */
/* Last modified on Wed Aug 17 14:25:29 PDT 1994 by kalsow    */
/*                                                            */
/* Originally submitted on Fri, 22 Jul 1994 16:42:53 GMT      */
/*   by jredford@lehman.com (John Redford)                    */

#include "m3core.h"

#ifndef _WIN32

#ifdef __cplusplus
extern "C"
{
#endif

struct _m3_group_t
/* This MUST match Ugrp.i3 */
{
    char** mem;
    char* name;
    m3_gid_t gid;
};

static m3_group_t* native_to_m3(const struct group* native, m3_group_t* m3)
{
    if (native == NULL)
        return NULL;
    m3->name = native->gr_name;
    m3->gid = native->gr_gid;
    m3->mem = native->gr_mem;
    return m3;
}

m3_group_t* Ugrp__getgrent(m3_group_t* m3group)
{
    return native_to_m3(getgrent(), m3group);
}

m3_group_t* Ugrp__getgrgid(m3_group_t* m3group, m3_gid_t gid)
{
    return native_to_m3(getgrgid(gid), m3group);
}

m3_group_t* Ugrp__getgrnam(m3_group_t* m3group, const char* name)
{
    return native_to_m3(getgrnam(name), m3group);
}

void Ugrp__setgrent(void)
{
    setgrent();
}

void Ugrp__endgrent(void)
{
    endgrent();
}

#ifdef __cplusplus
} /* extern C */
#endif

#endif
