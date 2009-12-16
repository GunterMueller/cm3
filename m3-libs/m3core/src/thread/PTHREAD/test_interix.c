
#if defined(__INTERIX) && !defined(_ALL_SOURCE)
#define _ALL_SOURCE
#endif
#include <stdio.h>
#include <sys/procfs.h>
#include <fcntl.h>
#include <assert.h>
#include <errno.h>

void* thread1(void*a)
{
    int b;
    printf("thread %ld stack %p\n", pthread_self(), &b);
    while (1)
    {
        for (b = 0; b < (int)(size_t)a; ++b)
        {
        }
    }
    return 0;
}

int main()
{  
    long pid = getpid();
    long t[3]; /* thread */
    char p[255]; /* path */
    int status[3];
    int ctl[3]; /* control */
    int i;
    int j;
    const static PROC_CTL_WORD_TYPE set_async[] = { PCSET, PR_ASYNC };
    const static PROC_CTL_WORD_TYPE stop[] = { PCSTOP };
    const static PROC_CTL_WORD_TYPE run[] = { PCRUN, 0 };
    lwpstatus_t lwpstatus[3];
    off_t off;

    memset(&lwpstatus, 0, sizeof(lwpstatus));

    printf("pid:%ld\n", pid);

    for (i = 0; i < 3; ++i)
    {
        pthread_create(&t[i], NULL, thread1, (void*)(size_t)(0x10 << (4 * i)));
        sprintf(p, "/proc/%ld/lwp/%ld/lwpctl", pid, t[i]);
        ctl[i] = open(p, O_WRONLY);
        assert(ctl[i] >= 0);
        sprintf(p, "/proc/%ld/lwp/%ld/lwpstatus", pid, t[i]);
        status[i] = open(p, O_RDONLY);
        assert(status[i] >= 0);
        j = write(ctl[i], set_async, sizeof(set_async));
        assert(j == sizeof(set_async));
    }

    sleep(1);

    while (1)
    {
        getchar();

        memset(&lwpstatus, 0, sizeof(lwpstatus));

        for (i = 0; i < 3; ++i)
        {
            unsigned* regs = lwpstatus[i].pr_context.uc_mcontext.gregs.gregs;
            j = write(ctl[i], stop, sizeof(stop));
            assert(j == sizeof(stop));
            /* seek is necessary and pread doesn't work */
            off = lseek(status[i], 0, L_SET);
            assert(off == 0);
            j = read(status[i], &lwpstatus[i], sizeof(lwpstatus[i]));
            assert(j == sizeof(lwpstatus[i]));
            printf("%d EDI:%x\n", i, regs[EDI]);
            printf("%d ESI:%x\n", i, regs[ESI]);
            printf("%d EBX:%x\n", i, regs[EBX]);
            printf("%d EDX:%x\n", i, regs[EDX]);
            printf("%d ECX:%x\n", i, regs[ECX]);
            printf("%d EAX:%x\n", i, regs[EAX]);
            printf("%d EBP:%x\n", i, regs[EBP]);
            printf("%d EIP:%x\n", i, regs[EIP]);
            printf("%d UESP:%x\n", i, regs[UESP]);
            j = write(ctl[i], run, sizeof(run));
            assert(j == sizeof(run));
        }
    }
}
