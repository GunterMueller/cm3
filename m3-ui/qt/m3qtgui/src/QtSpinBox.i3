(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtSpinBox;

FROM QtWidget IMPORT QWidget;


FROM QtAbstractSpinBox IMPORT QAbstractSpinBox;

TYPE T = QSpinBox;


TYPE
  QSpinBox <: QSpinBoxPublic;
  QSpinBoxPublic = QAbstractSpinBox BRANDED OBJECT
                   METHODS
                     init_0        (parent: QWidget; ): QSpinBox;
                     init_1        (): QSpinBox;
                     value         (): INTEGER;
                     prefix        (): TEXT;
                     setPrefix     (prefix: TEXT; );
                     suffix        (): TEXT;
                     setSuffix     (suffix: TEXT; );
                     cleanText     (): TEXT;
                     singleStep    (): INTEGER;
                     setSingleStep (val: INTEGER; );
                     minimum       (): INTEGER;
                     setMinimum    (min: INTEGER; );
                     maximum       (): INTEGER;
                     setMaximum    (max: INTEGER; );
                     setRange      (min, max: INTEGER; );
                     setValue      (val: INTEGER; );
                     destroyCxx    ();
                   END;

  QDoubleSpinBox <: QDoubleSpinBoxPublic;
  QDoubleSpinBoxPublic =
    QAbstractSpinBox BRANDED OBJECT
    METHODS
      init_0        (parent: QWidget; ): QDoubleSpinBox;
      init_1        (): QDoubleSpinBox;
      value         (): LONGREAL;
      prefix        (): TEXT;
      setPrefix     (prefix: TEXT; );
      suffix        (): TEXT;
      setSuffix     (suffix: TEXT; );
      cleanText     (): TEXT;
      singleStep    (): LONGREAL;
      setSingleStep (val: LONGREAL; );
      minimum       (): LONGREAL;
      setMinimum    (min: LONGREAL; );
      maximum       (): LONGREAL;
      setMaximum    (max: LONGREAL; );
      setRange      (min, max: LONGREAL; );
      decimals      (): INTEGER;
      setDecimals   (prec: INTEGER; );
      valueFromText (text: TEXT; ): LONGREAL; (* virtual *)
      textFromValue (val: LONGREAL; ): TEXT; (* virtual *)
      fixup         (str: TEXT; ); (* virtual *)
      setValue      (val: LONGREAL; );
      destroyCxx    ();
    END;


END QtSpinBox.
