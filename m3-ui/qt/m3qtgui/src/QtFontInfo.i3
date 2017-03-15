(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtFontInfo;

FROM QtFont IMPORT QFont, Style, StyleHint;


TYPE T = QFontInfo;


TYPE
  QFontInfo <: QFontInfoPublic;
  QFontInfoPublic = BRANDED OBJECT
                      cxxObj: ADDRESS;
                    METHODS
                      init_0     (arg1: QFont; ): QFontInfo;
                      init_1     (arg1: QFontInfo; ): QFontInfo;
                      family     (): TEXT;
                      styleName  (): TEXT;
                      pixelSize  (): INTEGER;
                      pointSize  (): INTEGER;
                      pointSizeF (): LONGREAL;
                      italic     (): BOOLEAN;
                      style      (): Style;
                      weight     (): INTEGER;
                      bold       (): BOOLEAN;
                      underline  (): BOOLEAN;
                      overline   (): BOOLEAN;
                      strikeOut  (): BOOLEAN;
                      fixedPitch (): BOOLEAN;
                      styleHint  (): StyleHint;
                      rawMode    (): BOOLEAN;
                      exactMatch (): BOOLEAN;
                      destroyCxx ();
                    END;


END QtFontInfo.
