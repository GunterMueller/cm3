(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtFontDialog;

FROM QtFont IMPORT QFont;
FROM QtObject IMPORT QObject;
FROM QtWidget IMPORT QWidget;


FROM QtDialog IMPORT QDialog;

TYPE
  T = QFontDialog;
  FontDialogOptions = INTEGER;


CONST                            (* Enum FontDialogOption *)
  NoButtons           = 1;
  DontUseNativeDialog = 2;

TYPE                             (* Enum FontDialogOption *)
  FontDialogOption = [1 .. 2];

PROCEDURE GetFont (VAR ok     : BOOLEAN;
                       initial: QFont;
                       parent : QWidget;
                       title  : TEXT;
                       options: FontDialogOptions; ): QFont;

PROCEDURE GetFont1
  (VAR ok: BOOLEAN; initial: QFont; parent: QWidget; title: TEXT; ): QFont;

PROCEDURE GetFont2 (VAR ok: BOOLEAN; initial: QFont; parent: QWidget; ):
  QFont;

PROCEDURE GetFont3 (VAR ok: BOOLEAN; initial: QFont; ): QFont;

PROCEDURE GetFont4 (VAR ok: BOOLEAN; parent: QWidget; ): QFont;

PROCEDURE GetFont5 (VAR ok: BOOLEAN; ): QFont;


TYPE
  QFontDialog <: QFontDialogPublic;
  QFontDialogPublic =
    QDialog BRANDED OBJECT
    METHODS
      init_0         (parent: QWidget; ): QFontDialog;
      init_1         (): QFontDialog;
      init_2         (initial: QFont; parent: QWidget; ): QFontDialog;
      init_3         (initial: QFont; ): QFontDialog;
      setCurrentFont (font: QFont; );
      currentFont    (): QFont;
      selectedFont   (): QFont;
      setOption      (option: FontDialogOption; on: BOOLEAN; );
      setOption1     (option: FontDialogOption; );
      testOption     (option: FontDialogOption; ): BOOLEAN;
      setOptions     (options: FontDialogOptions; );
      options        (): FontDialogOptions;
      open0_0        ();
      open1          (receiver: QObject; member: TEXT; );
      setVisible     (visible: BOOLEAN; ); (* virtual *)
      destroyCxx     ();
    END;


END QtFontDialog.
