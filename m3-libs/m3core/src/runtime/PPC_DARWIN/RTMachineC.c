#include <stdlib.h>
#include <pthread.h>
#include <architecture/ppc/cframe.h>
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
RTMachine__GetState (pthread_t t, ppc_thread_state_t *state)
{
  mach_port_t mach_thread = pthread_mach_thread_np(t);
  mach_msg_type_number_t thread_state_count = PPC_THREAD_STATE_COUNT;
  if (thread_get_state(mach_thread, PPC_THREAD_STATE,
		       (thread_state_t)state, &thread_state_count)
      != KERN_SUCCESS) abort();
  if (thread_state_count != PPC_THREAD_STATE_COUNT) abort();
  return (void *)(state->r1 - C_RED_ZONE);
}

void
RTMachine__RestartThread (pthread_t t)
{
  mach_port_t mach_thread = pthread_mach_thread_np(t);
  if (thread_resume(mach_thread) != KERN_SUCCESS) abort();
}
