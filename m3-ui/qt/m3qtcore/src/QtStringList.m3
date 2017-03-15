(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtStringList;


IMPORT QtStringListRaw;
FROM QtNamespace IMPORT CaseSensitivity;


IMPORT WeakRef;
FROM QtString IMPORT QString;
FROM QtByteArray IMPORT QByteArray;

PROCEDURE New_QStringList0 (self: QStringList; ): QStringList =
  VAR result: ADDRESS;
  BEGIN
    result := QtStringListRaw.New_QStringList0();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QStringList);

    RETURN self;
  END New_QStringList0;

PROCEDURE New_QStringList1 (self: QStringList; i: TEXT; ): QStringList =
  VAR
    result: ADDRESS;

    arg1qtmp := NEW(QString).initQString(i);
    arg1tmp  := LOOPHOLE(arg1qtmp.cxxObj, ADDRESS);
  BEGIN
    result := QtStringListRaw.New_QStringList1(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QStringList);

    RETURN self;
  END New_QStringList1;

PROCEDURE QStringList_sort (self: QStringList; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtStringListRaw.QStringList_sort(selfAdr);
  END QStringList_sort;

PROCEDURE QStringList_removeDuplicates (self: QStringList; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtStringListRaw.QStringList_removeDuplicates(selfAdr);
  END QStringList_removeDuplicates;

PROCEDURE QStringList_join (self: QStringList; sep: TEXT; ): TEXT =
  VAR
    ret    : ADDRESS;
    qstr                := NEW(QString);
    ba     : QByteArray;
    result : TEXT;
    selfAdr: ADDRESS    := LOOPHOLE(self.cxxObj, ADDRESS);

    arg2qtmp := NEW(QString).initQString(sep);
    arg2tmp  := LOOPHOLE(arg2qtmp.cxxObj, ADDRESS);
  BEGIN
    ret := QtStringListRaw.QStringList_join(selfAdr, arg2tmp);

    qstr.cxxObj := ret;
    ba := qstr.toLocal8Bit();
    result := ba.data();

    RETURN result;
  END QStringList_join;

PROCEDURE QStringList_filter
  (self: QStringList; str: TEXT; cs: CaseSensitivity; ): QStringList =
  VAR
    ret    : ADDRESS;
    result : QStringList;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);

    arg2qtmp := NEW(QString).initQString(str);
    arg2tmp  := LOOPHOLE(arg2qtmp.cxxObj, ADDRESS);
  BEGIN
    ret := QtStringListRaw.QStringList_filter(selfAdr, arg2tmp, ORD(cs));

    result := NEW(QStringList);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStringList_filter;

PROCEDURE QStringList_filter1 (self: QStringList; str: TEXT; ):
  QStringList =
  VAR
    ret    : ADDRESS;
    result : QStringList;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);

    arg2qtmp := NEW(QString).initQString(str);
    arg2tmp  := LOOPHOLE(arg2qtmp.cxxObj, ADDRESS);
  BEGIN
    ret := QtStringListRaw.QStringList_filter1(selfAdr, arg2tmp);

    result := NEW(QStringList);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStringList_filter1;

PROCEDURE QStringList_replaceInStrings
  (self: QStringList; before, after: TEXT; cs: CaseSensitivity; ):
  QStringList =
  VAR
    ret    : ADDRESS;
    result : QStringList;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);

    arg2qtmp := NEW(QString).initQString(before);
    arg2tmp  := LOOPHOLE(arg2qtmp.cxxObj, ADDRESS);

    arg3qtmp := NEW(QString).initQString(after);
    arg3tmp  := LOOPHOLE(arg3qtmp.cxxObj, ADDRESS);
  BEGIN
    ret := QtStringListRaw.QStringList_replaceInStrings(
             selfAdr, arg2tmp, arg3tmp, ORD(cs));

    result := NEW(QStringList);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStringList_replaceInStrings;

PROCEDURE QStringList_replaceInStrings1
  (self: QStringList; before, after: TEXT; ): QStringList =
  VAR
    ret    : ADDRESS;
    result : QStringList;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);

    arg2qtmp := NEW(QString).initQString(before);
    arg2tmp  := LOOPHOLE(arg2qtmp.cxxObj, ADDRESS);

    arg3qtmp := NEW(QString).initQString(after);
    arg3tmp  := LOOPHOLE(arg3qtmp.cxxObj, ADDRESS);
  BEGIN
    ret := QtStringListRaw.QStringList_replaceInStrings1(
             selfAdr, arg2tmp, arg3tmp);

    result := NEW(QStringList);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QStringList_replaceInStrings1;

PROCEDURE Delete_QStringList (self: QStringList; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtStringListRaw.Delete_QStringList(selfAdr);
  END Delete_QStringList;

PROCEDURE Cleanup_QStringList
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QStringList := ref;
  BEGIN
    Delete_QStringList(obj);
  END Cleanup_QStringList;

PROCEDURE Destroy_QStringList (self: QStringList) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QStringList);
  END Destroy_QStringList;

REVEAL
  QStringList = QStringListPublic BRANDED OBJECT
                OVERRIDES
                  init_0            := New_QStringList0;
                  init_1            := New_QStringList1;
                  sort              := QStringList_sort;
                  removeDuplicates  := QStringList_removeDuplicates;
                  join              := QStringList_join;
                  filter            := QStringList_filter;
                  filter1           := QStringList_filter1;
                  replaceInStrings  := QStringList_replaceInStrings;
                  replaceInStrings1 := QStringList_replaceInStrings1;
                  destroyCxx        := Destroy_QStringList;
                END;


BEGIN
END QtStringList.
