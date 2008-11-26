#include <stdio.h>
#include <errno.h>

int main()
{
    unsigned i;
    const static struct
    {
        const char* Format;
        unsigned Value;
    } Data[] =
{
"(* Copyright (C) 1990, Digital Equipment Corporation.         *)", 0,
"(* All rights reserved.                                       *)", 0,
"(* See the file COPYRIGHT for a full description.             *)", 0,
"", 0,
"(* This file was generated from " __FILE__ ". Do not edit it. *)", 0,
"", 0,
"INTERFACE Uerror;", 0,
"", 0,
"CONST", 0,
#define X(x) "  " #x " = %u;", x,
X(EACCES)
X(EADDRINUSE)
X(EADDRNOTAVAIL)
X(EAGAIN)
X(EALREADY)
X(EBADF)
X(ECHILD)
X(ECONNABORTED)
X(ECONNREFUSED)
X(ECONNRESET)
X(EDOM)
X(EEXIST)
X(EHOSTDOWN)
X(EHOSTUNREACH)
X(EINPROGRESS)
X(EINTR)
X(EINVAL)
X(EIO)
X(EISCONN)
X(EISDIR)
X(EMFILE)
X(ENAMETOOLONG)
X(ENETDOWN)
X(ENETRESET)
X(ENETUNREACH)
X(ENFILE)
X(ENOENT)
X(ENOEXEC)
X(ENOMEM)
X(ENOTEMPTY)
X(ENOTSOCK)
X(EPERM)
X(EPIPE)
X(ERANGE)
X(ETIMEDOUT)
"  EWOULDBLOCK = EAGAIN;", 0,
"", 0,
"END Uerror.", 0
};
    for (i = 0 ; i != sizeof(Data)/sizeof(Data[0]) ; ++i)
    {
        printf(Data[i].Format, Data[i].Value);
        printf("\n");
    }
    return 0;
}
