(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtUndoView;

FROM QtIcon IMPORT QIcon;
FROM QGuiStubs IMPORT QUndoStack, QUndoGroup;
FROM QtWidget IMPORT QWidget;


FROM QtListView IMPORT QListView;

TYPE T = QUndoView;


TYPE
  QUndoView <: QUndoViewPublic;
  QUndoViewPublic =
    QListView BRANDED OBJECT
    METHODS
      init_0        (parent: QWidget; ): QUndoView;
      init_1        (): QUndoView;
      init_2        (stack: QUndoStack; parent: QWidget; ): QUndoView;
      init_3        (stack: QUndoStack; ): QUndoView;
      init_4        (group: QUndoGroup; parent: QWidget; ): QUndoView;
      init_5        (group: QUndoGroup; ): QUndoView;
      stack         (): QUndoStack;
      group         (): QUndoGroup;
      setEmptyLabel (label: TEXT; );
      emptyLabel    (): TEXT;
      setCleanIcon  (icon: QIcon; );
      cleanIcon     (): QIcon;
      setStack      (stack: QUndoStack; );
      setGroup      (group: QUndoGroup; );
      destroyCxx    ();
    END;


END QtUndoView.
