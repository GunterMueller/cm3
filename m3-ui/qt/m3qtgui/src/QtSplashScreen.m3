(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtSplashScreen;


FROM QtPixmap IMPORT QPixmap;
FROM QtColor IMPORT QColor;
FROM QtWidget IMPORT QWidget;
FROM QtString IMPORT QString;
IMPORT QtSplashScreenRaw;
FROM QtNamespace IMPORT WindowTypes;


IMPORT WeakRef;

PROCEDURE New_QSplashScreen0
  (self: QSplashScreen; pixmap: QPixmap; f: WindowTypes; ): QSplashScreen =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(pixmap.cxxObj, ADDRESS);
  BEGIN
    result := QtSplashScreenRaw.New_QSplashScreen0(arg1tmp, ORD(f));

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);

    RETURN self;
  END New_QSplashScreen0;

PROCEDURE New_QSplashScreen1 (self: QSplashScreen; pixmap: QPixmap; ):
  QSplashScreen =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(pixmap.cxxObj, ADDRESS);
  BEGIN
    result := QtSplashScreenRaw.New_QSplashScreen1(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);

    RETURN self;
  END New_QSplashScreen1;

PROCEDURE New_QSplashScreen2 (self: QSplashScreen; ): QSplashScreen =
  VAR result: ADDRESS;
  BEGIN
    result := QtSplashScreenRaw.New_QSplashScreen2();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);

    RETURN self;
  END New_QSplashScreen2;

PROCEDURE New_QSplashScreen3 (self  : QSplashScreen;
                              parent: QWidget;
                              pixmap: QPixmap;
                              f     : WindowTypes;   ): QSplashScreen =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(pixmap.cxxObj, ADDRESS);
  BEGIN
    result :=
      QtSplashScreenRaw.New_QSplashScreen3(arg1tmp, arg2tmp, ORD(f));

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);

    RETURN self;
  END New_QSplashScreen3;

PROCEDURE New_QSplashScreen4
  (self: QSplashScreen; parent: QWidget; pixmap: QPixmap; ):
  QSplashScreen =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(pixmap.cxxObj, ADDRESS);
  BEGIN
    result := QtSplashScreenRaw.New_QSplashScreen4(arg1tmp, arg2tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);

    RETURN self;
  END New_QSplashScreen4;

PROCEDURE New_QSplashScreen5 (self: QSplashScreen; parent: QWidget; ):
  QSplashScreen =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtSplashScreenRaw.New_QSplashScreen5(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);

    RETURN self;
  END New_QSplashScreen5;

PROCEDURE Delete_QSplashScreen (self: QSplashScreen; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.Delete_QSplashScreen(selfAdr);
  END Delete_QSplashScreen;

PROCEDURE QSplashScreen_setPixmap
  (self: QSplashScreen; pixmap: QPixmap; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(pixmap.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_setPixmap(selfAdr, arg2tmp);
  END QSplashScreen_setPixmap;

PROCEDURE QSplashScreen_pixmap (self: QSplashScreen; ): QPixmap =
  VAR
    ret    : ADDRESS;
    result : QPixmap;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSplashScreenRaw.QSplashScreen_pixmap(selfAdr);

    result := NEW(QPixmap);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSplashScreen_pixmap;

PROCEDURE QSplashScreen_finish (self: QSplashScreen; w: QWidget; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(w.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_finish(selfAdr, arg2tmp);
  END QSplashScreen_finish;

PROCEDURE QSplashScreen_repaint (self: QSplashScreen; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_repaint(selfAdr);
  END QSplashScreen_repaint;

PROCEDURE QSplashScreen_showMessage (self     : QSplashScreen;
                                     message  : TEXT;
                                     alignment: INTEGER;
                                     color    : QColor;        ) =
  VAR
    selfAdr     : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_message          := NEW(QString).initQString(message);
    arg2tmp               := LOOPHOLE(qstr_message.cxxObj, ADDRESS);
    arg4tmp               := LOOPHOLE(color.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_showMessage(
      selfAdr, arg2tmp, alignment, arg4tmp);
  END QSplashScreen_showMessage;

PROCEDURE QSplashScreen_showMessage1
  (self: QSplashScreen; message: TEXT; alignment: INTEGER; ) =
  VAR
    selfAdr     : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_message          := NEW(QString).initQString(message);
    arg2tmp               := LOOPHOLE(qstr_message.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_showMessage1(
      selfAdr, arg2tmp, alignment);
  END QSplashScreen_showMessage1;

PROCEDURE QSplashScreen_showMessage2
  (self: QSplashScreen; message: TEXT; ) =
  VAR
    selfAdr     : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_message          := NEW(QString).initQString(message);
    arg2tmp               := LOOPHOLE(qstr_message.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_showMessage2(selfAdr, arg2tmp);
  END QSplashScreen_showMessage2;

PROCEDURE QSplashScreen_clearMessage (self: QSplashScreen; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSplashScreenRaw.QSplashScreen_clearMessage(selfAdr);
  END QSplashScreen_clearMessage;

PROCEDURE Cleanup_QSplashScreen
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QSplashScreen := ref;
  BEGIN
    Delete_QSplashScreen(obj);
  END Cleanup_QSplashScreen;

PROCEDURE Destroy_QSplashScreen (self: QSplashScreen) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QSplashScreen);
  END Destroy_QSplashScreen;

REVEAL
  QSplashScreen = QSplashScreenPublic BRANDED OBJECT
                  OVERRIDES
                    init_0       := New_QSplashScreen0;
                    init_1       := New_QSplashScreen1;
                    init_2       := New_QSplashScreen2;
                    init_3       := New_QSplashScreen3;
                    init_4       := New_QSplashScreen4;
                    init_5       := New_QSplashScreen5;
                    setPixmap    := QSplashScreen_setPixmap;
                    pixmap       := QSplashScreen_pixmap;
                    finish       := QSplashScreen_finish;
                    repaint      := QSplashScreen_repaint;
                    showMessage  := QSplashScreen_showMessage;
                    showMessage1 := QSplashScreen_showMessage1;
                    showMessage2 := QSplashScreen_showMessage2;
                    clearMessage := QSplashScreen_clearMessage;
                    destroyCxx   := Destroy_QSplashScreen;
                  END;


BEGIN
END QtSplashScreen.
