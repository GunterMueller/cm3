/* Copyright (C) 1990, Digital Equipment Corporation.         */
/* All rights reserved.                                       */
/* See the file COPYRIGHT for a full description.             */

#include <stddef.h>
#include <netdb.h>
typedef struct hostent hostent_t;

#ifdef __cplusplus
extern "C" {
#endif

/* This is an idealized version of hostent where
the types are the same across platforms. We copy
the native struct to this form to smooth out platform
differences. We  also sort by size to avoid padding
for alignment, and then by name.

"h_" prefix is omitted from the names in case they are macros. */

typedef struct m3_hostent_t {
    char** addr_list;
    char** aliases;
    const char* name;
    int addrtype; /* varies between int16_t and int32_t */
    int length;   /* varies between int16_t and int32_t */
} m3_hostent_t;

static m3_hostent_t*
native_to_m3(const hostent_t* native, m3_hostent_t* m3)
{
    if (native == NULL)
        return NULL;
    m3->name = native->h_name;
    m3->aliases = native->h_aliases;
    m3->addrtype = native->h_addrtype;
    m3->length = native->h_length;
    m3->addr_list = native->h_addr_list;
    return m3;
}

m3_hostent_t* Unetdb__gethostbyname(const char* name, m3_hostent_t* m3)
{
    return native_to_m3(gethostbyname(name), m3);
}

m3_hostent_t*
Unetdb__gethostbyaddr(const char* addr, int len, int type, m3_hostent_t* m3)
{
    return native_to_m3(gethostbyaddr(addr, len, type), m3);
}

#ifdef __cplusplus
}
#endif
