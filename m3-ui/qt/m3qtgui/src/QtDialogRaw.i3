(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtDialogRaw;


IMPORT Ctypes AS C;




<* EXTERNAL New_QDialog0 *>
PROCEDURE New_QDialog0 (parent: ADDRESS; f: C.int; ): QDialog;

<* EXTERNAL New_QDialog1 *>
PROCEDURE New_QDialog1 (parent: ADDRESS; ): QDialog;

<* EXTERNAL New_QDialog2 *>
PROCEDURE New_QDialog2 (): QDialog;

<* EXTERNAL Delete_QDialog *>
PROCEDURE Delete_QDialog (self: QDialog; );

<* EXTERNAL QDialog_result *>
PROCEDURE QDialog_result (self: QDialog; ): C.int;

<* EXTERNAL QDialog_setVisible *>
PROCEDURE QDialog_setVisible (self: QDialog; visible: BOOLEAN; );

<* EXTERNAL QDialog_setOrientation *>
PROCEDURE QDialog_setOrientation (self: QDialog; orientation: C.int; );

<* EXTERNAL QDialog_orientation *>
PROCEDURE QDialog_orientation (self: QDialog; ): C.int;

<* EXTERNAL QDialog_setExtension *>
PROCEDURE QDialog_setExtension (self: QDialog; extension: ADDRESS; );

<* EXTERNAL QDialog_extension *>
PROCEDURE QDialog_extension (self: QDialog; ): ADDRESS;

<* EXTERNAL QDialog_sizeHint *>
PROCEDURE QDialog_sizeHint (self: QDialog; ): ADDRESS;

<* EXTERNAL QDialog_minimumSizeHint *>
PROCEDURE QDialog_minimumSizeHint (self: QDialog; ): ADDRESS;

<* EXTERNAL QDialog_setSizeGripEnabled *>
PROCEDURE QDialog_setSizeGripEnabled (self: QDialog; arg2: BOOLEAN; );

<* EXTERNAL QDialog_isSizeGripEnabled *>
PROCEDURE QDialog_isSizeGripEnabled (self: QDialog; ): BOOLEAN;

<* EXTERNAL QDialog_setModal *>
PROCEDURE QDialog_setModal (self: QDialog; modal: BOOLEAN; );

<* EXTERNAL QDialog_setResult *>
PROCEDURE QDialog_setResult (self: QDialog; r: C.int; );

<* EXTERNAL QDialog_open *>
PROCEDURE QDialog_open (self: QDialog; );

<* EXTERNAL QDialog_exec *>
PROCEDURE QDialog_exec (self: QDialog; ): C.int;

<* EXTERNAL QDialog_done *>
PROCEDURE QDialog_done (self: QDialog; arg2: C.int; );

<* EXTERNAL QDialog_accept *>
PROCEDURE QDialog_accept (self: QDialog; );

<* EXTERNAL QDialog_reject *>
PROCEDURE QDialog_reject (self: QDialog; );

<* EXTERNAL QDialog_showExtension *>
PROCEDURE QDialog_showExtension (self: QDialog; arg2: BOOLEAN; );

TYPE QDialog = ADDRESS;

END QtDialogRaw.
