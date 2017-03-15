(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtSignalMapper;


FROM QtObject IMPORT QObject;
IMPORT QtSignalMapperRaw;


IMPORT WeakRef;
FROM QtString IMPORT QString;

PROCEDURE New_QSignalMapper0 (self: QSignalMapper; parent: QObject; ):
  QSignalMapper =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtSignalMapperRaw.New_QSignalMapper0(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSignalMapper);

    RETURN self;
  END New_QSignalMapper0;

PROCEDURE New_QSignalMapper1 (self: QSignalMapper; ): QSignalMapper =
  VAR result: ADDRESS;
  BEGIN
    result := QtSignalMapperRaw.New_QSignalMapper1();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QSignalMapper);

    RETURN self;
  END New_QSignalMapper1;

PROCEDURE Delete_QSignalMapper (self: QSignalMapper; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.Delete_QSignalMapper(selfAdr);
  END Delete_QSignalMapper;

PROCEDURE QSignalMapper_setMapping
  (self: QSignalMapper; sender: QObject; id: INTEGER; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(sender.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_setMapping(selfAdr, arg2tmp, id);
  END QSignalMapper_setMapping;

PROCEDURE QSignalMapper_setMapping1
  (self: QSignalMapper; sender: QObject; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp            := LOOPHOLE(sender.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg3tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_setMapping1(selfAdr, arg2tmp, arg3tmp);
  END QSignalMapper_setMapping1;

PROCEDURE QSignalMapper_setMapping2
  (self: QSignalMapper; sender: QObject; widget: REFANY; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(sender.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_setMapping2(selfAdr, arg2tmp, widget);
  END QSignalMapper_setMapping2;

PROCEDURE QSignalMapper_setMapping3
  (self: QSignalMapper; sender, object: QObject; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(sender.cxxObj, ADDRESS);
    arg3tmp          := LOOPHOLE(object.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_setMapping3(selfAdr, arg2tmp, arg3tmp);
  END QSignalMapper_setMapping3;

PROCEDURE QSignalMapper_removeMappings
  (self: QSignalMapper; sender: QObject; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(sender.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_removeMappings(selfAdr, arg2tmp);
  END QSignalMapper_removeMappings;

PROCEDURE QSignalMapper_mapping (self: QSignalMapper; id: INTEGER; ):
  QObject =
  VAR
    ret    : ADDRESS;
    result : QObject;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSignalMapperRaw.QSignalMapper_mapping(selfAdr, id);

    result := NEW(QObject);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSignalMapper_mapping;

PROCEDURE QSignalMapper_mapping1 (self: QSignalMapper; text: TEXT; ):
  QObject =
  VAR
    ret      : ADDRESS;
    result   : QObject;
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg2tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    ret := QtSignalMapperRaw.QSignalMapper_mapping1(selfAdr, arg2tmp);

    result := NEW(QObject);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSignalMapper_mapping1;

PROCEDURE QSignalMapper_mapping2 (self: QSignalMapper; widget: REFANY; ):
  QObject =
  VAR
    ret    : ADDRESS;
    result : QObject;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtSignalMapperRaw.QSignalMapper_mapping2(selfAdr, widget);

    result := NEW(QObject);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSignalMapper_mapping2;

PROCEDURE QSignalMapper_mapping3 (self: QSignalMapper; object: QObject; ):
  QObject =
  VAR
    ret    : ADDRESS;
    result : QObject;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(object.cxxObj, ADDRESS);
  BEGIN
    ret := QtSignalMapperRaw.QSignalMapper_mapping3(selfAdr, arg2tmp);

    result := NEW(QObject);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QSignalMapper_mapping3;

PROCEDURE QSignalMapper_map (self: QSignalMapper; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_map(selfAdr);
  END QSignalMapper_map;

PROCEDURE QSignalMapper_map1 (self: QSignalMapper; sender: QObject; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(sender.cxxObj, ADDRESS);
  BEGIN
    QtSignalMapperRaw.QSignalMapper_map1(selfAdr, arg2tmp);
  END QSignalMapper_map1;

PROCEDURE Cleanup_QSignalMapper
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QSignalMapper := ref;
  BEGIN
    Delete_QSignalMapper(obj);
  END Cleanup_QSignalMapper;

PROCEDURE Destroy_QSignalMapper (self: QSignalMapper) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QSignalMapper);
  END Destroy_QSignalMapper;

REVEAL
  QSignalMapper = QSignalMapperPublic BRANDED OBJECT
                  OVERRIDES
                    init_0         := New_QSignalMapper0;
                    init_1         := New_QSignalMapper1;
                    setMapping     := QSignalMapper_setMapping;
                    setMapping1    := QSignalMapper_setMapping1;
                    setMapping2    := QSignalMapper_setMapping2;
                    setMapping3    := QSignalMapper_setMapping3;
                    removeMappings := QSignalMapper_removeMappings;
                    mapping        := QSignalMapper_mapping;
                    mapping1       := QSignalMapper_mapping1;
                    mapping2       := QSignalMapper_mapping2;
                    mapping3       := QSignalMapper_mapping3;
                    map            := QSignalMapper_map;
                    map1           := QSignalMapper_map1;
                    destroyCxx     := Destroy_QSignalMapper;
                  END;


BEGIN
END QtSignalMapper.
