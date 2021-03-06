(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtByteArray;

FROM QtNamespace IMPORT Initialization;


TYPE T = QByteArray;

PROCEDURE FromRawData (arg1: TEXT; size: INTEGER; ): QByteArray;

PROCEDURE FromBase64 (base64: QByteArray; ): QByteArray;

PROCEDURE FromHex (hexEncoded: QByteArray; ): QByteArray;

PROCEDURE FromPercentEncoding (pctEncoded: QByteArray; percent: CHAR; ):
  QByteArray;

PROCEDURE FromPercentEncoding1 (pctEncoded: QByteArray; ): QByteArray;


TYPE
  QByteArray <: QByteArrayPublic;
  QByteArrayPublic =
    BRANDED OBJECT
      cxxObj: ADDRESS;
    METHODS
      init_0       (): QByteArray;
      init_1       (arg1: TEXT; ): QByteArray;
      init_2       (arg1: TEXT; size: INTEGER; ): QByteArray;
      init_3       (size: INTEGER; c: CHAR; ): QByteArray;
      init_4       (size: INTEGER; arg2: Initialization; ): QByteArray;
      init_5       (arg1: QByteArray; ): QByteArray;
      size         (): INTEGER;
      isEmpty      (): BOOLEAN;
      resize       (size: INTEGER; );
      fill         (c: CHAR; size: INTEGER; ): QByteArray;
      fill1        (c: CHAR; ): QByteArray;
      capacity     (): INTEGER;
      reserve      (size: INTEGER; );
      squeeze      ();
      data         (): TEXT;
      data1        (): TEXT;
      constData    (): TEXT;
      detach       ();
      isDetached   (): BOOLEAN;
      isSharedWith (other: QByteArray; ): BOOLEAN;
      clear        ();
      count        (c: CHAR; ): INTEGER;
      count1       (a: TEXT; ): INTEGER;
      count2       (a: QByteArray; ): INTEGER;
      left         (len: INTEGER; ): QByteArray;
      right        (len: INTEGER; ): QByteArray;
      mid          (index, len: INTEGER; ): QByteArray;
      mid1         (index: INTEGER; ): QByteArray;
      startsWith   (a: QByteArray; ): BOOLEAN;
      startsWith1  (c: CHAR; ): BOOLEAN;
      startsWith2  (c: TEXT; ): BOOLEAN;
      endsWith     (a: QByteArray; ): BOOLEAN;
      endsWith1    (c: CHAR; ): BOOLEAN;
      endsWith2    (c: TEXT; ): BOOLEAN;
      truncate     (pos: INTEGER; );
      chop         (n: INTEGER; );
      toLower      (): QByteArray;
      toUpper      (): QByteArray;
      trimmed      (): QByteArray;
      simplified   (): QByteArray;
      prepend      (c: CHAR; ): QByteArray;
      prepend1     (s: TEXT; ): QByteArray;
      prepend2     (s: TEXT; len: INTEGER; ): QByteArray;
      prepend3     (a: QByteArray; ): QByteArray;
      remove       (index, len: INTEGER; ): QByteArray;
      repeated     (times: INTEGER; ): QByteArray;
      toShort      (VAR ok: BOOLEAN; base: INTEGER; ): INTEGER;
      toShort1     (VAR ok: BOOLEAN; ): INTEGER;
      toShort2     (): INTEGER;
      toUShort     (VAR ok: BOOLEAN; base: INTEGER; ): CARDINAL;
      toUShort1    (VAR ok: BOOLEAN; ): CARDINAL;
      toUShort2    (): CARDINAL;
      toInt        (VAR ok: BOOLEAN; base: INTEGER; ): INTEGER;
      toInt1       (VAR ok: BOOLEAN; ): INTEGER;
      toInt2       (): INTEGER;
      toUInt       (VAR ok: BOOLEAN; base: INTEGER; ): CARDINAL;
      toUInt1      (VAR ok: BOOLEAN; ): CARDINAL;
      toUInt2      (): CARDINAL;
      toLong       (VAR ok: BOOLEAN; base: INTEGER; ): INTEGER;
      toLong1      (VAR ok: BOOLEAN; ): INTEGER;
      toLong2      (): INTEGER;
      toULong      (VAR ok: BOOLEAN; base: INTEGER; ): CARDINAL;
      toULong1     (VAR ok: BOOLEAN; ): CARDINAL;
      toULong2     (): CARDINAL;
      toFloat      (VAR ok: BOOLEAN; ): REAL;
      toFloat1     (): REAL;
      toDouble     (VAR ok: BOOLEAN; ): LONGREAL;
      toDouble1    (): LONGREAL;
      toBase64     (): QByteArray;
      toHex        (): QByteArray;
      toPercentEncoding (exclude, include: QByteArray; percent: CHAR; ):
                         QByteArray;
      toPercentEncoding1 (exclude, include: QByteArray; ): QByteArray;
      toPercentEncoding2 (exclude: QByteArray; ): QByteArray;
      toPercentEncoding3 (): QByteArray;
      setRawData         (a: TEXT; n: CARDINAL; ): QByteArray;
      push_back          (c: CHAR; );
      push_back1         (c: TEXT; );
      push_back2         (a: QByteArray; );
      push_front         (c: CHAR; );
      push_front1        (c: TEXT; );
      push_front2        (a: QByteArray; );
      count3             (): INTEGER;
      length             (): INTEGER;
      isNull             (): BOOLEAN;
      destroyCxx         ();
    END;


END QtByteArray.
