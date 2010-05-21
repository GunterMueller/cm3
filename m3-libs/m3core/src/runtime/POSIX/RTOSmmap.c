#include "m3core.h"
#include <sys/mman.h>

#ifdef __cplusplus
extern "C" {
#endif

#if !defined(MAP_ANON) && defined(MAP_ANONYMOUS)
#define MAP_ANON MAP_ANONYMOUS
#endif

void* RTOS__GetMemory(WORD_T size)
{
    return mmap(0, size, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
}

#ifdef __cplusplus
} /* extern "C" */
#endif
