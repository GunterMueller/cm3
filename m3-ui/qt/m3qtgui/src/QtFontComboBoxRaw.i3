(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtFontComboBoxRaw;




IMPORT Ctypes AS C;


<* EXTERNAL New_QFontComboBox0 *>
PROCEDURE New_QFontComboBox0 (parent: ADDRESS; ): QFontComboBox;

<* EXTERNAL New_QFontComboBox1 *>
PROCEDURE New_QFontComboBox1 (): QFontComboBox;

<* EXTERNAL Delete_QFontComboBox *>
PROCEDURE Delete_QFontComboBox (self: QFontComboBox; );

<* EXTERNAL QFontComboBox_setFontFilters *>
PROCEDURE QFontComboBox_setFontFilters
  (self: QFontComboBox; filters: C.int; );

<* EXTERNAL QFontComboBox_fontFilters *>
PROCEDURE QFontComboBox_fontFilters (self: QFontComboBox; ): C.int;

<* EXTERNAL QFontComboBox_currentFont *>
PROCEDURE QFontComboBox_currentFont (self: QFontComboBox; ): ADDRESS;

<* EXTERNAL QFontComboBox_sizeHint *>
PROCEDURE QFontComboBox_sizeHint (self: QFontComboBox; ): ADDRESS;

<* EXTERNAL QFontComboBox_setCurrentFont *>
PROCEDURE QFontComboBox_setCurrentFont (self: QFontComboBox; f: ADDRESS; );

TYPE QFontComboBox = ADDRESS;

END QtFontComboBoxRaw.
