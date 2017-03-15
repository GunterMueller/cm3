/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * This file is not intended to be easily readable and contains a number of
 * coding conventions designed to improve portability and efficiency. Do not make
 * changes to this file unless you know what you are doing--modify the SWIG
 * interface file instead.
 * ----------------------------------------------------------------------------- */

#define SWIGMODULA3


#ifdef __cplusplus
/* SwigValueWrapper is described in swig.swg */
template<typename T> class SwigValueWrapper {
  struct SwigMovePointer {
    T *ptr;
    SwigMovePointer(T *p) : ptr(p) { }
    ~SwigMovePointer() { delete ptr; }
    SwigMovePointer& operator=(SwigMovePointer& rhs) { T* oldptr = ptr; ptr = 0; delete oldptr; ptr = rhs.ptr; rhs.ptr = 0; return *this; }
  } pointer;
  SwigValueWrapper& operator=(const SwigValueWrapper<T>& rhs);
  SwigValueWrapper(const SwigValueWrapper<T>& rhs);
public:
  SwigValueWrapper() : pointer(0) { }
  SwigValueWrapper& operator=(const T& t) { SwigMovePointer tmp(new T(t)); pointer = tmp; return *this; }
  operator T&() const { return *pointer.ptr; }
  T *operator&() { return pointer.ptr; }
};

template <typename T> T SwigValueInit() {
  return T();
}
#endif

/* -----------------------------------------------------------------------------
 *  This section contains generic SWIG labels for method/variable
 *  declarations/attributes, and other compiler dependent labels.
 * ----------------------------------------------------------------------------- */

/* template workaround for compilers that cannot correctly implement the C++ standard */
#ifndef SWIGTEMPLATEDISAMBIGUATOR
# if defined(__SUNPRO_CC) && (__SUNPRO_CC <= 0x560)
#  define SWIGTEMPLATEDISAMBIGUATOR template
# elif defined(__HP_aCC)
/* Needed even with `aCC -AA' when `aCC -V' reports HP ANSI C++ B3910B A.03.55 */
/* If we find a maximum version that requires this, the test would be __HP_aCC <= 35500 for A.03.55 */
#  define SWIGTEMPLATEDISAMBIGUATOR template
# else
#  define SWIGTEMPLATEDISAMBIGUATOR
# endif
#endif

/* inline attribute */
#ifndef SWIGINLINE
# if defined(__cplusplus) || (defined(__GNUC__) && !defined(__STRICT_ANSI__))
#   define SWIGINLINE inline
# else
#   define SWIGINLINE
# endif
#endif

/* attribute recognised by some compilers to avoid 'unused' warnings */
#ifndef SWIGUNUSED
# if defined(__GNUC__)
#   if !(defined(__cplusplus)) || (__GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4))
#     define SWIGUNUSED __attribute__ ((__unused__))
#   else
#     define SWIGUNUSED
#   endif
# elif defined(__ICC)
#   define SWIGUNUSED __attribute__ ((__unused__))
# else
#   define SWIGUNUSED
# endif
#endif

#ifndef SWIG_MSC_UNSUPPRESS_4505
# if defined(_MSC_VER)
#   pragma warning(disable : 4505) /* unreferenced local function has been removed */
# endif
#endif

#ifndef SWIGUNUSEDPARM
# ifdef __cplusplus
#   define SWIGUNUSEDPARM(p)
# else
#   define SWIGUNUSEDPARM(p) p SWIGUNUSED
# endif
#endif

/* internal SWIG method */
#ifndef SWIGINTERN
# define SWIGINTERN static SWIGUNUSED
#endif

/* internal inline SWIG method */
#ifndef SWIGINTERNINLINE
# define SWIGINTERNINLINE SWIGINTERN SWIGINLINE
#endif

/* exporting methods */
#if defined(__GNUC__)
#  if (__GNUC__ >= 4) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
#    ifndef GCC_HASCLASSVISIBILITY
#      define GCC_HASCLASSVISIBILITY
#    endif
#  endif
#endif

#ifndef SWIGEXPORT
# if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#   if defined(STATIC_LINKED)
#     define SWIGEXPORT
#   else
#     define SWIGEXPORT __declspec(dllexport)
#   endif
# else
#   if defined(__GNUC__) && defined(GCC_HASCLASSVISIBILITY)
#     define SWIGEXPORT __attribute__ ((visibility("default")))
#   else
#     define SWIGEXPORT
#   endif
# endif
#endif

/* calling conventions for Windows */
#ifndef SWIGSTDCALL
# if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
#   define SWIGSTDCALL __stdcall
# else
#   define SWIGSTDCALL
# endif
#endif

/* Deal with Microsoft's attempt at deprecating C standard runtime functions */
#if !defined(SWIG_NO_CRT_SECURE_NO_DEPRECATE) && defined(_MSC_VER) && !defined(_CRT_SECURE_NO_DEPRECATE)
# define _CRT_SECURE_NO_DEPRECATE
#endif

/* Deal with Microsoft's attempt at deprecating methods in the standard C++ library */
#if !defined(SWIG_NO_SCL_SECURE_NO_DEPRECATE) && defined(_MSC_VER) && !defined(_SCL_SECURE_NO_DEPRECATE)
# define _SCL_SECURE_NO_DEPRECATE
#endif

/* Deal with Apple's deprecated 'AssertMacros.h' from Carbon-framework */
#if defined(__APPLE__) && !defined(__ASSERT_MACROS_DEFINE_VERSIONS_WITHOUT_UNDERSCORES)
# define __ASSERT_MACROS_DEFINE_VERSIONS_WITHOUT_UNDERSCORES 0
#endif

/* Intel's compiler complains if a variable which was never initialised is
 * cast to void, which is a common idiom which we use to indicate that we
 * are aware a variable isn't used.  So we just silence that warning.
 * See: https://github.com/swig/swig/issues/192 for more discussion.
 */
#ifdef __INTEL_COMPILER
# pragma warning disable 592
#endif



#include <stdlib.h>
#include <string.h>
#include <stdio.h>


#include <QtCore/qcoreevent.h>


#ifdef __cplusplus
extern "C" {
#endif

SWIGEXPORT QEvent * New_QEvent0(QEvent::Type type) {
  QEvent::Type arg1 ;
  QEvent *result = 0 ;
  QEvent * cresult ;
  
  arg1 = (QEvent::Type)type; 
  result = (QEvent *)new QEvent(arg1);
  *(QEvent **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QEvent(QEvent * self) {
  QEvent *arg1 = (QEvent *) 0 ;
  
  arg1 = *(QEvent **)&self; 
  delete arg1;
}


SWIGEXPORT QEvent::Type QEvent_type(QEvent const * self) {
  QEvent *arg1 = (QEvent *) 0 ;
  QEvent::Type result;
  QEvent::Type cresult ;
  
  arg1 = *(QEvent **)&self; 
  result = (QEvent::Type)((QEvent const *)arg1)->type();
  cresult = result; 
  return cresult;
}


SWIGEXPORT bool QEvent_spontaneous(QEvent const * self) {
  QEvent *arg1 = (QEvent *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QEvent **)&self; 
  result = (bool)((QEvent const *)arg1)->spontaneous();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QEvent_setAccepted(QEvent * self, bool accepted) {
  QEvent *arg1 = (QEvent *) 0 ;
  bool arg2 ;
  
  arg1 = *(QEvent **)&self; 
  arg2 = accepted ? true : false; 
  (arg1)->setAccepted(arg2);
}


SWIGEXPORT bool QEvent_isAccepted(QEvent const * self) {
  QEvent *arg1 = (QEvent *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QEvent **)&self; 
  result = (bool)((QEvent const *)arg1)->isAccepted();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QEvent_accept(QEvent * self) {
  QEvent *arg1 = (QEvent *) 0 ;
  
  arg1 = *(QEvent **)&self; 
  (arg1)->accept();
}


SWIGEXPORT void QEvent_ignore(QEvent * self) {
  QEvent *arg1 = (QEvent *) 0 ;
  
  arg1 = *(QEvent **)&self; 
  (arg1)->ignore();
}


SWIGEXPORT int RegisterEventType(int hint) {
  int arg1 = (int) -1 ;
  int result;
  int cresult ;
  
  arg1 = (int)hint; 
  result = (int)QEvent::registerEventType(arg1);
  cresult = result; 
  return cresult;
}


SWIGEXPORT QTimerEvent * New_QTimerEvent0(int timerId) {
  int arg1 ;
  QTimerEvent *result = 0 ;
  QTimerEvent * cresult ;
  
  arg1 = (int)timerId; 
  result = (QTimerEvent *)new QTimerEvent(arg1);
  *(QTimerEvent **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QTimerEvent(QTimerEvent * self) {
  QTimerEvent *arg1 = (QTimerEvent *) 0 ;
  
  arg1 = *(QTimerEvent **)&self; 
  delete arg1;
}


SWIGEXPORT int QTimerEvent_timerId(QTimerEvent const * self) {
  QTimerEvent *arg1 = (QTimerEvent *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QTimerEvent **)&self; 
  result = (int)((QTimerEvent const *)arg1)->timerId();
  cresult = result; 
  return cresult;
}


SWIGEXPORT QChildEvent * New_QChildEvent0(QEvent::Type type, QObject * child) {
  QEvent::Type arg1 ;
  QObject *arg2 = (QObject *) 0 ;
  QChildEvent *result = 0 ;
  QChildEvent * cresult ;
  
  arg1 = (QEvent::Type)type; 
  arg2 = *(QObject **)&child; 
  result = (QChildEvent *)new QChildEvent(arg1,arg2);
  *(QChildEvent **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QChildEvent(QChildEvent * self) {
  QChildEvent *arg1 = (QChildEvent *) 0 ;
  
  arg1 = *(QChildEvent **)&self; 
  delete arg1;
}


SWIGEXPORT QObject * QChildEvent_child(QChildEvent const * self) {
  QChildEvent *arg1 = (QChildEvent *) 0 ;
  QObject *result = 0 ;
  QObject * cresult ;
  
  arg1 = *(QChildEvent **)&self; 
  result = (QObject *)((QChildEvent const *)arg1)->child();
  *(QObject **)&cresult = result; 
  return cresult;
}


SWIGEXPORT bool QChildEvent_added(QChildEvent const * self) {
  QChildEvent *arg1 = (QChildEvent *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QChildEvent **)&self; 
  result = (bool)((QChildEvent const *)arg1)->added();
  cresult = result; 
  return cresult;
}


SWIGEXPORT bool QChildEvent_polished(QChildEvent const * self) {
  QChildEvent *arg1 = (QChildEvent *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QChildEvent **)&self; 
  result = (bool)((QChildEvent const *)arg1)->polished();
  cresult = result; 
  return cresult;
}


SWIGEXPORT bool QChildEvent_removed(QChildEvent const * self) {
  QChildEvent *arg1 = (QChildEvent *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QChildEvent **)&self; 
  result = (bool)((QChildEvent const *)arg1)->removed();
  cresult = result; 
  return cresult;
}


SWIGEXPORT QDynamicPropertyChangeEvent * New_QDynamicPropertyChangeEvent0(QByteArray const & name) {
  QByteArray *arg1 = 0 ;
  QDynamicPropertyChangeEvent *result = 0 ;
  QDynamicPropertyChangeEvent * cresult ;
  
  arg1 = *(QByteArray **)&name;
  result = (QDynamicPropertyChangeEvent *)new QDynamicPropertyChangeEvent((QByteArray const &)*arg1);
  *(QDynamicPropertyChangeEvent **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QDynamicPropertyChangeEvent(QDynamicPropertyChangeEvent * self) {
  QDynamicPropertyChangeEvent *arg1 = (QDynamicPropertyChangeEvent *) 0 ;
  
  arg1 = *(QDynamicPropertyChangeEvent **)&self; 
  delete arg1;
}


SWIGEXPORT QByteArray QDynamicPropertyChangeEvent_propertyName(QDynamicPropertyChangeEvent const * self) {
  QDynamicPropertyChangeEvent *arg1 = (QDynamicPropertyChangeEvent *) 0 ;
  QByteArray cresult ;
  
  arg1 = *(QDynamicPropertyChangeEvent **)&self; 
  *(QByteArray **)&cresult = new QByteArray((const QByteArray &)((QDynamicPropertyChangeEvent const *)arg1)->propertyName());
  return cresult;
}


#ifdef __cplusplus
}
#endif

