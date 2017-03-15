(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtColorDialog;


IMPORT QtRgb;
IMPORT QtColorDialogRaw;
FROM QtColor IMPORT QColor;
FROM QtObject IMPORT QObject;
IMPORT M3toC;
FROM QtWidget IMPORT QWidget;
IMPORT Ctypes AS C;
FROM QtString IMPORT QString;


IMPORT WeakRef;

PROCEDURE New_QColorDialog0 (self: QColorDialog; parent: QWidget; ):
  QColorDialog =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtColorDialogRaw.New_QColorDialog0(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QColorDialog);

    RETURN self;
  END New_QColorDialog0;

PROCEDURE New_QColorDialog1 (self: QColorDialog; ): QColorDialog =
  VAR result: ADDRESS;
  BEGIN
    result := QtColorDialogRaw.New_QColorDialog1();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QColorDialog);

    RETURN self;
  END New_QColorDialog1;

PROCEDURE New_QColorDialog2
  (self: QColorDialog; initial: QColor; parent: QWidget; ): QColorDialog =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(initial.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtColorDialogRaw.New_QColorDialog2(arg1tmp, arg2tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QColorDialog);

    RETURN self;
  END New_QColorDialog2;

PROCEDURE New_QColorDialog3 (self: QColorDialog; initial: QColor; ):
  QColorDialog =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(initial.cxxObj, ADDRESS);
  BEGIN
    result := QtColorDialogRaw.New_QColorDialog3(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QColorDialog);

    RETURN self;
  END New_QColorDialog3;

PROCEDURE Delete_QColorDialog (self: QColorDialog; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.Delete_QColorDialog(selfAdr);
  END Delete_QColorDialog;

PROCEDURE QColorDialog_setCurrentColor
  (self: QColorDialog; color: QColor; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(color.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.QColorDialog_setCurrentColor(selfAdr, arg2tmp);
  END QColorDialog_setCurrentColor;

PROCEDURE QColorDialog_currentColor (self: QColorDialog; ): QColor =
  VAR
    ret    : ADDRESS;
    result : QColor;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtColorDialogRaw.QColorDialog_currentColor(selfAdr);

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QColorDialog_currentColor;

PROCEDURE QColorDialog_selectedColor (self: QColorDialog; ): QColor =
  VAR
    ret    : ADDRESS;
    result : QColor;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtColorDialogRaw.QColorDialog_selectedColor(selfAdr);

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QColorDialog_selectedColor;

PROCEDURE QColorDialog_setOption
  (self: QColorDialog; option: ColorDialogOption; on: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.QColorDialog_setOption(selfAdr, ORD(option), on);
  END QColorDialog_setOption;

PROCEDURE QColorDialog_setOption1
  (self: QColorDialog; option: ColorDialogOption; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.QColorDialog_setOption1(selfAdr, ORD(option));
  END QColorDialog_setOption1;

PROCEDURE QColorDialog_testOption
  (self: QColorDialog; option: ColorDialogOption; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtColorDialogRaw.QColorDialog_testOption(selfAdr, ORD(option));
  END QColorDialog_testOption;

PROCEDURE QColorDialog_setOptions
  (self: QColorDialog; options: ColorDialogOptions; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.QColorDialog_setOptions(selfAdr, ORD(options));
  END QColorDialog_setOptions;

PROCEDURE QColorDialog_options (self: QColorDialog; ): ColorDialogOptions =
  VAR
    ret    : INTEGER;
    result : ColorDialogOptions;
    selfAdr: ADDRESS            := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtColorDialogRaw.QColorDialog_options(selfAdr);
    result := VAL(ret, ColorDialogOptions);
    RETURN result;
  END QColorDialog_options;

PROCEDURE QColorDialog_open0_0 (self: QColorDialog; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.QColorDialog_open0_0(selfAdr);
  END QColorDialog_open0_0;

PROCEDURE QColorDialog_open1
  (self: QColorDialog; receiver: QObject; member: TEXT; ) =
  VAR
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp              := LOOPHOLE(receiver.cxxObj, ADDRESS);
    arg3tmp: C.char_star;
  BEGIN
    arg3tmp := M3toC.CopyTtoS(member);
    QtColorDialogRaw.QColorDialog_open1(selfAdr, arg2tmp, arg3tmp);


  END QColorDialog_open1;

PROCEDURE QColorDialog_setVisible
  (self: QColorDialog; visible: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtColorDialogRaw.QColorDialog_setVisible(selfAdr, visible);
  END QColorDialog_setVisible;

PROCEDURE GetColor (initial: QColor;
                    parent : QWidget;
                    title  : TEXT;
                    options: ColorDialogOptions; ): QColor =
  VAR
    ret       : ADDRESS;
    result    : QColor;
    arg1tmp             := LOOPHOLE(initial.cxxObj, ADDRESS);
    arg2tmp             := LOOPHOLE(parent.cxxObj, ADDRESS);
    qstr_title          := NEW(QString).initQString(title);
    arg3tmp             := LOOPHOLE(qstr_title.cxxObj, ADDRESS);
  BEGIN
    ret :=
      QtColorDialogRaw.GetColor(arg1tmp, arg2tmp, arg3tmp, ORD(options));

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END GetColor;

PROCEDURE GetColor1 (initial: QColor; parent: QWidget; title: TEXT; ):
  QColor =
  VAR
    ret       : ADDRESS;
    result    : QColor;
    arg1tmp             := LOOPHOLE(initial.cxxObj, ADDRESS);
    arg2tmp             := LOOPHOLE(parent.cxxObj, ADDRESS);
    qstr_title          := NEW(QString).initQString(title);
    arg3tmp             := LOOPHOLE(qstr_title.cxxObj, ADDRESS);
  BEGIN
    ret := QtColorDialogRaw.GetColor1(arg1tmp, arg2tmp, arg3tmp);

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END GetColor1;

PROCEDURE GetColor2 (initial: QColor; parent: QWidget; ): QColor =
  VAR
    ret    : ADDRESS;
    result : QColor;
    arg1tmp          := LOOPHOLE(initial.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    ret := QtColorDialogRaw.GetColor2(arg1tmp, arg2tmp);

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END GetColor2;

PROCEDURE GetColor3 (initial: QColor; ): QColor =
  VAR
    ret    : ADDRESS;
    result : QColor;
    arg1tmp          := LOOPHOLE(initial.cxxObj, ADDRESS);
  BEGIN
    ret := QtColorDialogRaw.GetColor3(arg1tmp);

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END GetColor3;

PROCEDURE GetColor4 (): QColor =
  VAR
    ret   : ADDRESS;
    result: QColor;
  BEGIN
    ret := QtColorDialogRaw.GetColor4();

    result := NEW(QColor);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END GetColor4;

PROCEDURE GetRgba (rgba: QtRgb.T; VAR ok: BOOLEAN; parent: QWidget; ):
  QtRgb.T =
  VAR arg3tmp := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    RETURN QtColorDialogRaw.GetRgba(rgba, ok, arg3tmp);
  END GetRgba;

PROCEDURE GetRgba1 (rgba: QtRgb.T; VAR ok: BOOLEAN; ): QtRgb.T =
  BEGIN
    RETURN QtColorDialogRaw.GetRgba1(rgba, ok);
  END GetRgba1;

PROCEDURE GetRgba2 (rgba: QtRgb.T; ): QtRgb.T =
  BEGIN
    RETURN QtColorDialogRaw.GetRgba2(rgba);
  END GetRgba2;

PROCEDURE GetRgba3 (): QtRgb.T =
  BEGIN
    RETURN QtColorDialogRaw.GetRgba3();
  END GetRgba3;

PROCEDURE CustomCount (): INTEGER =
  BEGIN
    RETURN QtColorDialogRaw.CustomCount();
  END CustomCount;

PROCEDURE CustomColor (index: INTEGER; ): QtRgb.T =
  BEGIN
    RETURN QtColorDialogRaw.CustomColor(index);
  END CustomColor;

PROCEDURE SetCustomColor (index: INTEGER; color: QtRgb.T; ) =
  BEGIN
    QtColorDialogRaw.SetCustomColor(index, color);
  END SetCustomColor;

PROCEDURE SetStandardColor (index: INTEGER; color: QtRgb.T; ) =
  BEGIN
    QtColorDialogRaw.SetStandardColor(index, color);
  END SetStandardColor;

PROCEDURE Cleanup_QColorDialog
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QColorDialog := ref;
  BEGIN
    Delete_QColorDialog(obj);
  END Cleanup_QColorDialog;

PROCEDURE Destroy_QColorDialog (self: QColorDialog) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QColorDialog);
  END Destroy_QColorDialog;

REVEAL
  QColorDialog = QColorDialogPublic BRANDED OBJECT
                 OVERRIDES
                   init_0          := New_QColorDialog0;
                   init_1          := New_QColorDialog1;
                   init_2          := New_QColorDialog2;
                   init_3          := New_QColorDialog3;
                   setCurrentColor := QColorDialog_setCurrentColor;
                   currentColor    := QColorDialog_currentColor;
                   selectedColor   := QColorDialog_selectedColor;
                   setOption       := QColorDialog_setOption;
                   setOption1      := QColorDialog_setOption1;
                   testOption      := QColorDialog_testOption;
                   setOptions      := QColorDialog_setOptions;
                   options         := QColorDialog_options;
                   open0_0         := QColorDialog_open0_0;
                   open1           := QColorDialog_open1;
                   setVisible      := QColorDialog_setVisible;
                   destroyCxx      := Destroy_QColorDialog;
                 END;


BEGIN
END QtColorDialog.
