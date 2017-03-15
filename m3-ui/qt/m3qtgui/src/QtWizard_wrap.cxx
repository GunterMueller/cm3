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


#include <QtGui/qwizard.h>
#define  WizardOptions  QWizard::WizardOptions


#ifdef __cplusplus
extern "C" {
#endif

SWIGEXPORT QWizard * New_QWizard0(QWidget * parent, int flags) {
  QWidget *arg1 = (QWidget *) 0 ;
  Qt::WindowFlags arg2 ;
  QWizard *result = 0 ;
  QWizard * cresult ;
  
  arg1 = *(QWidget **)&parent; 
  arg2 = (Qt::WindowFlags)flags; 
  result = (QWizard *)new QWizard(arg1,arg2);
  *(QWizard **)&cresult = result; 
  return cresult;
}


SWIGEXPORT QWizard * New_QWizard1(QWidget * parent) {
  QWidget *arg1 = (QWidget *) 0 ;
  QWizard *result = 0 ;
  QWizard * cresult ;
  
  arg1 = *(QWidget **)&parent; 
  result = (QWizard *)new QWizard(arg1);
  *(QWizard **)&cresult = result; 
  return cresult;
}


SWIGEXPORT QWizard * New_QWizard2() {
  QWizard *result = 0 ;
  QWizard * cresult ;
  
  result = (QWizard *)new QWizard();
  *(QWizard **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QWizard(QWizard * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  delete arg1;
}


SWIGEXPORT int QWizard_addPage(QWizard * self, QWizardPage * page) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizardPage *arg2 = (QWizardPage *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = *(QWizardPage **)&page; 
  result = (int)(arg1)->addPage(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setPage(QWizard * self, int id, QWizardPage * page) {
  QWizard *arg1 = (QWizard *) 0 ;
  int arg2 ;
  QWizardPage *arg3 = (QWizardPage *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (int)id; 
  arg3 = *(QWizardPage **)&page; 
  (arg1)->setPage(arg2,arg3);
}


SWIGEXPORT void QWizard_removePage(QWizard * self, int id) {
  QWizard *arg1 = (QWizard *) 0 ;
  int arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (int)id; 
  (arg1)->removePage(arg2);
}


SWIGEXPORT QWizardPage * QWizard_page(QWizard const * self, int id) {
  QWizard *arg1 = (QWizard *) 0 ;
  int arg2 ;
  QWizardPage *result = 0 ;
  QWizardPage * cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (int)id; 
  result = (QWizardPage *)((QWizard const *)arg1)->page(arg2);
  *(QWizardPage **)&cresult = result; 
  return cresult;
}


SWIGEXPORT bool QWizard_hasVisitedPage(QWizard const * self, int id) {
  QWizard *arg1 = (QWizard *) 0 ;
  int arg2 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (int)id; 
  result = (bool)((QWizard const *)arg1)->hasVisitedPage(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setStartId(QWizard * self, int id) {
  QWizard *arg1 = (QWizard *) 0 ;
  int arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (int)id; 
  (arg1)->setStartId(arg2);
}


SWIGEXPORT int QWizard_startId(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (int)((QWizard const *)arg1)->startId();
  cresult = result; 
  return cresult;
}


SWIGEXPORT QWizardPage * QWizard_currentPage(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizardPage *result = 0 ;
  QWizardPage * cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (QWizardPage *)((QWizard const *)arg1)->currentPage();
  *(QWizardPage **)&cresult = result; 
  return cresult;
}


SWIGEXPORT int QWizard_currentId(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (int)((QWizard const *)arg1)->currentId();
  cresult = result; 
  return cresult;
}


SWIGEXPORT bool QWizard_validateCurrentPage(QWizard * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (bool)(arg1)->validateCurrentPage();
  cresult = result; 
  return cresult;
}


SWIGEXPORT int QWizard_nextId(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (int)((QWizard const *)arg1)->nextId();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setWizardStyle(QWizard * self, QWizard::WizardStyle style) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardStyle arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardStyle)style; 
  (arg1)->setWizardStyle(arg2);
}


SWIGEXPORT QWizard::WizardStyle QWizard_wizardStyle(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardStyle result;
  QWizard::WizardStyle cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (QWizard::WizardStyle)((QWizard const *)arg1)->wizardStyle();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setOption(QWizard * self, QWizard::WizardOption option, bool on) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardOption arg2 ;
  bool arg3 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardOption)option; 
  arg3 = on ? true : false; 
  (arg1)->setOption(arg2,arg3);
}


SWIGEXPORT void QWizard_setOption1(QWizard * self, QWizard::WizardOption option) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardOption arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardOption)option; 
  (arg1)->setOption(arg2);
}


SWIGEXPORT bool QWizard_testOption(QWizard const * self, QWizard::WizardOption option) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardOption arg2 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardOption)option; 
  result = (bool)((QWizard const *)arg1)->testOption(arg2);
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setOptions(QWizard * self, int options) {
  QWizard *arg1 = (QWizard *) 0 ;
  WizardOptions arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (WizardOptions)options; 
  (arg1)->setOptions(arg2);
}


SWIGEXPORT int QWizard_options(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  WizardOptions result;
  int cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = ((QWizard const *)arg1)->options();
  cresult = (int)result;
  return cresult;
}


SWIGEXPORT void QWizard_setButtonText(QWizard * self, QWizard::WizardButton which, QString * text) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardButton arg2 ;
  QString *arg3 = 0 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardButton)which; 
  arg3 = *(QString **)&text;
  (arg1)->setButtonText(arg2,(QString const &)*arg3);
}


SWIGEXPORT QString * QWizard_buttonText(QWizard const * self, QWizard::WizardButton which) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardButton arg2 ;
  QString * cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardButton)which; 
  *(QString **)&cresult = new QString((const QString &)((QWizard const *)arg1)->buttonText(arg2));
  return cresult;
}


SWIGEXPORT void QWizard_setButton(QWizard * self, QWizard::WizardButton which, QAbstractButton * button) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardButton arg2 ;
  QAbstractButton *arg3 = (QAbstractButton *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardButton)which; 
  arg3 = *(QAbstractButton **)&button; 
  (arg1)->setButton(arg2,arg3);
}


SWIGEXPORT QAbstractButton * QWizard_button(QWizard const * self, QWizard::WizardButton which) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardButton arg2 ;
  QAbstractButton *result = 0 ;
  QAbstractButton * cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardButton)which; 
  result = (QAbstractButton *)((QWizard const *)arg1)->button(arg2);
  *(QAbstractButton **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setTitleFormat(QWizard * self, Qt::TextFormat format) {
  QWizard *arg1 = (QWizard *) 0 ;
  Qt::TextFormat arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (Qt::TextFormat)format; 
  (arg1)->setTitleFormat(arg2);
}


SWIGEXPORT Qt::TextFormat QWizard_titleFormat(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  Qt::TextFormat result;
  Qt::TextFormat cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (Qt::TextFormat)((QWizard const *)arg1)->titleFormat();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setSubTitleFormat(QWizard * self, Qt::TextFormat format) {
  QWizard *arg1 = (QWizard *) 0 ;
  Qt::TextFormat arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (Qt::TextFormat)format; 
  (arg1)->setSubTitleFormat(arg2);
}


SWIGEXPORT Qt::TextFormat QWizard_subTitleFormat(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  Qt::TextFormat result;
  Qt::TextFormat cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (Qt::TextFormat)((QWizard const *)arg1)->subTitleFormat();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setPixmap(QWizard * self, QWizard::WizardPixmap which, QPixmap * pixmap) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardPixmap arg2 ;
  QPixmap *arg3 = 0 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardPixmap)which; 
  arg3 = *(QPixmap **)&pixmap;
  (arg1)->setPixmap(arg2,(QPixmap const &)*arg3);
}


SWIGEXPORT QPixmap * QWizard_pixmap(QWizard const * self, QWizard::WizardPixmap which) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWizard::WizardPixmap arg2 ;
  QPixmap * cresult ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = (QWizard::WizardPixmap)which; 
  *(QPixmap **)&cresult = new QPixmap((const QPixmap &)((QWizard const *)arg1)->pixmap(arg2));
  return cresult;
}


SWIGEXPORT void QWizard_setSideWidget(QWizard * self, QWidget * widget) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWidget *arg2 = (QWidget *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = *(QWidget **)&widget; 
  (arg1)->setSideWidget(arg2);
}


SWIGEXPORT QWidget * QWizard_sideWidget(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  QWidget *result = 0 ;
  QWidget * cresult ;
  
  arg1 = *(QWizard **)&self; 
  result = (QWidget *)((QWizard const *)arg1)->sideWidget();
  *(QWidget **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizard_setDefaultProperty(QWizard * self, char * className, char * property, char * changedSignal) {
  QWizard *arg1 = (QWizard *) 0 ;
  char *arg2 = (char *) 0 ;
  char *arg3 = (char *) 0 ;
  char *arg4 = (char *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  {
    arg2 = className;
  }
  {
    arg3 = property;
  }
  {
    arg4 = changedSignal;
  }
  (arg1)->setDefaultProperty((char const *)arg2,(char const *)arg3,(char const *)arg4);
}


SWIGEXPORT void QWizard_setVisible(QWizard * self, bool visible) {
  QWizard *arg1 = (QWizard *) 0 ;
  bool arg2 ;
  
  arg1 = *(QWizard **)&self; 
  arg2 = visible ? true : false; 
  (arg1)->setVisible(arg2);
}


SWIGEXPORT QSize * QWizard_sizeHint(QWizard const * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  QSize * cresult ;
  
  arg1 = *(QWizard **)&self; 
  *(QSize **)&cresult = new QSize((const QSize &)((QWizard const *)arg1)->sizeHint());
  return cresult;
}


SWIGEXPORT void QWizard_back(QWizard * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  (arg1)->back();
}


SWIGEXPORT void QWizard_next(QWizard * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  (arg1)->next();
}


SWIGEXPORT void QWizard_restart(QWizard * self) {
  QWizard *arg1 = (QWizard *) 0 ;
  
  arg1 = *(QWizard **)&self; 
  (arg1)->restart();
}


SWIGEXPORT QWizardPage * New_QWizardPage0(QWidget * parent) {
  QWidget *arg1 = (QWidget *) 0 ;
  QWizardPage *result = 0 ;
  QWizardPage * cresult ;
  
  arg1 = *(QWidget **)&parent; 
  result = (QWizardPage *)new QWizardPage(arg1);
  *(QWizardPage **)&cresult = result; 
  return cresult;
}


SWIGEXPORT QWizardPage * New_QWizardPage1() {
  QWizardPage *result = 0 ;
  QWizardPage * cresult ;
  
  result = (QWizardPage *)new QWizardPage();
  *(QWizardPage **)&cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizardPage_setTitle(QWizardPage * self, QString * title) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QString *arg2 = 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = *(QString **)&title;
  (arg1)->setTitle((QString const &)*arg2);
}


SWIGEXPORT QString * QWizardPage_title(QWizardPage const * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QString * cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  *(QString **)&cresult = new QString((const QString &)((QWizardPage const *)arg1)->title());
  return cresult;
}


SWIGEXPORT void QWizardPage_setSubTitle(QWizardPage * self, QString * subTitle) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QString *arg2 = 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = *(QString **)&subTitle;
  (arg1)->setSubTitle((QString const &)*arg2);
}


SWIGEXPORT QString * QWizardPage_subTitle(QWizardPage const * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QString * cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  *(QString **)&cresult = new QString((const QString &)((QWizardPage const *)arg1)->subTitle());
  return cresult;
}


SWIGEXPORT void QWizardPage_setPixmap(QWizardPage * self, QWizard::WizardPixmap which, QPixmap * pixmap) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QWizard::WizardPixmap arg2 ;
  QPixmap *arg3 = 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = (QWizard::WizardPixmap)which; 
  arg3 = *(QPixmap **)&pixmap;
  (arg1)->setPixmap(arg2,(QPixmap const &)*arg3);
}


SWIGEXPORT QPixmap * QWizardPage_pixmap(QWizardPage const * self, QWizard::WizardPixmap which) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QWizard::WizardPixmap arg2 ;
  QPixmap * cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = (QWizard::WizardPixmap)which; 
  *(QPixmap **)&cresult = new QPixmap((const QPixmap &)((QWizardPage const *)arg1)->pixmap(arg2));
  return cresult;
}


SWIGEXPORT void QWizardPage_setFinalPage(QWizardPage * self, bool finalPage) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  bool arg2 ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = finalPage ? true : false; 
  (arg1)->setFinalPage(arg2);
}


SWIGEXPORT bool QWizardPage_isFinalPage(QWizardPage const * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  result = (bool)((QWizardPage const *)arg1)->isFinalPage();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizardPage_setCommitPage(QWizardPage * self, bool commitPage) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  bool arg2 ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = commitPage ? true : false; 
  (arg1)->setCommitPage(arg2);
}


SWIGEXPORT bool QWizardPage_isCommitPage(QWizardPage const * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  result = (bool)((QWizardPage const *)arg1)->isCommitPage();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void QWizardPage_setButtonText(QWizardPage * self, QWizard::WizardButton which, QString * text) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QWizard::WizardButton arg2 ;
  QString *arg3 = 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = (QWizard::WizardButton)which; 
  arg3 = *(QString **)&text;
  (arg1)->setButtonText(arg2,(QString const &)*arg3);
}


SWIGEXPORT QString * QWizardPage_buttonText(QWizardPage const * self, QWizard::WizardButton which) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  QWizard::WizardButton arg2 ;
  QString * cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  arg2 = (QWizard::WizardButton)which; 
  *(QString **)&cresult = new QString((const QString &)((QWizardPage const *)arg1)->buttonText(arg2));
  return cresult;
}


SWIGEXPORT void QWizardPage_initializePage(QWizardPage * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  (arg1)->initializePage();
}


SWIGEXPORT void QWizardPage_cleanupPage(QWizardPage * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  (arg1)->cleanupPage();
}


SWIGEXPORT bool QWizardPage_validatePage(QWizardPage * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  result = (bool)(arg1)->validatePage();
  cresult = result; 
  return cresult;
}


SWIGEXPORT bool QWizardPage_isComplete(QWizardPage const * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  bool result;
  bool cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  result = (bool)((QWizardPage const *)arg1)->isComplete();
  cresult = result; 
  return cresult;
}


SWIGEXPORT int QWizardPage_nextId(QWizardPage const * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  int result;
  int cresult ;
  
  arg1 = *(QWizardPage **)&self; 
  result = (int)((QWizardPage const *)arg1)->nextId();
  cresult = result; 
  return cresult;
}


SWIGEXPORT void Delete_QWizardPage(QWizardPage * self) {
  QWizardPage *arg1 = (QWizardPage *) 0 ;
  
  arg1 = *(QWizardPage **)&self; 
  delete arg1;
}


#ifdef __cplusplus
}
#endif

