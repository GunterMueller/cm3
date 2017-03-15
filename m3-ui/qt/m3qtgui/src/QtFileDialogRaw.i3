(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtFileDialogRaw;


IMPORT Ctypes AS C;




<* EXTERNAL New_QFileDialog0 *>
PROCEDURE New_QFileDialog0 (parent: ADDRESS; f: C.int; ): QFileDialog;

<* EXTERNAL New_QFileDialog1 *>
PROCEDURE New_QFileDialog1 (parent, caption, directory, filter: ADDRESS; ):
  QFileDialog;

<* EXTERNAL New_QFileDialog2 *>
PROCEDURE New_QFileDialog2 (parent, caption, directory: ADDRESS; ):
  QFileDialog;

<* EXTERNAL New_QFileDialog3 *>
PROCEDURE New_QFileDialog3 (parent, caption: ADDRESS; ): QFileDialog;

<* EXTERNAL New_QFileDialog4 *>
PROCEDURE New_QFileDialog4 (parent: ADDRESS; ): QFileDialog;

<* EXTERNAL New_QFileDialog5 *>
PROCEDURE New_QFileDialog5 (): QFileDialog;

<* EXTERNAL Delete_QFileDialog *>
PROCEDURE Delete_QFileDialog (self: QFileDialog; );

<* EXTERNAL QFileDialog_setDirectory *>
PROCEDURE QFileDialog_setDirectory
  (self: QFileDialog; directory: ADDRESS; );

<* EXTERNAL QFileDialog_setDirectory1 *>
PROCEDURE QFileDialog_setDirectory1
  (self: QFileDialog; directory: ADDRESS; );

<* EXTERNAL QFileDialog_directory *>
PROCEDURE QFileDialog_directory (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_selectFile *>
PROCEDURE QFileDialog_selectFile (self: QFileDialog; filename: ADDRESS; );

<* EXTERNAL QFileDialog_selectedFiles *>
PROCEDURE QFileDialog_selectedFiles (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setNameFilterDetailsVisible *>
PROCEDURE QFileDialog_setNameFilterDetailsVisible
  (self: QFileDialog; enabled: BOOLEAN; );

<* EXTERNAL QFileDialog_isNameFilterDetailsVisible *>
PROCEDURE QFileDialog_isNameFilterDetailsVisible (self: QFileDialog; ):
  BOOLEAN;

<* EXTERNAL QFileDialog_setNameFilter *>
PROCEDURE QFileDialog_setNameFilter (self: QFileDialog; filter: ADDRESS; );

<* EXTERNAL QFileDialog_setNameFilters *>
PROCEDURE QFileDialog_setNameFilters
  (self: QFileDialog; filters: ADDRESS; );

<* EXTERNAL QFileDialog_nameFilters *>
PROCEDURE QFileDialog_nameFilters (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_selectNameFilter *>
PROCEDURE QFileDialog_selectNameFilter
  (self: QFileDialog; filter: ADDRESS; );

<* EXTERNAL QFileDialog_selectedNameFilter *>
PROCEDURE QFileDialog_selectedNameFilter (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setViewMode *>
PROCEDURE QFileDialog_setViewMode (self: QFileDialog; mode: C.int; );

<* EXTERNAL QFileDialog_viewMode *>
PROCEDURE QFileDialog_viewMode (self: QFileDialog; ): C.int;

<* EXTERNAL QFileDialog_setFileMode *>
PROCEDURE QFileDialog_setFileMode (self: QFileDialog; mode: C.int; );

<* EXTERNAL QFileDialog_fileMode *>
PROCEDURE QFileDialog_fileMode (self: QFileDialog; ): C.int;

<* EXTERNAL QFileDialog_setAcceptMode *>
PROCEDURE QFileDialog_setAcceptMode (self: QFileDialog; mode: C.int; );

<* EXTERNAL QFileDialog_acceptMode *>
PROCEDURE QFileDialog_acceptMode (self: QFileDialog; ): C.int;

<* EXTERNAL QFileDialog_setReadOnly *>
PROCEDURE QFileDialog_setReadOnly (self: QFileDialog; enabled: BOOLEAN; );

<* EXTERNAL QFileDialog_isReadOnly *>
PROCEDURE QFileDialog_isReadOnly (self: QFileDialog; ): BOOLEAN;

<* EXTERNAL QFileDialog_setResolveSymlinks *>
PROCEDURE QFileDialog_setResolveSymlinks
  (self: QFileDialog; enabled: BOOLEAN; );

<* EXTERNAL QFileDialog_resolveSymlinks *>
PROCEDURE QFileDialog_resolveSymlinks (self: QFileDialog; ): BOOLEAN;

<* EXTERNAL QFileDialog_saveState *>
PROCEDURE QFileDialog_saveState (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_restoreState *>
PROCEDURE QFileDialog_restoreState (self: QFileDialog; state: ADDRESS; ):
  BOOLEAN;

<* EXTERNAL QFileDialog_setConfirmOverwrite *>
PROCEDURE QFileDialog_setConfirmOverwrite
  (self: QFileDialog; enabled: BOOLEAN; );

<* EXTERNAL QFileDialog_confirmOverwrite *>
PROCEDURE QFileDialog_confirmOverwrite (self: QFileDialog; ): BOOLEAN;

<* EXTERNAL QFileDialog_setDefaultSuffix *>
PROCEDURE QFileDialog_setDefaultSuffix
  (self: QFileDialog; suffix: ADDRESS; );

<* EXTERNAL QFileDialog_defaultSuffix *>
PROCEDURE QFileDialog_defaultSuffix (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setHistory *>
PROCEDURE QFileDialog_setHistory (self: QFileDialog; paths: ADDRESS; );

<* EXTERNAL QFileDialog_history *>
PROCEDURE QFileDialog_history (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setItemDelegate *>
PROCEDURE QFileDialog_setItemDelegate
  (self: QFileDialog; delegate: ADDRESS; );

<* EXTERNAL QFileDialog_itemDelegate *>
PROCEDURE QFileDialog_itemDelegate (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setIconProvider *>
PROCEDURE QFileDialog_setIconProvider
  (self: QFileDialog; provider: ADDRESS; );

<* EXTERNAL QFileDialog_iconProvider *>
PROCEDURE QFileDialog_iconProvider (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setLabelText *>
PROCEDURE QFileDialog_setLabelText
  (self: QFileDialog; label: C.int; text: ADDRESS; );

<* EXTERNAL QFileDialog_labelText *>
PROCEDURE QFileDialog_labelText (self: QFileDialog; label: C.int; ):
  ADDRESS;

<* EXTERNAL QFileDialog_setProxyModel *>
PROCEDURE QFileDialog_setProxyModel (self: QFileDialog; model: ADDRESS; );

<* EXTERNAL QFileDialog_proxyModel *>
PROCEDURE QFileDialog_proxyModel (self: QFileDialog; ): ADDRESS;

<* EXTERNAL QFileDialog_setOption *>
PROCEDURE QFileDialog_setOption
  (self: QFileDialog; option: C.int; on: BOOLEAN; );

<* EXTERNAL QFileDialog_setOption1 *>
PROCEDURE QFileDialog_setOption1 (self: QFileDialog; option: C.int; );

<* EXTERNAL QFileDialog_testOption *>
PROCEDURE QFileDialog_testOption (self: QFileDialog; option: C.int; ):
  BOOLEAN;

<* EXTERNAL QFileDialog_setOptions *>
PROCEDURE QFileDialog_setOptions (self: QFileDialog; options: C.int; );

<* EXTERNAL QFileDialog_options *>
PROCEDURE QFileDialog_options (self: QFileDialog; ): C.int;

<* EXTERNAL QFileDialog_open0_0 *>
PROCEDURE QFileDialog_open0_0 (self: QFileDialog; );

<* EXTERNAL QFileDialog_open1 *>
PROCEDURE QFileDialog_open1
  (self: QFileDialog; receiver: ADDRESS; member: C.char_star; );

<* EXTERNAL QFileDialog_setVisible *>
PROCEDURE QFileDialog_setVisible (self: QFileDialog; visible: BOOLEAN; );

<* EXTERNAL GetOpenFileName *>
PROCEDURE GetOpenFileName
  (parent, caption, dir, filter, selectedFilter: ADDRESS; options: C.int; ):
  ADDRESS;

<* EXTERNAL GetOpenFileName1 *>
PROCEDURE GetOpenFileName1
  (parent, caption, dir, filter, selectedFilter: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileName2 *>
PROCEDURE GetOpenFileName2 (parent, caption, dir, filter: ADDRESS; ):
  ADDRESS;

<* EXTERNAL GetOpenFileName3 *>
PROCEDURE GetOpenFileName3 (parent, caption, dir: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileName4 *>
PROCEDURE GetOpenFileName4 (parent, caption: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileName5 *>
PROCEDURE GetOpenFileName5 (parent: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileName6 *>
PROCEDURE GetOpenFileName6 (): ADDRESS;

<* EXTERNAL GetSaveFileName *>
PROCEDURE GetSaveFileName
  (parent, caption, dir, filter, selectedFilter: ADDRESS; options: C.int; ):
  ADDRESS;

<* EXTERNAL GetSaveFileName1 *>
PROCEDURE GetSaveFileName1
  (parent, caption, dir, filter, selectedFilter: ADDRESS; ): ADDRESS;

<* EXTERNAL GetSaveFileName2 *>
PROCEDURE GetSaveFileName2 (parent, caption, dir, filter: ADDRESS; ):
  ADDRESS;

<* EXTERNAL GetSaveFileName3 *>
PROCEDURE GetSaveFileName3 (parent, caption, dir: ADDRESS; ): ADDRESS;

<* EXTERNAL GetSaveFileName4 *>
PROCEDURE GetSaveFileName4 (parent, caption: ADDRESS; ): ADDRESS;

<* EXTERNAL GetSaveFileName5 *>
PROCEDURE GetSaveFileName5 (parent: ADDRESS; ): ADDRESS;

<* EXTERNAL GetSaveFileName6 *>
PROCEDURE GetSaveFileName6 (): ADDRESS;

<* EXTERNAL GetExistingDirectory *>
PROCEDURE GetExistingDirectory
  (parent, caption, dir: ADDRESS; options: C.int; ): ADDRESS;

<* EXTERNAL GetExistingDirectory1 *>
PROCEDURE GetExistingDirectory1 (parent, caption, dir: ADDRESS; ): ADDRESS;

<* EXTERNAL GetExistingDirectory2 *>
PROCEDURE GetExistingDirectory2 (parent, caption: ADDRESS; ): ADDRESS;

<* EXTERNAL GetExistingDirectory3 *>
PROCEDURE GetExistingDirectory3 (parent: ADDRESS; ): ADDRESS;

<* EXTERNAL GetExistingDirectory4 *>
PROCEDURE GetExistingDirectory4 (): ADDRESS;

<* EXTERNAL GetOpenFileNames *>
PROCEDURE GetOpenFileNames
  (parent, caption, dir, filter, selectedFilter: ADDRESS; options: C.int; ):
  ADDRESS;

<* EXTERNAL GetOpenFileNames1 *>
PROCEDURE GetOpenFileNames1
  (parent, caption, dir, filter, selectedFilter: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileNames2 *>
PROCEDURE GetOpenFileNames2 (parent, caption, dir, filter: ADDRESS; ):
  ADDRESS;

<* EXTERNAL GetOpenFileNames3 *>
PROCEDURE GetOpenFileNames3 (parent, caption, dir: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileNames4 *>
PROCEDURE GetOpenFileNames4 (parent, caption: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileNames5 *>
PROCEDURE GetOpenFileNames5 (parent: ADDRESS; ): ADDRESS;

<* EXTERNAL GetOpenFileNames6 *>
PROCEDURE GetOpenFileNames6 (): ADDRESS;

TYPE QFileDialog = ADDRESS;

END QtFileDialogRaw.
