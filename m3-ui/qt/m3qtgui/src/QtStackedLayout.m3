(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtStackedLayout;


FROM QtLayoutItem IMPORT QLayoutItem;
FROM QtSize IMPORT QSize;
FROM QtLayout IMPORT QLayout;
IMPORT QtStackedLayoutRaw;
FROM QtWidget IMPORT QWidget;
FROM QtRect IMPORT QRect;


IMPORT WeakRef;

PROCEDURE New_QStackedLayout0 (self: QStackedLayout; ): QStackedLayout =
  VAR result: ADDRESS;
  BEGIN
    result := QtStackedLayoutRaw.New_QStackedLayout0();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QStackedLayout);

    RETURN self;
  END New_QStackedLayout0;

PROCEDURE New_QStackedLayout1 (self: QStackedLayout; parent: QWidget; ):
  QStackedLayout =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtStackedLayoutRaw.New_QStackedLayout1(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QStackedLayout);

    RETURN self;
  END New_QStackedLayout1;

PROCEDURE New_QStackedLayout2
  (self: QStackedLayout; parentLayout: QLayout; ): QStackedLayout =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parentLayout.cxxObj, ADDRESS);
  BEGIN
    result := QtStackedLayoutRaw.New_QStackedLayout2(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QStackedLayout);

    RETURN self;
  END New_QStackedLayout2;

PROCEDURE Delete_QStackedLayout (self: QStackedLayout; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtStackedLayoutRaw.Delete_QStackedLayout(selfAdr);
  END Delete_QStackedLayout;

PROCEDURE QStackedLayout_addWidget (self: QStackedLayout; w: QWidget; ):
  INTEGER =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(w.cxxObj, ADDRESS);
  BEGIN
    RETURN QtStackedLayoutRaw.QStackedLayout_addWidget(selfAdr, arg2tmp);
  END QStackedLayout_addWidget;

PROCEDURE QStackedLayout_insertWidget
  (self: QStackedLayout; index: INTEGER; w: QWidget; ): INTEGER =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp          := LOOPHOLE(w.cxxObj, ADDRESS);
  BEGIN
    RETURN QtStackedLayoutRaw.QStackedLayout_insertWidget(
             selfAdr, index, arg3tmp);
  END QStackedLayout_insertWidget;

PROCEDURE QStackedLayout_currentWidget (self: QStackedLayout; ): QWidget =
  VAR
    ret    : ADDRESS;
    result : QWidget;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_currentWidget(selfAdr);

    result := NEW(QWidget);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_currentWidget;

PROCEDURE QStackedLayout_currentIndex (self: QStackedLayout; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtStackedLayoutRaw.QStackedLayout_currentIndex(selfAdr);
  END QStackedLayout_currentIndex;

PROCEDURE QStackedLayout_widget0_0 (self: QStackedLayout; ): QWidget =
  VAR
    ret    : ADDRESS;
    result : QWidget;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_widget0_0(selfAdr);

    result := NEW(QWidget);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_widget0_0;

PROCEDURE QStackedLayout_widget1 (self: QStackedLayout; arg2: INTEGER; ):
  QWidget =
  VAR
    ret    : ADDRESS;
    result : QWidget;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_widget1(selfAdr, arg2);

    result := NEW(QWidget);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_widget1;

PROCEDURE QStackedLayout_count (self: QStackedLayout; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtStackedLayoutRaw.QStackedLayout_count(selfAdr);
  END QStackedLayout_count;

PROCEDURE QStackedLayout_stackingMode (self: QStackedLayout; ):
  StackingMode =
  VAR
    ret    : INTEGER;
    result : StackingMode;
    selfAdr: ADDRESS      := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_stackingMode(selfAdr);
    result := VAL(ret, StackingMode);
    RETURN result;
  END QStackedLayout_stackingMode;

PROCEDURE QStackedLayout_setStackingMode
  (self: QStackedLayout; stackingMode: StackingMode; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtStackedLayoutRaw.QStackedLayout_setStackingMode(
      selfAdr, ORD(stackingMode));
  END QStackedLayout_setStackingMode;

PROCEDURE QStackedLayout_addItem
  (self: QStackedLayout; item: QLayoutItem; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(item.cxxObj, ADDRESS);
  BEGIN
    QtStackedLayoutRaw.QStackedLayout_addItem(selfAdr, arg2tmp);
  END QStackedLayout_addItem;

PROCEDURE QStackedLayout_sizeHint (self: QStackedLayout; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_sizeHint(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_sizeHint;

PROCEDURE QStackedLayout_minimumSize (self: QStackedLayout; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_minimumSize(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_minimumSize;

PROCEDURE QStackedLayout_itemAt (self: QStackedLayout; arg2: INTEGER; ):
  QLayoutItem =
  VAR
    ret    : ADDRESS;
    result : QLayoutItem;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_itemAt(selfAdr, arg2);

    result := NEW(QLayoutItem);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_itemAt;

PROCEDURE QStackedLayout_takeAt (self: QStackedLayout; arg2: INTEGER; ):
  QLayoutItem =
  VAR
    ret    : ADDRESS;
    result : QLayoutItem;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtStackedLayoutRaw.QStackedLayout_takeAt(selfAdr, arg2);

    result := NEW(QLayoutItem);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStackedLayout_takeAt;

PROCEDURE QStackedLayout_setGeometry
  (self: QStackedLayout; rect: QRect; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(rect.cxxObj, ADDRESS);
  BEGIN
    QtStackedLayoutRaw.QStackedLayout_setGeometry(selfAdr, arg2tmp);
  END QStackedLayout_setGeometry;

PROCEDURE QStackedLayout_setCurrentIndex
  (self: QStackedLayout; index: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtStackedLayoutRaw.QStackedLayout_setCurrentIndex(selfAdr, index);
  END QStackedLayout_setCurrentIndex;

PROCEDURE QStackedLayout_setCurrentWidget
  (self: QStackedLayout; w: QWidget; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(w.cxxObj, ADDRESS);
  BEGIN
    QtStackedLayoutRaw.QStackedLayout_setCurrentWidget(selfAdr, arg2tmp);
  END QStackedLayout_setCurrentWidget;

PROCEDURE Cleanup_QStackedLayout
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QStackedLayout := ref;
  BEGIN
    Delete_QStackedLayout(obj);
  END Cleanup_QStackedLayout;

PROCEDURE Destroy_QStackedLayout (self: QStackedLayout) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QStackedLayout);
  END Destroy_QStackedLayout;

REVEAL
  QStackedLayout = QStackedLayoutPublic BRANDED OBJECT
                   OVERRIDES
                     init_0           := New_QStackedLayout0;
                     init_1           := New_QStackedLayout1;
                     init_2           := New_QStackedLayout2;
                     addWidget        := QStackedLayout_addWidget;
                     insertWidget     := QStackedLayout_insertWidget;
                     currentWidget    := QStackedLayout_currentWidget;
                     currentIndex     := QStackedLayout_currentIndex;
                     widget0_0        := QStackedLayout_widget0_0;
                     widget1          := QStackedLayout_widget1;
                     count            := QStackedLayout_count;
                     stackingMode     := QStackedLayout_stackingMode;
                     setStackingMode  := QStackedLayout_setStackingMode;
                     addItem          := QStackedLayout_addItem;
                     sizeHint         := QStackedLayout_sizeHint;
                     minimumSize      := QStackedLayout_minimumSize;
                     itemAt           := QStackedLayout_itemAt;
                     takeAt           := QStackedLayout_takeAt;
                     setGeometry      := QStackedLayout_setGeometry;
                     setCurrentIndex  := QStackedLayout_setCurrentIndex;
                     setCurrentWidget := QStackedLayout_setCurrentWidget;
                     destroyCxx       := Destroy_QStackedLayout;
                   END;


BEGIN
END QtStackedLayout.
