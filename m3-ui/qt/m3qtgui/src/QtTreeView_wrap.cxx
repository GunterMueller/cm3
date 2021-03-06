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


#include <QtGui/qtreeview.h>


#ifdef __cplusplus
extern "C" {
#endif

SWIGEXPORT QTreeView * New_QTreeView0(QWidget * parent) {
  QWidget *arg1 = (QWidget *) 0 ;
  QTreeView *result = 0 ;
  QTreeView * cresult ;
  
  arg1 = *(QWidget **)&parent; 
  result = (QTreeView *)new QTreeView(arg1);
  *(QTreeView **)&cresult = result; 
  return cresult;
}


SWIGEXPORT QTreeView * New_QTreeView1() {
  QTreeView *result = 0 ;
  QTreeView * cresult ;
  
  result = (QTreeView *)new QTreeView();
  *(QTreeView **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QTreeView(QTreeView * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  delete arg1;
}


SWIGEXPORT void QTreeView_setModel(QTreeView * self, QAbstractItemModel * model) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QAbstractItemModel *arg2 = (QAbstractItemModel *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QAbstractItemModel **)&model; 
  (arg1)->setModel(arg2);
}


SWIGEXPORT void QTreeView_setRootIndex(QTreeView * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  (arg1)->setRootIndex((QModelIndex const &)*arg2);
}


SWIGEXPORT void QTreeView_setSelectionModel(QTreeView * self, QItemSelectionModel * selectionModel) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QItemSelectionModel *arg2 = (QItemSelectionModel *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QItemSelectionModel **)&selectionModel; 
  (arg1)->setSelectionModel(arg2);
}


SWIGEXPORT QHeaderView * QTreeView_header(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QHeaderView *result = 0 ;
  QHeaderView * cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (QHeaderView *)((QTreeView const *)arg1)->header();
  *(QHeaderView **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setHeader(QTreeView * self, QHeaderView * header) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QHeaderView *arg2 = (QHeaderView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QHeaderView **)&header; 
  (arg1)->setHeader(arg2);
}


SWIGEXPORT int QTreeView_autoExpandDelay(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (int)((QTreeView const *)arg1)->autoExpandDelay();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setAutoExpandDelay(QTreeView * self, int delay) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)delay; 
  (arg1)->setAutoExpandDelay(arg2);
}


SWIGEXPORT int QTreeView_indentation(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (int)((QTreeView const *)arg1)->indentation();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setIndentation(QTreeView * self, int i) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)i; 
  (arg1)->setIndentation(arg2);
}


SWIGEXPORT bool QTreeView_rootIsDecorated(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->rootIsDecorated();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setRootIsDecorated(QTreeView * self, bool show) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = show ? true : false; 
  (arg1)->setRootIsDecorated(arg2);
}


SWIGEXPORT bool QTreeView_uniformRowHeights(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->uniformRowHeights();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setUniformRowHeights(QTreeView * self, bool uniform) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = uniform ? true : false; 
  (arg1)->setUniformRowHeights(arg2);
}


SWIGEXPORT bool QTreeView_itemsExpandable(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->itemsExpandable();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setItemsExpandable(QTreeView * self, bool enable) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = enable ? true : false; 
  (arg1)->setItemsExpandable(arg2);
}


SWIGEXPORT bool QTreeView_expandsOnDoubleClick(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->expandsOnDoubleClick();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setExpandsOnDoubleClick(QTreeView * self, bool enable) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = enable ? true : false; 
  (arg1)->setExpandsOnDoubleClick(arg2);
}


SWIGEXPORT int QTreeView_columnViewportPosition(QTreeView const * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  int result;
  int cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  result = (int)((QTreeView const *)arg1)->columnViewportPosition(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT int QTreeView_columnWidth(QTreeView const * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  int result;
  int cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  result = (int)((QTreeView const *)arg1)->columnWidth(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setColumnWidth(QTreeView * self, int column, int width) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  int arg3 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  arg3 = (int)width; 
  (arg1)->setColumnWidth(arg2,arg3);
}


SWIGEXPORT int QTreeView_columnAt(QTreeView const * self, int x) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  int result;
  int cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)x; 
  result = (int)((QTreeView const *)arg1)->columnAt(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT bool QTreeView_isColumnHidden(QTreeView const * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  result = (bool)((QTreeView const *)arg1)->isColumnHidden(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setColumnHidden(QTreeView * self, int column, bool hide) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  bool arg3 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  arg3 = hide ? true : false; 
  (arg1)->setColumnHidden(arg2,arg3);
}


SWIGEXPORT bool QTreeView_isHeaderHidden(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->isHeaderHidden();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setHeaderHidden(QTreeView * self, bool hide) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = hide ? true : false; 
  (arg1)->setHeaderHidden(arg2);
}


SWIGEXPORT bool QTreeView_isRowHidden(QTreeView const * self, int row, QModelIndex * parent) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  QModelIndex *arg3 = 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)row; 
  arg3 = *(QModelIndex **)&parent;
  result = (bool)((QTreeView const *)arg1)->isRowHidden(arg2,(QModelIndex const &)*arg3);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setRowHidden(QTreeView * self, int row, QModelIndex * parent, bool hide) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  QModelIndex *arg3 = 0 ;
  bool arg4 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)row; 
  arg3 = *(QModelIndex **)&parent;
  arg4 = hide ? true : false; 
  (arg1)->setRowHidden(arg2,(QModelIndex const &)*arg3,arg4);
}


SWIGEXPORT bool QTreeView_isFirstColumnSpanned(QTreeView const * self, int row, QModelIndex * parent) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  QModelIndex *arg3 = 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)row; 
  arg3 = *(QModelIndex **)&parent;
  result = (bool)((QTreeView const *)arg1)->isFirstColumnSpanned(arg2,(QModelIndex const &)*arg3);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setFirstColumnSpanned(QTreeView * self, int row, QModelIndex * parent, bool span) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  QModelIndex *arg3 = 0 ;
  bool arg4 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)row; 
  arg3 = *(QModelIndex **)&parent;
  arg4 = span ? true : false; 
  (arg1)->setFirstColumnSpanned(arg2,(QModelIndex const &)*arg3,arg4);
}


SWIGEXPORT bool QTreeView_isExpanded(QTreeView const * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  result = (bool)((QTreeView const *)arg1)->isExpanded((QModelIndex const &)*arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setExpanded(QTreeView * self, QModelIndex * index, bool expand) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  bool arg3 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  arg3 = expand ? true : false; 
  (arg1)->setExpanded((QModelIndex const &)*arg2,arg3);
}


SWIGEXPORT void QTreeView_setSortingEnabled(QTreeView * self, bool enable) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = enable ? true : false; 
  (arg1)->setSortingEnabled(arg2);
}


SWIGEXPORT bool QTreeView_isSortingEnabled(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->isSortingEnabled();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setAnimated(QTreeView * self, bool enable) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = enable ? true : false; 
  (arg1)->setAnimated(arg2);
}


SWIGEXPORT bool QTreeView_isAnimated(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->isAnimated();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setAllColumnsShowFocus(QTreeView * self, bool enable) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = enable ? true : false; 
  (arg1)->setAllColumnsShowFocus(arg2);
}


SWIGEXPORT bool QTreeView_allColumnsShowFocus(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->allColumnsShowFocus();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_setWordWrap(QTreeView * self, bool on) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = on ? true : false; 
  (arg1)->setWordWrap(arg2);
}


SWIGEXPORT bool QTreeView_wordWrap(QTreeView const * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QTreeView **)&self; 
  result = (bool)((QTreeView const *)arg1)->wordWrap();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QTreeView_keyboardSearch(QTreeView * self, QString * search) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QString *arg2 = 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QString **)&search;
  (arg1)->keyboardSearch((QString const &)*arg2);
}


SWIGEXPORT QRect * QTreeView_visualRect(QTreeView const * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  QRect * cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  *(QRect **)&cresult = new QRect((const QRect &)((QTreeView const *)arg1)->visualRect((QModelIndex const &)*arg2));
  return cresult;
}


SWIGEXPORT void QTreeView_scrollTo(QTreeView * self, QModelIndex * index, QAbstractItemView::ScrollHint hint) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  QAbstractItemView::ScrollHint arg3 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  arg3 = (QAbstractItemView::ScrollHint)hint; 
  (arg1)->scrollTo((QModelIndex const &)*arg2,arg3);
}


SWIGEXPORT void QTreeView_scrollTo1(QTreeView * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  (arg1)->scrollTo((QModelIndex const &)*arg2);
}


SWIGEXPORT QModelIndex * QTreeView_indexAbove(QTreeView const * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  QModelIndex * cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  *(QModelIndex **)&cresult = new QModelIndex((const QModelIndex &)((QTreeView const *)arg1)->indexAbove((QModelIndex const &)*arg2));
  return cresult;
}


SWIGEXPORT QModelIndex * QTreeView_indexBelow(QTreeView const * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  QModelIndex * cresult ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  *(QModelIndex **)&cresult = new QModelIndex((const QModelIndex &)((QTreeView const *)arg1)->indexBelow((QModelIndex const &)*arg2));
  return cresult;
}


SWIGEXPORT void QTreeView_doItemsLayout(QTreeView * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  (arg1)->doItemsLayout();
}


SWIGEXPORT void QTreeView_reset(QTreeView * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  (arg1)->reset();
}


SWIGEXPORT void QTreeView_sortByColumn(QTreeView * self, int column, Qt::SortOrder order) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  Qt::SortOrder arg3 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  arg3 = (Qt::SortOrder)order; 
  (arg1)->sortByColumn(arg2,arg3);
}


SWIGEXPORT void QTreeView_dataChanged(QTreeView * self, QModelIndex * topLeft, QModelIndex * bottomRight) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  QModelIndex *arg3 = 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&topLeft;
  arg3 = *(QModelIndex **)&bottomRight;
  (arg1)->dataChanged((QModelIndex const &)*arg2,(QModelIndex const &)*arg3);
}


SWIGEXPORT void QTreeView_selectAll(QTreeView * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  (arg1)->selectAll();
}


SWIGEXPORT void QTreeView_hideColumn(QTreeView * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  (arg1)->hideColumn(arg2);
}


SWIGEXPORT void QTreeView_showColumn(QTreeView * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  (arg1)->showColumn(arg2);
}


SWIGEXPORT void QTreeView_expand(QTreeView * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  (arg1)->expand((QModelIndex const &)*arg2);
}


SWIGEXPORT void QTreeView_collapse(QTreeView * self, QModelIndex * index) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  QModelIndex *arg2 = 0 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = *(QModelIndex **)&index;
  (arg1)->collapse((QModelIndex const &)*arg2);
}


SWIGEXPORT void QTreeView_resizeColumnToContents(QTreeView * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  (arg1)->resizeColumnToContents(arg2);
}


SWIGEXPORT void QTreeView_sortByColumn1(QTreeView * self, int column) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)column; 
  (arg1)->sortByColumn(arg2);
}


SWIGEXPORT void QTreeView_expandAll(QTreeView * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  (arg1)->expandAll();
}


SWIGEXPORT void QTreeView_collapseAll(QTreeView * self) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  
  arg1 = *(QTreeView **)&self; 
  (arg1)->collapseAll();
}


SWIGEXPORT void QTreeView_expandToDepth(QTreeView * self, int depth) {
  QTreeView *arg1 = (QTreeView *) 0 ;
  int arg2 ;
  
  arg1 = *(QTreeView **)&self; 
  arg2 = (int)depth; 
  (arg1)->expandToDepth(arg2);
}


#ifdef __cplusplus
}
#endif

