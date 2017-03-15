(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtMenuRaw;


IMPORT Ctypes AS C;




<* EXTERNAL New_QMenu0 *>
PROCEDURE New_QMenu0 (parent: ADDRESS; ): QMenu;

<* EXTERNAL New_QMenu1 *>
PROCEDURE New_QMenu1 (): QMenu;

<* EXTERNAL New_QMenu2 *>
PROCEDURE New_QMenu2 (title, parent: ADDRESS; ): QMenu;

<* EXTERNAL New_QMenu3 *>
PROCEDURE New_QMenu3 (title: ADDRESS; ): QMenu;

<* EXTERNAL Delete_QMenu *>
PROCEDURE Delete_QMenu (self: QMenu; );

<* EXTERNAL QMenu_addAction0_0 *>
PROCEDURE QMenu_addAction0_0 (self: QMenu; action: ADDRESS; );

<* EXTERNAL QMenu_addAction1 *>
PROCEDURE QMenu_addAction1 (self: QMenu; text: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_addAction2 *>
PROCEDURE QMenu_addAction2 (self: QMenu; icon, text: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_addAction3 *>
PROCEDURE QMenu_addAction3 (self          : QMenu;
                            text, receiver: ADDRESS;
                            member        : C.char_star;
                            shortcut      : ADDRESS;     ): ADDRESS;

<* EXTERNAL QMenu_addAction4 *>
PROCEDURE QMenu_addAction4
  (self: QMenu; text, receiver: ADDRESS; member: C.char_star; ): ADDRESS;

<* EXTERNAL QMenu_addAction5 *>
PROCEDURE QMenu_addAction5 (self                : QMenu;
                            icon, text, receiver: ADDRESS;
                            member              : C.char_star;
                            shortcut            : ADDRESS;     ): ADDRESS;

<* EXTERNAL QMenu_addAction6 *>
PROCEDURE QMenu_addAction6
  (self: QMenu; icon, text, receiver: ADDRESS; member: C.char_star; ):
  ADDRESS;

<* EXTERNAL QMenu_addMenu *>
PROCEDURE QMenu_addMenu (self: QMenu; menu: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_addMenu1 *>
PROCEDURE QMenu_addMenu1 (self: QMenu; title: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_addMenu2 *>
PROCEDURE QMenu_addMenu2 (self: QMenu; icon, title: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_addSeparator *>
PROCEDURE QMenu_addSeparator (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_insertMenu *>
PROCEDURE QMenu_insertMenu (self: QMenu; before, menu: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_insertSeparator *>
PROCEDURE QMenu_insertSeparator (self: QMenu; before: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_isEmpty *>
PROCEDURE QMenu_isEmpty (self: QMenu; ): BOOLEAN;

<* EXTERNAL QMenu_clear *>
PROCEDURE QMenu_clear (self: QMenu; );

<* EXTERNAL QMenu_setTearOffEnabled *>
PROCEDURE QMenu_setTearOffEnabled (self: QMenu; arg2: BOOLEAN; );

<* EXTERNAL QMenu_isTearOffEnabled *>
PROCEDURE QMenu_isTearOffEnabled (self: QMenu; ): BOOLEAN;

<* EXTERNAL QMenu_isTearOffMenuVisible *>
PROCEDURE QMenu_isTearOffMenuVisible (self: QMenu; ): BOOLEAN;

<* EXTERNAL QMenu_hideTearOffMenu *>
PROCEDURE QMenu_hideTearOffMenu (self: QMenu; );

<* EXTERNAL QMenu_setDefaultAction *>
PROCEDURE QMenu_setDefaultAction (self: QMenu; arg2: ADDRESS; );

<* EXTERNAL QMenu_defaultAction *>
PROCEDURE QMenu_defaultAction (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_setActiveAction *>
PROCEDURE QMenu_setActiveAction (self: QMenu; act: ADDRESS; );

<* EXTERNAL QMenu_activeAction *>
PROCEDURE QMenu_activeAction (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_popup *>
PROCEDURE QMenu_popup (self: QMenu; pos, at: ADDRESS; );

<* EXTERNAL QMenu_popup1 *>
PROCEDURE QMenu_popup1 (self: QMenu; pos: ADDRESS; );

<* EXTERNAL QMenu_sizeHint *>
PROCEDURE QMenu_sizeHint (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_actionGeometry *>
PROCEDURE QMenu_actionGeometry (self: QMenu; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_actionAt *>
PROCEDURE QMenu_actionAt (self: QMenu; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QMenu_menuAction *>
PROCEDURE QMenu_menuAction (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_title *>
PROCEDURE QMenu_title (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_setTitle *>
PROCEDURE QMenu_setTitle (self: QMenu; title: ADDRESS; );

<* EXTERNAL QMenu_icon *>
PROCEDURE QMenu_icon (self: QMenu; ): ADDRESS;

<* EXTERNAL QMenu_setIcon *>
PROCEDURE QMenu_setIcon (self: QMenu; icon: ADDRESS; );

<* EXTERNAL QMenu_setNoReplayFor *>
PROCEDURE QMenu_setNoReplayFor (self: QMenu; widget: ADDRESS; );

<* EXTERNAL QMenu_separatorsCollapsible *>
PROCEDURE QMenu_separatorsCollapsible (self: QMenu; ): BOOLEAN;

<* EXTERNAL QMenu_setSeparatorsCollapsible *>
PROCEDURE QMenu_setSeparatorsCollapsible
  (self: QMenu; collapse: BOOLEAN; );

TYPE QMenu = ADDRESS;

END QtMenuRaw.
