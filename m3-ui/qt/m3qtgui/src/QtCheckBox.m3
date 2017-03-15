(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtCheckBox;


IMPORT QtCheckBoxRaw;
FROM QtSize IMPORT QSize;
FROM QtWidget IMPORT QWidget;
FROM QtString IMPORT QString;
FROM QtNamespace IMPORT CheckState;


IMPORT WeakRef;

PROCEDURE New_QCheckBox0 (self: QCheckBox; parent: QWidget; ): QCheckBox =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtCheckBoxRaw.New_QCheckBox0(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QCheckBox);

    RETURN self;
  END New_QCheckBox0;

PROCEDURE New_QCheckBox1 (self: QCheckBox; ): QCheckBox =
  VAR result: ADDRESS;
  BEGIN
    result := QtCheckBoxRaw.New_QCheckBox1();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QCheckBox);

    RETURN self;
  END New_QCheckBox1;

PROCEDURE New_QCheckBox2 (self: QCheckBox; text: TEXT; parent: QWidget; ):
  QCheckBox =
  VAR
    result   : ADDRESS;
    qstr_text          := NEW(QString).initQString(text);
    arg1tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
    arg2tmp            := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtCheckBoxRaw.New_QCheckBox2(arg1tmp, arg2tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QCheckBox);

    RETURN self;
  END New_QCheckBox2;

PROCEDURE New_QCheckBox3 (self: QCheckBox; text: TEXT; ): QCheckBox =
  VAR
    result   : ADDRESS;
    qstr_text          := NEW(QString).initQString(text);
    arg1tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    result := QtCheckBoxRaw.New_QCheckBox3(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QCheckBox);

    RETURN self;
  END New_QCheckBox3;

PROCEDURE QCheckBox_sizeHint (self: QCheckBox; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtCheckBoxRaw.QCheckBox_sizeHint(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QCheckBox_sizeHint;

PROCEDURE QCheckBox_minimumSizeHint (self: QCheckBox; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtCheckBoxRaw.QCheckBox_minimumSizeHint(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QCheckBox_minimumSizeHint;

PROCEDURE QCheckBox_setTristate (self: QCheckBox; y: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtCheckBoxRaw.QCheckBox_setTristate(selfAdr, y);
  END QCheckBox_setTristate;

PROCEDURE QCheckBox_setTristate1 (self: QCheckBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtCheckBoxRaw.QCheckBox_setTristate1(selfAdr);
  END QCheckBox_setTristate1;

PROCEDURE QCheckBox_isTristate (self: QCheckBox; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtCheckBoxRaw.QCheckBox_isTristate(selfAdr);
  END QCheckBox_isTristate;

PROCEDURE QCheckBox_checkState (self: QCheckBox; ): CheckState =
  VAR
    ret    : INTEGER;
    result : CheckState;
    selfAdr: ADDRESS    := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtCheckBoxRaw.QCheckBox_checkState(selfAdr);
    result := VAL(ret, CheckState);
    RETURN result;
  END QCheckBox_checkState;

PROCEDURE QCheckBox_setCheckState (self: QCheckBox; state: CheckState; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtCheckBoxRaw.QCheckBox_setCheckState(selfAdr, ORD(state));
  END QCheckBox_setCheckState;

PROCEDURE Delete_QCheckBox (self: QCheckBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtCheckBoxRaw.Delete_QCheckBox(selfAdr);
  END Delete_QCheckBox;

PROCEDURE Cleanup_QCheckBox
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QCheckBox := ref;
  BEGIN
    Delete_QCheckBox(obj);
  END Cleanup_QCheckBox;

PROCEDURE Destroy_QCheckBox (self: QCheckBox) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QCheckBox);
  END Destroy_QCheckBox;

REVEAL
  QCheckBox = QCheckBoxPublic BRANDED OBJECT
              OVERRIDES
                init_0          := New_QCheckBox0;
                init_1          := New_QCheckBox1;
                init_2          := New_QCheckBox2;
                init_3          := New_QCheckBox3;
                sizeHint        := QCheckBox_sizeHint;
                minimumSizeHint := QCheckBox_minimumSizeHint;
                setTristate     := QCheckBox_setTristate;
                setTristate1    := QCheckBox_setTristate1;
                isTristate      := QCheckBox_isTristate;
                checkState      := QCheckBox_checkState;
                setCheckState   := QCheckBox_setCheckState;
                destroyCxx      := Destroy_QCheckBox;
              END;


BEGIN
END QtCheckBox.
