#include <stdlib.h>
#include <pthread.h>
#include <mach/mach.h>
#include <mach/thread_act.h>

int
RTMachine__SuspendThread (pthread_t t)
{
  mach_port_t mach_thread = pthread_mach_thread_np(t);
  if (thread_suspend(mach_thread) != KERN_SUCCESS) abort();
  return thread_abort_safely(mach_thread) == KERN_SUCCESS;
}

void *
RTMachine__GetState (pthread_t t, x86_thread_state64_t *state)
{
  mach_port_t mach_thread = pthread_mach_thread_np(t);
  mach_msg_type_number_t thread_state_count = x86_THREAD_STATE64_COUNT;
  if (thread_get_state(mach_thread, x86_THREAD_STATE64,
		       (thread_state_t)state, &thread_state_count)
      != KERN_SUCCESS) abort();
  if (thread_state_count != x86_THREAD_STATE64_COUNT) abort();
#if __DARWIN_UNIX03
  return (void *)(state->__rsp - 128);
#else
  return (void *)(state->rsp - 128);
#endif
}

void
RTMachine__RestartThread (pthread_t t)
{
  mach_port_t mach_thread = pthread_mach_thread_np(t);
  if (thread_resume(mach_thread) != KERN_SUCCESS) abort();
}
