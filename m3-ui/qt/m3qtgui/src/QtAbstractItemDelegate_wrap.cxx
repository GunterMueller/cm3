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


#include <QtGui/qabstractitemdelegate.h>


#ifdef __cplusplus
extern "C" {
#endif

SWIGEXPORT void Delete_QAbstractItemDelegate(QAbstractItemDelegate * self) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  delete arg1;
}


SWIGEXPORT QWidget * QAbstractItemDelegate_createEditor(QAbstractItemDelegate const * self, QWidget * parent, QStyleOptionViewItem * option, QModelIndex * index) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  QWidget *arg2 = (QWidget *) 0 ;
  QStyleOptionViewItem *arg3 = 0 ;
  QModelIndex *arg4 = 0 ;
  QWidget *result = 0 ;
  QWidget * cresult ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  arg2 = *(QWidget **)&parent; 
  arg3 = *(QStyleOptionViewItem **)&option;
  arg4 = *(QModelIndex **)&index;
  result = (QWidget *)((QAbstractItemDelegate const *)arg1)->createEditor(arg2,(QStyleOptionViewItem const &)*arg3,(QModelIndex const &)*arg4);
  *(QWidget **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void QAbstractItemDelegate_setEditorData(QAbstractItemDelegate const * self, QWidget * editor, QModelIndex * index) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  QWidget *arg2 = (QWidget *) 0 ;
  QModelIndex *arg3 = 0 ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  arg2 = *(QWidget **)&editor; 
  arg3 = *(QModelIndex **)&index;
  ((QAbstractItemDelegate const *)arg1)->setEditorData(arg2,(QModelIndex const &)*arg3);
}


SWIGEXPORT void QAbstractItemDelegate_setModelData(QAbstractItemDelegate const * self, QWidget * editor, QAbstractItemModel * model, QModelIndex * index) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  QWidget *arg2 = (QWidget *) 0 ;
  QAbstractItemModel *arg3 = (QAbstractItemModel *) 0 ;
  QModelIndex *arg4 = 0 ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  arg2 = *(QWidget **)&editor; 
  arg3 = *(QAbstractItemModel **)&model; 
  arg4 = *(QModelIndex **)&index;
  ((QAbstractItemDelegate const *)arg1)->setModelData(arg2,arg3,(QModelIndex const &)*arg4);
}


SWIGEXPORT void QAbstractItemDelegate_updateEditorGeometry(QAbstractItemDelegate const * self, QWidget * editor, QStyleOptionViewItem * option, QModelIndex * index) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  QWidget *arg2 = (QWidget *) 0 ;
  QStyleOptionViewItem *arg3 = 0 ;
  QModelIndex *arg4 = 0 ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  arg2 = *(QWidget **)&editor; 
  arg3 = *(QStyleOptionViewItem **)&option;
  arg4 = *(QModelIndex **)&index;
  ((QAbstractItemDelegate const *)arg1)->updateEditorGeometry(arg2,(QStyleOptionViewItem const &)*arg3,(QModelIndex const &)*arg4);
}


SWIGEXPORT bool QAbstractItemDelegate_editorEvent(QAbstractItemDelegate * self, QEvent * event, QAbstractItemModel * model, QStyleOptionViewItem * option, QModelIndex * index) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  QEvent *arg2 = (QEvent *) 0 ;
  QAbstractItemModel *arg3 = (QAbstractItemModel *) 0 ;
  QStyleOptionViewItem *arg4 = 0 ;
  QModelIndex *arg5 = 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  arg2 = *(QEvent **)&event; 
  arg3 = *(QAbstractItemModel **)&model; 
  arg4 = *(QStyleOptionViewItem **)&option;
  arg5 = *(QModelIndex **)&index;
  result = (bool)(arg1)->editorEvent(arg2,arg3,(QStyleOptionViewItem const &)*arg4,(QModelIndex const &)*arg5);
  cresult = result; 
  return cresult;
}


SWIGEXPORT QString * ElidedText(QFontMetrics * fontMetrics, int width, Qt::TextElideMode mode, QString * text) {
  QFontMetrics *arg1 = 0 ;
  int arg2 ;
  Qt::TextElideMode arg3 ;
  QString *arg4 = 0 ;
  QString * cresult ;
  
  arg1 = *(QFontMetrics **)&fontMetrics;
  arg2 = (int)width; 
  arg3 = (Qt::TextElideMode)mode; 
  arg4 = *(QString **)&text;
  *(QString **)&cresult = new QString((const QString &)QAbstractItemDelegate::elidedText((QFontMetrics const &)*arg1,arg2,arg3,(QString const &)*arg4));
  return cresult;
}


SWIGEXPORT bool QAbstractItemDelegate_helpEvent(QAbstractItemDelegate * self, QHelpEvent * event, QAbstractItemView * view, QStyleOptionViewItem * option, QModelIndex * index) {
  QAbstractItemDelegate *arg1 = (QAbstractItemDelegate *) 0 ;
  QHelpEvent *arg2 = (QHelpEvent *) 0 ;
  QAbstractItemView *arg3 = (QAbstractItemView *) 0 ;
  QStyleOptionViewItem *arg4 = 0 ;
  QModelIndex *arg5 = 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QAbstractItemDelegate **)&self; 
  arg2 = *(QHelpEvent **)&event; 
  arg3 = *(QAbstractItemView **)&view; 
  arg4 = *(QStyleOptionViewItem **)&option;
  arg5 = *(QModelIndex **)&index;
  result = (bool)(arg1)->helpEvent(arg2,arg3,(QStyleOptionViewItem const &)*arg4,(QModelIndex const &)*arg5);
  cresult = result; 
  return cresult;
}


#ifdef __cplusplus
}
#endif

