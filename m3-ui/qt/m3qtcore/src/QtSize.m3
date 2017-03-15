(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtSize;


IMPORT QtSizeRaw;
FROM QtNamespace IMPORT AspectRatioMode;


IMPORT WeakRef;
IMPORT Ctypes AS C;

PROCEDURE New_QSize0 (self: QSize; ): QSize =
  VAR result: ADDRESS;
  BEGIN
    result := QtSizeRaw.New_QSize0();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSize);

    RETURN self;
  END New_QSize0;

PROCEDURE New_QSize1 (self: QSize; w, h: INTEGER; ): QSize =
  VAR result: ADDRESS;
  BEGIN
    result := QtSizeRaw.New_QSize1(w, h);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSize);

    RETURN self;
  END New_QSize1;

PROCEDURE QSize_isNull (self: QSize; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSize_isNull(selfAdr);
  END QSize_isNull;

PROCEDURE QSize_isEmpty (self: QSize; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSize_isEmpty(selfAdr);
  END QSize_isEmpty;

PROCEDURE QSize_isValid (self: QSize; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSize_isValid(selfAdr);
  END QSize_isValid;

PROCEDURE QSize_width (self: QSize; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSize_width(selfAdr);
  END QSize_width;

PROCEDURE QSize_height (self: QSize; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSize_height(selfAdr);
  END QSize_height;

PROCEDURE QSize_setWidth (self: QSize; w: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSize_setWidth(selfAdr, w);
  END QSize_setWidth;

PROCEDURE QSize_setHeight (self: QSize; h: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSize_setHeight(selfAdr, h);
  END QSize_setHeight;

PROCEDURE QSize_transpose (self: QSize; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSize_transpose(selfAdr);
  END QSize_transpose;

PROCEDURE QSize_scale
  (self: QSize; w, h: INTEGER; mode: AspectRatioMode; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSize_scale(selfAdr, w, h, ORD(mode));
  END QSize_scale;

PROCEDURE QSize_scale1 (self, s: QSize; mode: AspectRatioMode; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(s.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSize_scale1(selfAdr, arg2tmp, ORD(mode));
  END QSize_scale1;

PROCEDURE QSize_expandedTo (self, arg2: QSize; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_expandedTo(selfAdr, arg2tmp);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSize_expandedTo;

PROCEDURE QSize_boundedTo (self, arg2: QSize; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_boundedTo(selfAdr, arg2tmp);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSize_boundedTo;

PROCEDURE QSize_rwidth (self: QSize; ): UNTRACED REF INTEGER =
  VAR
    ret    : UNTRACED REF C.int;
    result                      := NEW(UNTRACED REF INTEGER);
    selfAdr: ADDRESS            := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_rwidth(selfAdr);
    result^ := ret^;
    RETURN result;
  END QSize_rwidth;

PROCEDURE QSize_rheight (self: QSize; ): UNTRACED REF INTEGER =
  VAR
    ret    : UNTRACED REF C.int;
    result                      := NEW(UNTRACED REF INTEGER);
    selfAdr: ADDRESS            := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_rheight(selfAdr);
    result^ := ret^;
    RETURN result;
  END QSize_rheight;

PROCEDURE QSize_PlusEqual (self, arg2: QSize; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_PlusEqual(selfAdr, arg2tmp);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSize_PlusEqual;

PROCEDURE QSize_MinusEqual (self, arg2: QSize; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_MinusEqual(selfAdr, arg2tmp);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSize_MinusEqual;

PROCEDURE QSize_MultiplyEqual (self: QSize; c: LONGREAL; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_MultiplyEqual(selfAdr, c);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSize_MultiplyEqual;

PROCEDURE QSize_DivideEqual (self: QSize; c: LONGREAL; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSize_DivideEqual(selfAdr, c);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSize_DivideEqual;

PROCEDURE Delete_QSize (self: QSize; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.Delete_QSize(selfAdr);
  END Delete_QSize;

PROCEDURE Cleanup_QSize
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QSize := ref;
  BEGIN
    Delete_QSize(obj);
  END Cleanup_QSize;

PROCEDURE Destroy_QSize (self: QSize) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QSize);
  END Destroy_QSize;

REVEAL
  QSize = QSizePublic BRANDED OBJECT
          OVERRIDES
            init_0        := New_QSize0;
            init_1        := New_QSize1;
            isNull        := QSize_isNull;
            isEmpty       := QSize_isEmpty;
            isValid       := QSize_isValid;
            width         := QSize_width;
            height        := QSize_height;
            setWidth      := QSize_setWidth;
            setHeight     := QSize_setHeight;
            transpose     := QSize_transpose;
            scale         := QSize_scale;
            scale1        := QSize_scale1;
            expandedTo    := QSize_expandedTo;
            boundedTo     := QSize_boundedTo;
            rwidth        := QSize_rwidth;
            rheight       := QSize_rheight;
            PlusEqual     := QSize_PlusEqual;
            MinusEqual    := QSize_MinusEqual;
            MultiplyEqual := QSize_MultiplyEqual;
            DivideEqual   := QSize_DivideEqual;
            destroyCxx    := Destroy_QSize;
          END;

PROCEDURE New_QSizeF0 (self: QSizeF; ): QSizeF =
  VAR result: ADDRESS;
  BEGIN
    result := QtSizeRaw.New_QSizeF0();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSizeF);

    RETURN self;
  END New_QSizeF0;

PROCEDURE New_QSizeF1 (self: QSizeF; sz: QSize; ): QSizeF =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(sz.cxxObj, ADDRESS);
  BEGIN
    result := QtSizeRaw.New_QSizeF1(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSizeF);

    RETURN self;
  END New_QSizeF1;

PROCEDURE New_QSizeF2 (self: QSizeF; w, h: LONGREAL; ): QSizeF =
  VAR result: ADDRESS;
  BEGIN
    result := QtSizeRaw.New_QSizeF2(w, h);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSizeF);

    RETURN self;
  END New_QSizeF2;

PROCEDURE QSizeF_isNull (self: QSizeF; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSizeF_isNull(selfAdr);
  END QSizeF_isNull;

PROCEDURE QSizeF_isEmpty (self: QSizeF; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSizeF_isEmpty(selfAdr);
  END QSizeF_isEmpty;

PROCEDURE QSizeF_isValid (self: QSizeF; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSizeF_isValid(selfAdr);
  END QSizeF_isValid;

PROCEDURE QSizeF_width (self: QSizeF; ): LONGREAL =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSizeF_width(selfAdr);
  END QSizeF_width;

PROCEDURE QSizeF_height (self: QSizeF; ): LONGREAL =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtSizeRaw.QSizeF_height(selfAdr);
  END QSizeF_height;

PROCEDURE QSizeF_setWidth (self: QSizeF; w: LONGREAL; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSizeF_setWidth(selfAdr, w);
  END QSizeF_setWidth;

PROCEDURE QSizeF_setHeight (self: QSizeF; h: LONGREAL; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSizeF_setHeight(selfAdr, h);
  END QSizeF_setHeight;

PROCEDURE QSizeF_transpose (self: QSizeF; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSizeF_transpose(selfAdr);
  END QSizeF_transpose;

PROCEDURE QSizeF_scale
  (self: QSizeF; w, h: LONGREAL; mode: AspectRatioMode; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSizeF_scale(selfAdr, w, h, ORD(mode));
  END QSizeF_scale;

PROCEDURE QSizeF_scale1 (self, s: QSizeF; mode: AspectRatioMode; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(s.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.QSizeF_scale1(selfAdr, arg2tmp, ORD(mode));
  END QSizeF_scale1;

PROCEDURE QSizeF_expandedTo (self, arg2: QSizeF; ): QSizeF =
  VAR
    ret    : ADDRESS;
    result : QSizeF;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_expandedTo(selfAdr, arg2tmp);

    result := NEW(QSizeF);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_expandedTo;

PROCEDURE QSizeF_boundedTo (self, arg2: QSizeF; ): QSizeF =
  VAR
    ret    : ADDRESS;
    result : QSizeF;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_boundedTo(selfAdr, arg2tmp);

    result := NEW(QSizeF);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_boundedTo;

PROCEDURE QSizeF_rwidth (self: QSizeF; ): UNTRACED REF LONGREAL =
  VAR
    ret    : UNTRACED REF C.double;
    result                         := NEW(UNTRACED REF LONGREAL);
    selfAdr: ADDRESS               := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_rwidth(selfAdr);
    result^ := ret^;
    RETURN result;
  END QSizeF_rwidth;

PROCEDURE QSizeF_rheight (self: QSizeF; ): UNTRACED REF LONGREAL =
  VAR
    ret    : UNTRACED REF C.double;
    result                         := NEW(UNTRACED REF LONGREAL);
    selfAdr: ADDRESS               := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_rheight(selfAdr);
    result^ := ret^;
    RETURN result;
  END QSizeF_rheight;

PROCEDURE QSizeF_PlusEqual (self, arg2: QSizeF; ): QSizeF =
  VAR
    ret    : ADDRESS;
    result : QSizeF;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_PlusEqual(selfAdr, arg2tmp);

    result := NEW(QSizeF);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_PlusEqual;

PROCEDURE QSizeF_MinusEqual (self, arg2: QSizeF; ): QSizeF =
  VAR
    ret    : ADDRESS;
    result : QSizeF;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(arg2.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_MinusEqual(selfAdr, arg2tmp);

    result := NEW(QSizeF);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_MinusEqual;

PROCEDURE QSizeF_MultiplyEqual (self: QSizeF; c: LONGREAL; ): QSizeF =
  VAR
    ret    : ADDRESS;
    result : QSizeF;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_MultiplyEqual(selfAdr, c);

    result := NEW(QSizeF);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_MultiplyEqual;

PROCEDURE QSizeF_DivideEqual (self: QSizeF; c: LONGREAL; ): QSizeF =
  VAR
    ret    : ADDRESS;
    result : QSizeF;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_DivideEqual(selfAdr, c);

    result := NEW(QSizeF);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_DivideEqual;

PROCEDURE QSizeF_toSize (self: QSizeF; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSizeRaw.QSizeF_toSize(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSizeF_toSize;

PROCEDURE Delete_QSizeF (self: QSizeF; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSizeRaw.Delete_QSizeF(selfAdr);
  END Delete_QSizeF;

PROCEDURE Cleanup_QSizeF
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QSizeF := ref;
  BEGIN
    Delete_QSizeF(obj);
  END Cleanup_QSizeF;

PROCEDURE Destroy_QSizeF (self: QSizeF) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QSizeF);
  END Destroy_QSizeF;

REVEAL
  QSizeF = QSizeFPublic BRANDED OBJECT
           OVERRIDES
             init_0        := New_QSizeF0;
             init_1        := New_QSizeF1;
             init_2        := New_QSizeF2;
             isNull        := QSizeF_isNull;
             isEmpty       := QSizeF_isEmpty;
             isValid       := QSizeF_isValid;
             width         := QSizeF_width;
             height        := QSizeF_height;
             setWidth      := QSizeF_setWidth;
             setHeight     := QSizeF_setHeight;
             transpose     := QSizeF_transpose;
             scale         := QSizeF_scale;
             scale1        := QSizeF_scale1;
             expandedTo    := QSizeF_expandedTo;
             boundedTo     := QSizeF_boundedTo;
             rwidth        := QSizeF_rwidth;
             rheight       := QSizeF_rheight;
             PlusEqual     := QSizeF_PlusEqual;
             MinusEqual    := QSizeF_MinusEqual;
             MultiplyEqual := QSizeF_MultiplyEqual;
             DivideEqual   := QSizeF_DivideEqual;
             toSize        := QSizeF_toSize;
             destroyCxx    := Destroy_QSizeF;
           END;


BEGIN
END QtSize.
