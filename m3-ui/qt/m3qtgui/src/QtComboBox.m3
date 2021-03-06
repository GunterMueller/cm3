(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

UNSAFE MODULE QtComboBox;


FROM QtIcon IMPORT QIcon;
FROM QtStringList IMPORT QStringList;
IMPORT QtComboBoxRaw;
FROM QtSize IMPORT QSize;
FROM QtAbstractItemDelegate IMPORT QAbstractItemDelegate;
FROM QtAbstractItemModel IMPORT QAbstractItemModel, QModelIndex;
FROM QtEvent IMPORT QEvent;
FROM QGuiStubs IMPORT QValidator, QVariant, QCompleter;
FROM QtWidget IMPORT QWidget;
FROM QtString IMPORT QString;
FROM QtLineEdit IMPORT QLineEdit;
FROM QtNamespace IMPORT CaseSensitivity, MatchFlags;
FROM QtAbstractItemView IMPORT QAbstractItemView;


IMPORT WeakRef;
FROM QtByteArray IMPORT QByteArray;

PROCEDURE New_QComboBox0 (self: QComboBox; parent: QWidget; ): QComboBox =
  VAR
    result : ADDRESS;
    arg1tmp          := LOOPHOLE(parent.cxxObj, ADDRESS);
  BEGIN
    result := QtComboBoxRaw.New_QComboBox0(arg1tmp);

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QComboBox);

    RETURN self;
  END New_QComboBox0;

PROCEDURE New_QComboBox1 (self: QComboBox; ): QComboBox =
  VAR result: ADDRESS;
  BEGIN
    result := QtComboBoxRaw.New_QComboBox1();

    self.cxxObj := result;
    EVAL WeakRef.FromRef(self, Cleanup_QComboBox);

    RETURN self;
  END New_QComboBox1;

PROCEDURE Delete_QComboBox (self: QComboBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.Delete_QComboBox(selfAdr);
  END Delete_QComboBox;

PROCEDURE QComboBox_maxVisibleItems (self: QComboBox; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_maxVisibleItems(selfAdr);
  END QComboBox_maxVisibleItems;

PROCEDURE QComboBox_setMaxVisibleItems
  (self: QComboBox; maxItems: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setMaxVisibleItems(selfAdr, maxItems);
  END QComboBox_setMaxVisibleItems;

PROCEDURE QComboBox_count (self: QComboBox; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_count(selfAdr);
  END QComboBox_count;

PROCEDURE QComboBox_setMaxCount (self: QComboBox; max: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setMaxCount(selfAdr, max);
  END QComboBox_setMaxCount;

PROCEDURE QComboBox_maxCount (self: QComboBox; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_maxCount(selfAdr);
  END QComboBox_maxCount;

PROCEDURE QComboBox_autoCompletion (self: QComboBox; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_autoCompletion(selfAdr);
  END QComboBox_autoCompletion;

PROCEDURE QComboBox_setAutoCompletion
  (self: QComboBox; enable: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setAutoCompletion(selfAdr, enable);
  END QComboBox_setAutoCompletion;

PROCEDURE QComboBox_autoCompletionCaseSensitivity (self: QComboBox; ):
  CaseSensitivity =
  VAR
    ret    : INTEGER;
    result : CaseSensitivity;
    selfAdr: ADDRESS         := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_autoCompletionCaseSensitivity(selfAdr);
    result := VAL(ret, CaseSensitivity);
    RETURN result;
  END QComboBox_autoCompletionCaseSensitivity;

PROCEDURE QComboBox_setAutoCompletionCaseSensitivity
  (self: QComboBox; sensitivity: CaseSensitivity; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setAutoCompletionCaseSensitivity(
      selfAdr, ORD(sensitivity));
  END QComboBox_setAutoCompletionCaseSensitivity;

PROCEDURE QComboBox_duplicatesEnabled (self: QComboBox; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_duplicatesEnabled(selfAdr);
  END QComboBox_duplicatesEnabled;

PROCEDURE QComboBox_setDuplicatesEnabled
  (self: QComboBox; enable: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setDuplicatesEnabled(selfAdr, enable);
  END QComboBox_setDuplicatesEnabled;

PROCEDURE QComboBox_setFrame (self: QComboBox; arg2: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setFrame(selfAdr, arg2);
  END QComboBox_setFrame;

PROCEDURE QComboBox_hasFrame (self: QComboBox; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_hasFrame(selfAdr);
  END QComboBox_hasFrame;

PROCEDURE QComboBox_findText
  (self: QComboBox; text: TEXT; flags: MatchFlags; ): INTEGER =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg2tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_findText(selfAdr, arg2tmp, ORD(flags));
  END QComboBox_findText;

PROCEDURE QComboBox_findText1 (self: QComboBox; text: TEXT; ): INTEGER =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg2tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_findText1(selfAdr, arg2tmp);
  END QComboBox_findText1;

PROCEDURE QComboBox_findData
  (self: QComboBox; data: QVariant; role: INTEGER; flags: MatchFlags; ):
  INTEGER =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(data.cxxObj, ADDRESS);
  BEGIN
    RETURN
      QtComboBoxRaw.QComboBox_findData(selfAdr, arg2tmp, role, ORD(flags));
  END QComboBox_findData;

PROCEDURE QComboBox_findData1
  (self: QComboBox; data: QVariant; role: INTEGER; ): INTEGER =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(data.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_findData1(selfAdr, arg2tmp, role);
  END QComboBox_findData1;

PROCEDURE QComboBox_findData2 (self: QComboBox; data: QVariant; ):
  INTEGER =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(data.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_findData2(selfAdr, arg2tmp);
  END QComboBox_findData2;

PROCEDURE QComboBox_insertPolicy (self: QComboBox; ): InsertPolicy =
  VAR
    ret    : INTEGER;
    result : InsertPolicy;
    selfAdr: ADDRESS      := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_insertPolicy(selfAdr);
    result := VAL(ret, InsertPolicy);
    RETURN result;
  END QComboBox_insertPolicy;

PROCEDURE QComboBox_setInsertPolicy
  (self: QComboBox; policy: InsertPolicy; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setInsertPolicy(selfAdr, ORD(policy));
  END QComboBox_setInsertPolicy;

PROCEDURE QComboBox_sizeAdjustPolicy (self: QComboBox; ):
  SizeAdjustPolicy =
  VAR
    ret    : INTEGER;
    result : SizeAdjustPolicy;
    selfAdr: ADDRESS          := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_sizeAdjustPolicy(selfAdr);
    result := VAL(ret, SizeAdjustPolicy);
    RETURN result;
  END QComboBox_sizeAdjustPolicy;

PROCEDURE QComboBox_setSizeAdjustPolicy
  (self: QComboBox; policy: SizeAdjustPolicy; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setSizeAdjustPolicy(selfAdr, ORD(policy));
  END QComboBox_setSizeAdjustPolicy;

PROCEDURE QComboBox_minimumContentsLength (self: QComboBox; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_minimumContentsLength(selfAdr);
  END QComboBox_minimumContentsLength;

PROCEDURE QComboBox_setMinimumContentsLength
  (self: QComboBox; characters: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setMinimumContentsLength(selfAdr, characters);
  END QComboBox_setMinimumContentsLength;

PROCEDURE QComboBox_iconSize (self: QComboBox; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_iconSize(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_iconSize;

PROCEDURE QComboBox_setIconSize (self: QComboBox; size: QSize; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(size.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setIconSize(selfAdr, arg2tmp);
  END QComboBox_setIconSize;

PROCEDURE QComboBox_isEditable (self: QComboBox; ): BOOLEAN =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_isEditable(selfAdr);
  END QComboBox_isEditable;

PROCEDURE QComboBox_setEditable (self: QComboBox; editable: BOOLEAN; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setEditable(selfAdr, editable);
  END QComboBox_setEditable;

PROCEDURE QComboBox_setLineEdit (self: QComboBox; edit: QLineEdit; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(edit.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setLineEdit(selfAdr, arg2tmp);
  END QComboBox_setLineEdit;

PROCEDURE QComboBox_lineEdit (self: QComboBox; ): QLineEdit =
  VAR
    ret    : ADDRESS;
    result : QLineEdit;
    selfAdr: ADDRESS   := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_lineEdit(selfAdr);

    result := NEW(QLineEdit);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_lineEdit;

PROCEDURE QComboBox_setValidator (self: QComboBox; v: QValidator; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(v.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setValidator(selfAdr, arg2tmp);
  END QComboBox_setValidator;

PROCEDURE QComboBox_validator (self: QComboBox; ): QValidator =
  VAR
    ret    : ADDRESS;
    result : QValidator;
    selfAdr: ADDRESS    := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_validator(selfAdr);

    result := NEW(QValidator);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_validator;

PROCEDURE QComboBox_setCompleter (self: QComboBox; c: QCompleter; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(c.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setCompleter(selfAdr, arg2tmp);
  END QComboBox_setCompleter;

PROCEDURE QComboBox_completer (self: QComboBox; ): QCompleter =
  VAR
    ret    : ADDRESS;
    result : QCompleter;
    selfAdr: ADDRESS    := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_completer(selfAdr);

    result := NEW(QCompleter);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_completer;

PROCEDURE QComboBox_itemDelegate (self: QComboBox; ):
  QAbstractItemDelegate =
  VAR
    ret    : ADDRESS;
    result : QAbstractItemDelegate;
    selfAdr: ADDRESS               := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_itemDelegate(selfAdr);

    result := NEW(QAbstractItemDelegate);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_itemDelegate;

PROCEDURE QComboBox_setItemDelegate
  (self: QComboBox; delegate: QAbstractItemDelegate; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(delegate.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setItemDelegate(selfAdr, arg2tmp);
  END QComboBox_setItemDelegate;

PROCEDURE QComboBox_model (self: QComboBox; ): QAbstractItemModel =
  VAR
    ret    : ADDRESS;
    result : QAbstractItemModel;
    selfAdr: ADDRESS            := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_model(selfAdr);

    result := NEW(QAbstractItemModel);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_model;

PROCEDURE QComboBox_setModel
  (self: QComboBox; model: QAbstractItemModel; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(model.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setModel(selfAdr, arg2tmp);
  END QComboBox_setModel;

PROCEDURE QComboBox_rootModelIndex (self: QComboBox; ): QModelIndex =
  VAR
    ret    : ADDRESS;
    result : QModelIndex;
    selfAdr: ADDRESS     := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_rootModelIndex(selfAdr);

    result := NEW(QModelIndex);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_rootModelIndex;

PROCEDURE QComboBox_setRootModelIndex
  (self: QComboBox; index: QModelIndex; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(index.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setRootModelIndex(selfAdr, arg2tmp);
  END QComboBox_setRootModelIndex;

PROCEDURE QComboBox_modelColumn (self: QComboBox; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_modelColumn(selfAdr);
  END QComboBox_modelColumn;

PROCEDURE QComboBox_setModelColumn
  (self: QComboBox; visibleColumn: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setModelColumn(selfAdr, visibleColumn);
  END QComboBox_setModelColumn;

PROCEDURE QComboBox_currentIndex (self: QComboBox; ): INTEGER =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_currentIndex(selfAdr);
  END QComboBox_currentIndex;

PROCEDURE QComboBox_currentText (self: QComboBox; ): TEXT =
  VAR
    ret    : ADDRESS;
    qstr                := NEW(QString);
    ba     : QByteArray;
    result : TEXT;
    selfAdr: ADDRESS    := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_currentText(selfAdr);

    qstr.cxxObj := ret;
    ba := qstr.toLocal8Bit();
    result := ba.data();

    RETURN result;
  END QComboBox_currentText;

PROCEDURE QComboBox_itemText (self: QComboBox; index: INTEGER; ): TEXT =
  VAR
    ret    : ADDRESS;
    qstr                := NEW(QString);
    ba     : QByteArray;
    result : TEXT;
    selfAdr: ADDRESS    := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_itemText(selfAdr, index);

    qstr.cxxObj := ret;
    ba := qstr.toLocal8Bit();
    result := ba.data();

    RETURN result;
  END QComboBox_itemText;

PROCEDURE QComboBox_itemIcon (self: QComboBox; index: INTEGER; ): QIcon =
  VAR
    ret    : ADDRESS;
    result : QIcon;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_itemIcon(selfAdr, index);

    result := NEW(QIcon);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_itemIcon;

PROCEDURE QComboBox_itemData (self: QComboBox; index, role: INTEGER; ):
  QVariant =
  VAR
    ret    : ADDRESS;
    result : QVariant;
    selfAdr: ADDRESS  := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_itemData(selfAdr, index, role);

    result := NEW(QVariant);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_itemData;

PROCEDURE QComboBox_itemData1 (self: QComboBox; index: INTEGER; ):
  QVariant =
  VAR
    ret    : ADDRESS;
    result : QVariant;
    selfAdr: ADDRESS  := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_itemData1(selfAdr, index);

    result := NEW(QVariant);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_itemData1;

PROCEDURE QComboBox_addItem
  (self: QComboBox; text: TEXT; userData: QVariant; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg2tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
    arg3tmp            := LOOPHOLE(userData.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_addItem(selfAdr, arg2tmp, arg3tmp);
  END QComboBox_addItem;

PROCEDURE QComboBox_addItem1 (self: QComboBox; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg2tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_addItem1(selfAdr, arg2tmp);
  END QComboBox_addItem1;

PROCEDURE QComboBox_addItem2
  (self: QComboBox; icon: QIcon; text: TEXT; userData: QVariant; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp            := LOOPHOLE(icon.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg3tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
    arg4tmp            := LOOPHOLE(userData.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_addItem2(selfAdr, arg2tmp, arg3tmp, arg4tmp);
  END QComboBox_addItem2;

PROCEDURE QComboBox_addItem3 (self: QComboBox; icon: QIcon; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp            := LOOPHOLE(icon.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg3tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_addItem3(selfAdr, arg2tmp, arg3tmp);
  END QComboBox_addItem3;

PROCEDURE QComboBox_addItems (self: QComboBox; texts: QStringList; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(texts.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_addItems(selfAdr, arg2tmp);
  END QComboBox_addItems;

PROCEDURE QComboBox_insertItem
  (self: QComboBox; index: INTEGER; text: TEXT; userData: QVariant; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg3tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
    arg4tmp            := LOOPHOLE(userData.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_insertItem(selfAdr, index, arg3tmp, arg4tmp);
  END QComboBox_insertItem;

PROCEDURE QComboBox_insertItem1
  (self: QComboBox; index: INTEGER; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg3tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_insertItem1(selfAdr, index, arg3tmp);
  END QComboBox_insertItem1;

PROCEDURE QComboBox_insertItem2 (self    : QComboBox;
                                 index   : INTEGER;
                                 icon    : QIcon;
                                 text    : TEXT;
                                 userData: QVariant;  ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp            := LOOPHOLE(icon.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg4tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
    arg5tmp            := LOOPHOLE(userData.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_insertItem2(
      selfAdr, index, arg3tmp, arg4tmp, arg5tmp);
  END QComboBox_insertItem2;

PROCEDURE QComboBox_insertItem3
  (self: QComboBox; index: INTEGER; icon: QIcon; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp            := LOOPHOLE(icon.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg4tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_insertItem3(selfAdr, index, arg3tmp, arg4tmp);
  END QComboBox_insertItem3;

PROCEDURE QComboBox_insertItems
  (self: QComboBox; index: INTEGER; texts: QStringList; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp          := LOOPHOLE(texts.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_insertItems(selfAdr, index, arg3tmp);
  END QComboBox_insertItems;

PROCEDURE QComboBox_insertSeparator (self: QComboBox; index: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_insertSeparator(selfAdr, index);
  END QComboBox_insertSeparator;

PROCEDURE QComboBox_removeItem (self: QComboBox; index: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_removeItem(selfAdr, index);
  END QComboBox_removeItem;

PROCEDURE QComboBox_setItemText
  (self: QComboBox; index: INTEGER; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg3tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setItemText(selfAdr, index, arg3tmp);
  END QComboBox_setItemText;

PROCEDURE QComboBox_setItemIcon
  (self: QComboBox; index: INTEGER; icon: QIcon; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp          := LOOPHOLE(icon.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setItemIcon(selfAdr, index, arg3tmp);
  END QComboBox_setItemIcon;

PROCEDURE QComboBox_setItemData
  (self: QComboBox; index: INTEGER; value: QVariant; role: INTEGER; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp          := LOOPHOLE(value.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setItemData(selfAdr, index, arg3tmp, role);
  END QComboBox_setItemData;

PROCEDURE QComboBox_setItemData1
  (self: QComboBox; index: INTEGER; value: QVariant; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg3tmp          := LOOPHOLE(value.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setItemData1(selfAdr, index, arg3tmp);
  END QComboBox_setItemData1;

PROCEDURE QComboBox_view (self: QComboBox; ): QAbstractItemView =
  VAR
    ret    : ADDRESS;
    result : QAbstractItemView;
    selfAdr: ADDRESS           := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_view(selfAdr);

    result := NEW(QAbstractItemView);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_view;

PROCEDURE QComboBox_setView
  (self: QComboBox; itemView: QAbstractItemView; ) =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(itemView.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setView(selfAdr, arg2tmp);
  END QComboBox_setView;

PROCEDURE QComboBox_sizeHint (self: QComboBox; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_sizeHint(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_sizeHint;

PROCEDURE QComboBox_minimumSizeHint (self: QComboBox; ): QSize =
  VAR
    ret    : ADDRESS;
    result : QSize;
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    ret := QtComboBoxRaw.QComboBox_minimumSizeHint(selfAdr);

    result := NEW(QSize);
    result.cxxObj := ret;
    result.destroyCxx();

    RETURN result;
  END QComboBox_minimumSizeHint;

PROCEDURE QComboBox_showPopup (self: QComboBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_showPopup(selfAdr);
  END QComboBox_showPopup;

PROCEDURE QComboBox_hidePopup (self: QComboBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_hidePopup(selfAdr);
  END QComboBox_hidePopup;

PROCEDURE QComboBox_event (self: QComboBox; event: QEvent; ): BOOLEAN =
  VAR
    selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    arg2tmp          := LOOPHOLE(event.cxxObj, ADDRESS);
  BEGIN
    RETURN QtComboBoxRaw.QComboBox_event(selfAdr, arg2tmp);
  END QComboBox_event;

PROCEDURE QComboBox_clear (self: QComboBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_clear(selfAdr);
  END QComboBox_clear;

PROCEDURE QComboBox_clearEditText (self: QComboBox; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_clearEditText(selfAdr);
  END QComboBox_clearEditText;

PROCEDURE QComboBox_setEditText (self: QComboBox; text: TEXT; ) =
  VAR
    selfAdr  : ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
    qstr_text          := NEW(QString).initQString(text);
    arg2tmp            := LOOPHOLE(qstr_text.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setEditText(selfAdr, arg2tmp);
  END QComboBox_setEditText;

PROCEDURE QComboBox_setCurrentIndex (self: QComboBox; index: INTEGER; ) =
  VAR selfAdr: ADDRESS := LOOPHOLE(self.cxxObj, ADDRESS);
  BEGIN
    QtComboBoxRaw.QComboBox_setCurrentIndex(selfAdr, index);
  END QComboBox_setCurrentIndex;

PROCEDURE Cleanup_QComboBox
  (<* UNUSED *> READONLY self: WeakRef.T; ref: REFANY) =
  VAR obj: QComboBox := ref;
  BEGIN
    Delete_QComboBox(obj);
  END Cleanup_QComboBox;

PROCEDURE Destroy_QComboBox (self: QComboBox) =
  BEGIN
    EVAL WeakRef.FromRef(self, Cleanup_QComboBox);
  END Destroy_QComboBox;

REVEAL
  QComboBox =
    QComboBoxPublic BRANDED OBJECT
    OVERRIDES
      init_0             := New_QComboBox0;
      init_1             := New_QComboBox1;
      maxVisibleItems    := QComboBox_maxVisibleItems;
      setMaxVisibleItems := QComboBox_setMaxVisibleItems;
      count              := QComboBox_count;
      setMaxCount        := QComboBox_setMaxCount;
      maxCount           := QComboBox_maxCount;
      autoCompletion     := QComboBox_autoCompletion;
      setAutoCompletion  := QComboBox_setAutoCompletion;
      autoCompletionCaseSensitivity := QComboBox_autoCompletionCaseSensitivity;
      setAutoCompletionCaseSensitivity := QComboBox_setAutoCompletionCaseSensitivity;
      duplicatesEnabled        := QComboBox_duplicatesEnabled;
      setDuplicatesEnabled     := QComboBox_setDuplicatesEnabled;
      setFrame                 := QComboBox_setFrame;
      hasFrame                 := QComboBox_hasFrame;
      findText                 := QComboBox_findText;
      findText1                := QComboBox_findText1;
      findData                 := QComboBox_findData;
      findData1                := QComboBox_findData1;
      findData2                := QComboBox_findData2;
      insertPolicy             := QComboBox_insertPolicy;
      setInsertPolicy          := QComboBox_setInsertPolicy;
      sizeAdjustPolicy         := QComboBox_sizeAdjustPolicy;
      setSizeAdjustPolicy      := QComboBox_setSizeAdjustPolicy;
      minimumContentsLength    := QComboBox_minimumContentsLength;
      setMinimumContentsLength := QComboBox_setMinimumContentsLength;
      iconSize                 := QComboBox_iconSize;
      setIconSize              := QComboBox_setIconSize;
      isEditable               := QComboBox_isEditable;
      setEditable              := QComboBox_setEditable;
      setLineEdit              := QComboBox_setLineEdit;
      lineEdit                 := QComboBox_lineEdit;
      setValidator             := QComboBox_setValidator;
      validator                := QComboBox_validator;
      setCompleter             := QComboBox_setCompleter;
      completer                := QComboBox_completer;
      itemDelegate             := QComboBox_itemDelegate;
      setItemDelegate          := QComboBox_setItemDelegate;
      model                    := QComboBox_model;
      setModel                 := QComboBox_setModel;
      rootModelIndex           := QComboBox_rootModelIndex;
      setRootModelIndex        := QComboBox_setRootModelIndex;
      modelColumn              := QComboBox_modelColumn;
      setModelColumn           := QComboBox_setModelColumn;
      currentIndex             := QComboBox_currentIndex;
      currentText              := QComboBox_currentText;
      itemText                 := QComboBox_itemText;
      itemIcon                 := QComboBox_itemIcon;
      itemData                 := QComboBox_itemData;
      itemData1                := QComboBox_itemData1;
      addItem                  := QComboBox_addItem;
      addItem1                 := QComboBox_addItem1;
      addItem2                 := QComboBox_addItem2;
      addItem3                 := QComboBox_addItem3;
      addItems                 := QComboBox_addItems;
      insertItem               := QComboBox_insertItem;
      insertItem1              := QComboBox_insertItem1;
      insertItem2              := QComboBox_insertItem2;
      insertItem3              := QComboBox_insertItem3;
      insertItems              := QComboBox_insertItems;
      insertSeparator          := QComboBox_insertSeparator;
      removeItem               := QComboBox_removeItem;
      setItemText              := QComboBox_setItemText;
      setItemIcon              := QComboBox_setItemIcon;
      setItemData              := QComboBox_setItemData;
      setItemData1             := QComboBox_setItemData1;
      view                     := QComboBox_view;
      setView                  := QComboBox_setView;
      sizeHint                 := QComboBox_sizeHint;
      minimumSizeHint          := QComboBox_minimumSizeHint;
      showPopup                := QComboBox_showPopup;
      hidePopup                := QComboBox_hidePopup;
      event                    := QComboBox_event;
      clear                    := QComboBox_clear;
      clearEditText            := QComboBox_clearEditText;
      setEditText              := QComboBox_setEditText;
      setCurrentIndex          := QComboBox_setCurrentIndex;
      destroyCxx               := Destroy_QComboBox;
    END;


BEGIN
END QtComboBox.
