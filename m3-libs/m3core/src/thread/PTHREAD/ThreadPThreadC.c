/* Copyright (C) 2005, Purdue Research Foundation                  */
/* All rights reserved.                                            */
/* See the file COPYRIGHT-PURDUE for a full description.           */

#include "m3core.h"
#include <stdlib.h>
#include <pthread.h>
#include <setjmp.h>
#include <stdio.h>
#include <signal.h>
#include <sys/ucontext.h>

#if defined(__INTERIX) || defined(__APPLE__) || defined(__FreeBSD__)
/* See ThreadApple.c and ThreadFreeBSD.c. */
#define M3_DIRECT_SUSPEND
#endif

#ifdef __OpenBSD__
#error OpenBSD pthreads do not work.
#endif

#ifndef M3_DIRECT_SUSPEND
#include <semaphore.h>
#endif

#define M3MODULE ThreadPThread

#if defined(__sparc) || defined(__ia64__)
#define M3_REGISTER_WINDOWS
#endif

#ifdef M3_DIRECT_SUSPEND
#define M3_DIRECT_SUSPEND_ASSERT_FALSE do {                     \
    assert(0 && "MacOS X, FreeBSD should not get here.");       \
    fprintf(stderr, "MacOS X, FreeBSD should not get here.\n"); \
    abort();                                                    \
  } while(0);
#endif

/* const is extern const in C, but static const in C++,
 * but gcc gives a warning for the correct portable form "extern const" */
#if defined(__cplusplus) || !defined(__GNUC__)
#define EXTERN_CONST extern const
#else
#define EXTERN_CONST const
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define InitC                   ThreadPThread__InitC
#define SignalHandler           ThreadPThread__SignalHandler
#define sizeof_pthread_mutex_t  ThreadPThread__sizeof_pthread_mutex_t
#define sizeof_pthread_cond_t   ThreadPThread__sizeof_pthread_cond_t
#define SIG_SUSPEND             ThreadPThread__SIG_SUSPEND

/* expected values for compat, if compat matters:
    Solaris: 17 (at least 32bit SPARC?)
    Cygwin: 19 -- er, but maybe that's wrong
    Linux: 64
    FreeBSD: 31 (not used)
    OpenBSD: 31 (not used)
    HPUX: 44
  Look at the history of Usignal and RTMachine to find more values.  There was
  RTMachine.SIG_SUSPEND and SIG was aliased to it.  Both SIG and SIG_SUSPEND
  were only defined for systems using pthreads.  SIG was shorthand. */
#ifdef M3_DIRECT_SUSPEND
EXTERN_CONST int SIG_SUSPEND = 0;
#elif defined(__sun) || defined(__CYGWIN__)
EXTERN_CONST int SIG_SUSPEND = SIGUSR2;
#elif defined(__linux)
EXTERN_CONST int SIG_SUSPEND = NSIG - 1;
#elif defined(__hpux)
EXTERN_CONST int SIG_SUSPEND = _SIGRTMAX;
#elif defined(SIGRTMAX)
/* This might be a function call, in which case try _SIGRTMAX or initializing
   it somewhere. */
EXTERN_CONST int SIG_SUSPEND = SIGRTMAX;
#elif defined(SIGUSR2)
EXTERN_CONST int SIG_SUSPEND = SIGUSR2;
#else
#error Unable to determine SIG_SUSPEND.
#endif

static int stack_grows_down;

#ifndef M3_DIRECT_SUSPEND

typedef struct sigaction sigaction_t;

static sigset_t mask;

/* Signal based suspend/resume */
static sem_t ackSem;

void SignalHandler(int signo, siginfo_t *info, void *context);

int ThreadPThread__sem_wait(void)           { return sem_wait(&ackSem); }
int ThreadPThread__sem_post(void)           { return sem_post(&ackSem); }
int ThreadPThread__sem_getvalue(int *value) { return sem_getvalue(&ackSem, value); }

void
ThreadPThread__sigsuspend(void)
{
  sigjmp_buf jb;

  if (sigsetjmp(jb, 0) == 0) /* save registers to stack */
#ifdef M3_REGISTER_WINDOWS
    siglongjmp(jb, 1); /* flush register windows */
  else
#endif
    sigsuspend(&mask);
}

int
ThreadPThread__SuspendThread (m3_pthread_t mt)
{
  abort();
}

int
ThreadPThread__RestartThread (m3_pthread_t mt)
{
  abort();
}

void
ThreadPThread__ProcessStopped (m3_pthread_t mt, char *bottom, char *context,
                               void (*p)(void *start, void *limit))
{
  /* process stack */
  if (!bottom) return;
  if (stack_grows_down) {
    assert(context < bottom);
    p(context, bottom);
  } else {
    assert(bottom < context);
    p(bottom, context);
  }
  /* process register context */
  p(context, context + sizeof(ucontext_t));
}

#else /* M3_DIRECT_SUSPEND */

void ThreadPThread__sem_wait(void)      { M3_DIRECT_SUSPEND_ASSERT_FALSE }
void ThreadPThread__sem_post(void)      { M3_DIRECT_SUSPEND_ASSERT_FALSE }
void ThreadPThread__sem_getvalue(void)  { M3_DIRECT_SUSPEND_ASSERT_FALSE }
void ThreadPThread__sigsuspend(void)    { M3_DIRECT_SUSPEND_ASSERT_FALSE }

#endif /* M3_DIRECT_SUSPEND */

void
ThreadPThread__ProcessLive(char *bottom, void (*p)(void *start, void *limit))
{
  sigjmp_buf jb;

  if (sigsetjmp(jb, 0) == 0) /* save registers to stack */
#ifdef M3_REGISTER_WINDOWS
    siglongjmp(jb, 1); /* flush register windows */
  else
#endif
  {
    /* capture top after longjmp because longjmp can clobber non-volatile locals */
    char *top = (char*)&top;
    assert(bottom);
    if (stack_grows_down) {
      assert(top < bottom);
      p(top, bottom);
    } else {
      assert(bottom < top);
      p(bottom, top);
    }
    p(&jb, ((char *)&jb) + sizeof(jb));
  }
}

#define M3_MAX(x, y) (((x) > (y)) ? (x) : (y))
typedef void *(*start_routine_t)(void *);

#define M3_RETRY(expr) \
  r = (expr); \
  if (r == EAGAIN || r == ENOMEM || r == ENOSPC) \
  { \
    /* try again right away */ \
    r = (expr); \
    if (r == EAGAIN || r == ENOMEM || r == ENOSPC) \
    { \
      /* try again after short delay */ \
      sleep(1); \
      r = (expr); \
    } \
  }

int
ThreadPThread__thread_create(size_t stackSize,
                             start_routine_t start_routine,
                             void *arg)
{
  int r;
  size_t bytes;
  pthread_attr_t attr;
  pthread_t pthread;

  M3_RETRY(pthread_attr_init(&attr));
#ifdef __hpux
  if (r == ENOSYS)
    {
      fprintf(stderr,
              "You got the nonfunctional pthread stubs on HP-UX. You need to"
              " adjust your build commands, such as to link to -lpthread or"
              " use -pthread, and not link explicitly to -lc.\n");
    }
#endif
  assert(r == 0);

  r = pthread_attr_getstacksize(&attr, &bytes); assert(r == 0);

  bytes = M3_MAX(bytes, stackSize);
  pthread_attr_setstacksize(&attr, bytes);

  M3_RETRY(pthread_create(&pthread, &attr, start_routine, arg));

  pthread_attr_destroy(&attr);

  return r;
}

#define MUTEX(name) \
static pthread_mutex_t name##Mu = PTHREAD_MUTEX_INITIALIZER; \
pthread_mutex_t * const ThreadPThread__##name##Mu = &name##Mu; \

#define CONDITION_VARIABLE(name) \
static pthread_cond_t name##Cond = PTHREAD_COND_INITIALIZER; \
pthread_cond_t * const ThreadPThread__##name##Cond = &name##Cond; \

/* activeMu slotMu initMu perfMu heapMu heapCond */

MUTEX(active)                   /* global lock for list of active threads */
MUTEX(slots)                    /* global lock for thread slots table */
MUTEX(init)                     /* global lock for initializers */
MUTEX(perf)                     /* global lock for thread state tracing */
MUTEX(heap)                     /* global lock for heap atomicity */
CONDITION_VARIABLE(heap)        /* CV for heap state changes */

static pthread_key_t activations;

void
ThreadPThread__SetActivation(void *value)
{
  int r;
  M3_RETRY(pthread_setspecific(activations, value));
  assert(r == 0);
}

void *
ThreadPThread__GetActivation(void)
{
  return pthread_getspecific(activations);
}

typedef int (*generic_init_t)(void *, const void *);

void *
ThreadPThread_pthread_generic_new(size_t size, generic_init_t init)
{
  int r;
  void *p = calloc(1, size);
  if (p == NULL)
    goto Error;
  M3_RETRY(init(p, NULL));
  if (r == ENOMEM)
    goto Error;
  assert(r == 0);
  if (r != 0)
    goto Error;
  return p;
 Error:
  if (p) free(p);
  return NULL;
}

#define THREADPTHREAD__PTHREAD_GENERIC_NEW(type) {                      \
    typedef pthread_##type##_t T;                                       \
    typedef pthread_##type##attr_t attr_t;                              \
    typedef int (*init_t)(T *, const attr_t *);                         \
    /* make sure the type matches */                                    \
    init_t init = pthread_##type##_init;                                \
    return ThreadPThread_pthread_generic_new(sizeof(T),                 \
                                             (generic_init_t)init);     \
  }

void *
ThreadPThread__pthread_mutex_new(void)
{
  THREADPTHREAD__PTHREAD_GENERIC_NEW(mutex);
}

void *
ThreadPThread__pthread_cond_new(void)
{
  THREADPTHREAD__PTHREAD_GENERIC_NEW(cond);
}

void
ThreadPThread__pthread_mutex_delete(pthread_mutex_t* p)
{
  int e;
  if (p == NULL) return;
#if defined(__hpux) || defined(__osf)
  /* workaround Tru64 5.1 and HP-UX bug: pthread_mutex_destroy()
     intermittently returns EBUSY even when there are no threads accessing the
     mutex. */
  do { e = pthread_mutex_destroy(p); } while (e == EBUSY);
#else
  e = pthread_mutex_destroy(p);
#endif
  assert(e == 0);
  free(p);
}

void
ThreadPThread__pthread_cond_delete(pthread_cond_t *p)
{
  int r;
  if (p == NULL) return;
  r = pthread_cond_destroy(p);
  assert(r == 0);
  free(p);
}

INTEGER
ThreadPThread__select(INTEGER nfds,
                      ADDRESS read,
                      ADDRESS write,
                      ADDRESS except,
                      LONGREAL timeout)
{
    MicrosecondsStruct_t utime = { 0 };
    ZeroMemory(&utime, sizeof(utime));
    return select(nfds, read, write, except,
                  (timeout >= 0)
                  ? TimePosix__FloatSecondsToMicrosecondsStruct(timeout, &utime)
                  : NULL);
}

void
ThreadPThread__Nanosleep(INTEGER nanoseconds)
{
#ifdef __INTERIX
  usleep(nanoseconds / 1000); /* This is only an approximation.
                               * We don't try to complete the sleep
                               * if interrupted.
                               */
#else
  NanosecondsStruct_t wait = { 0 };
  NanosecondsStruct_t remaining = { 0 };

  ZeroMemory(&wait, sizeof(wait));
  ZeroMemory(&remaining, sizeof(remaining));

  wait.tv_sec = 0;
  wait.tv_nsec = nanoseconds;
  while (nanosleep(&wait, &remaining) == -1 && errno == EINTR)
      wait = remaining;
#endif
}

M3WRAP2(int, pthread_cond_wait, pthread_cond_t*, pthread_mutex_t*)
M3WRAP1(int, pthread_cond_signal, pthread_cond_t*)
M3WRAP1(int, pthread_cond_broadcast, pthread_cond_t*)

int
ThreadPThread__pthread_cond_timedwait(pthread_cond_t* cond,
                                      pthread_mutex_t* mutex,
                                      LONGREAL m3abs)
{
  NanosecondsStruct_t uabs = { 0 };
  ZeroMemory(&uabs, sizeof(uabs));
  return pthread_cond_timedwait(cond,
                                mutex,
                                TimePosix__FloatSecondsToNanosecondsStruct(m3abs, &uabs));
}

int
ThreadPThread__pthread_detach_self(void)
{
  return pthread_detach(pthread_self());
}

m3_pthread_t ThreadPThread__pthread_self(void)
{
  pthread_t a = pthread_self();
  return PTHREAD_TO_M3(a);
}

int
ThreadPThread__pthread_equal(m3_pthread_t t1, m3_pthread_t t2)
{
  return pthread_equal(PTHREAD_FROM_M3(t1), PTHREAD_FROM_M3(t2));
}

int
ThreadPThread__pthread_kill(m3_pthread_t thread, int sig)
{
  return pthread_kill(PTHREAD_FROM_M3(thread), sig);
}

M3WRAP1(int, pthread_mutex_lock, pthread_mutex_t*)
M3WRAP1(int, pthread_mutex_unlock, pthread_mutex_t*)

void
InitC(int *bottom)
{
#ifndef M3_DIRECT_SUSPEND
  struct sigaction act;
  struct sigaction oact;
#endif
  int r;

  stack_grows_down = (bottom > &r);
#if defined(__APPLE__) || defined(__FreeBSD__) || defined(__INTERIX)
  assert(stack_grows_down); /* See ThreadApple.c, ThreadFreeBSD.c, ThreadInterix.c */
#endif
  M3_RETRY(pthread_key_create(&activations, NULL)); assert(r == 0);

#ifndef M3_DIRECT_SUSPEND
  ZeroMemory(&act, sizeof(act));
  ZeroMemory(&oact, sizeof(oact));

  M3_RETRY(sem_init(&ackSem, 0, 0)); assert(r == 0);

  r = sigfillset(&mask); assert(r == 0);
  r = sigdelset(&mask, SIG_SUSPEND); assert(r == 0);
  r = sigdelset(&mask, SIGINT); assert(r == 0);
  r = sigdelset(&mask, SIGQUIT); assert(r == 0);
  r = sigdelset(&mask, SIGABRT); assert(r == 0);
  r = sigdelset(&mask, SIGTERM); assert(r == 0);

  act.sa_flags = SA_RESTART | SA_SIGINFO;
  act.sa_sigaction = SignalHandler;
  r = sigfillset(&act.sa_mask); assert(r == 0);
  r = sigaction(SIG_SUSPEND, &act, &oact); assert(r == 0);
#endif
}

#ifdef __cplusplus
} /* extern "C" */
#endif
