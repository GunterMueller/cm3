(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtTreeWidgetRaw;


IMPORT Ctypes AS C;




<* EXTERNAL New_QTreeWidgetItem0 *>
PROCEDURE New_QTreeWidgetItem0 (type: C.int; ): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem1 *>
PROCEDURE New_QTreeWidgetItem1 (): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem2 *>
PROCEDURE New_QTreeWidgetItem2 (strings: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem3 *>
PROCEDURE New_QTreeWidgetItem3 (strings: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem4 *>
PROCEDURE New_QTreeWidgetItem4 (view: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem5 *>
PROCEDURE New_QTreeWidgetItem5 (view: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem6 *>
PROCEDURE New_QTreeWidgetItem6 (view, strings: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem7 *>
PROCEDURE New_QTreeWidgetItem7 (view, strings: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem8 *>
PROCEDURE New_QTreeWidgetItem8 (view, after: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem9 *>
PROCEDURE New_QTreeWidgetItem9 (view, after: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem10 *>
PROCEDURE New_QTreeWidgetItem10 (parent: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem11 *>
PROCEDURE New_QTreeWidgetItem11 (parent: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem12 *>
PROCEDURE New_QTreeWidgetItem12 (parent, strings: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem13 *>
PROCEDURE New_QTreeWidgetItem13 (parent, strings: ADDRESS; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem14 *>
PROCEDURE New_QTreeWidgetItem14 (parent, after: ADDRESS; type: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem15 *>
PROCEDURE New_QTreeWidgetItem15 (parent, after: ADDRESS; ):
  QTreeWidgetItem;

<* EXTERNAL New_QTreeWidgetItem16 *>
PROCEDURE New_QTreeWidgetItem16 (other: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL Delete_QTreeWidgetItem *>
PROCEDURE Delete_QTreeWidgetItem (self: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_clone *>
PROCEDURE QTreeWidgetItem_clone (self: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL QTreeWidgetItem_treeWidget *>
PROCEDURE QTreeWidgetItem_treeWidget (self: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidgetItem_setSelected *>
PROCEDURE QTreeWidgetItem_setSelected (self: ADDRESS; select: BOOLEAN; );

<* EXTERNAL QTreeWidgetItem_isSelected *>
PROCEDURE QTreeWidgetItem_isSelected (self: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidgetItem_setHidden *>
PROCEDURE QTreeWidgetItem_setHidden (self: ADDRESS; hide: BOOLEAN; );

<* EXTERNAL QTreeWidgetItem_isHidden *>
PROCEDURE QTreeWidgetItem_isHidden (self: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidgetItem_setExpanded *>
PROCEDURE QTreeWidgetItem_setExpanded (self: ADDRESS; expand: BOOLEAN; );

<* EXTERNAL QTreeWidgetItem_isExpanded *>
PROCEDURE QTreeWidgetItem_isExpanded (self: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidgetItem_setFirstColumnSpanned *>
PROCEDURE QTreeWidgetItem_setFirstColumnSpanned
  (self: ADDRESS; span: BOOLEAN; );

<* EXTERNAL QTreeWidgetItem_isFirstColumnSpanned *>
PROCEDURE QTreeWidgetItem_isFirstColumnSpanned (self: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidgetItem_setDisabled *>
PROCEDURE QTreeWidgetItem_setDisabled (self: ADDRESS; disabled: BOOLEAN; );

<* EXTERNAL QTreeWidgetItem_isDisabled *>
PROCEDURE QTreeWidgetItem_isDisabled (self: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidgetItem_setChildIndicatorPolicy *>
PROCEDURE QTreeWidgetItem_setChildIndicatorPolicy
  (self: ADDRESS; policy: C.int; );

<* EXTERNAL QTreeWidgetItem_childIndicatorPolicy *>
PROCEDURE QTreeWidgetItem_childIndicatorPolicy (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidgetItem_flags *>
PROCEDURE QTreeWidgetItem_flags (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidgetItem_setFlags *>
PROCEDURE QTreeWidgetItem_setFlags (self: ADDRESS; flags: C.int; );

<* EXTERNAL QTreeWidgetItem_text *>
PROCEDURE QTreeWidgetItem_text (self: ADDRESS; column: C.int; ): ADDRESS;

<* EXTERNAL QTreeWidgetItem_setText *>
PROCEDURE QTreeWidgetItem_setText
  (self: ADDRESS; column: C.int; text: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_icon *>
PROCEDURE QTreeWidgetItem_icon (self: ADDRESS; column: C.int; ): ADDRESS;

<* EXTERNAL QTreeWidgetItem_setIcon *>
PROCEDURE QTreeWidgetItem_setIcon
  (self: ADDRESS; column: C.int; icon: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_statusTip *>
PROCEDURE QTreeWidgetItem_statusTip (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setStatusTip *>
PROCEDURE QTreeWidgetItem_setStatusTip
  (self: ADDRESS; column: C.int; statusTip: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_toolTip *>
PROCEDURE QTreeWidgetItem_toolTip (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setToolTip *>
PROCEDURE QTreeWidgetItem_setToolTip
  (self: ADDRESS; column: C.int; toolTip: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_whatsThis *>
PROCEDURE QTreeWidgetItem_whatsThis (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setWhatsThis *>
PROCEDURE QTreeWidgetItem_setWhatsThis
  (self: ADDRESS; column: C.int; whatsThis: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_font *>
PROCEDURE QTreeWidgetItem_font (self: ADDRESS; column: C.int; ): ADDRESS;

<* EXTERNAL QTreeWidgetItem_setFont *>
PROCEDURE QTreeWidgetItem_setFont
  (self: ADDRESS; column: C.int; font: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_textAlignment *>
PROCEDURE QTreeWidgetItem_textAlignment (self: ADDRESS; column: C.int; ):
  C.int;

<* EXTERNAL QTreeWidgetItem_setTextAlignment *>
PROCEDURE QTreeWidgetItem_setTextAlignment
  (self: ADDRESS; column, alignment: C.int; );

<* EXTERNAL QTreeWidgetItem_backgroundColor *>
PROCEDURE QTreeWidgetItem_backgroundColor (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setBackgroundColor *>
PROCEDURE QTreeWidgetItem_setBackgroundColor
  (self: ADDRESS; column: C.int; color: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_background *>
PROCEDURE QTreeWidgetItem_background (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setBackground *>
PROCEDURE QTreeWidgetItem_setBackground
  (self: ADDRESS; column: C.int; brush: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_textColor *>
PROCEDURE QTreeWidgetItem_textColor (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setTextColor *>
PROCEDURE QTreeWidgetItem_setTextColor
  (self: ADDRESS; column: C.int; color: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_foreground *>
PROCEDURE QTreeWidgetItem_foreground (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setForeground *>
PROCEDURE QTreeWidgetItem_setForeground
  (self: ADDRESS; column: C.int; brush: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_checkState *>
PROCEDURE QTreeWidgetItem_checkState (self: ADDRESS; column: C.int; ):
  C.int;

<* EXTERNAL QTreeWidgetItem_setCheckState *>
PROCEDURE QTreeWidgetItem_setCheckState
  (self: ADDRESS; column, state: C.int; );

<* EXTERNAL QTreeWidgetItem_sizeHint *>
PROCEDURE QTreeWidgetItem_sizeHint (self: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setSizeHint *>
PROCEDURE QTreeWidgetItem_setSizeHint
  (self: ADDRESS; column: C.int; size: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_data *>
PROCEDURE QTreeWidgetItem_data (self: ADDRESS; column, role: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidgetItem_setData *>
PROCEDURE QTreeWidgetItem_setData
  (self: ADDRESS; column, role: C.int; value: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_parent *>
PROCEDURE QTreeWidgetItem_parent (self: ADDRESS; ): QTreeWidgetItem;

<* EXTERNAL QTreeWidgetItem_child *>
PROCEDURE QTreeWidgetItem_child (self: ADDRESS; index: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL QTreeWidgetItem_childCount *>
PROCEDURE QTreeWidgetItem_childCount (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidgetItem_columnCount *>
PROCEDURE QTreeWidgetItem_columnCount (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidgetItem_indexOfChild *>
PROCEDURE QTreeWidgetItem_indexOfChild (self, child: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidgetItem_addChild *>
PROCEDURE QTreeWidgetItem_addChild (self, child: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_insertChild *>
PROCEDURE QTreeWidgetItem_insertChild
  (self: ADDRESS; index: C.int; child: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_removeChild *>
PROCEDURE QTreeWidgetItem_removeChild (self, child: ADDRESS; );

<* EXTERNAL QTreeWidgetItem_takeChild *>
PROCEDURE QTreeWidgetItem_takeChild (self: ADDRESS; index: C.int; ):
  QTreeWidgetItem;

<* EXTERNAL QTreeWidgetItem_type *>
PROCEDURE QTreeWidgetItem_type (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidgetItem_sortChildren *>
PROCEDURE QTreeWidgetItem_sortChildren
  (self: ADDRESS; column, order: C.int; );

TYPE QTreeWidgetItem <: ADDRESS;

<* EXTERNAL New_QTreeWidget0 *>
PROCEDURE New_QTreeWidget0 (parent: ADDRESS; ): QTreeWidget;

<* EXTERNAL New_QTreeWidget1 *>
PROCEDURE New_QTreeWidget1 (): QTreeWidget;

<* EXTERNAL Delete_QTreeWidget *>
PROCEDURE Delete_QTreeWidget (self: ADDRESS; );

<* EXTERNAL QTreeWidget_columnCount *>
PROCEDURE QTreeWidget_columnCount (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidget_setColumnCount *>
PROCEDURE QTreeWidget_setColumnCount (self: ADDRESS; columns: C.int; );

<* EXTERNAL QTreeWidget_invisibleRootItem *>
PROCEDURE QTreeWidget_invisibleRootItem (self: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_topLevelItem *>
PROCEDURE QTreeWidget_topLevelItem (self: ADDRESS; index: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidget_topLevelItemCount *>
PROCEDURE QTreeWidget_topLevelItemCount (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidget_insertTopLevelItem *>
PROCEDURE QTreeWidget_insertTopLevelItem
  (self: ADDRESS; index: C.int; item: ADDRESS; );

<* EXTERNAL QTreeWidget_addTopLevelItem *>
PROCEDURE QTreeWidget_addTopLevelItem (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_takeTopLevelItem *>
PROCEDURE QTreeWidget_takeTopLevelItem (self: ADDRESS; index: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidget_indexOfTopLevelItem *>
PROCEDURE QTreeWidget_indexOfTopLevelItem (self, item: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidget_indexOfTopLevelItem1 *>
PROCEDURE QTreeWidget_indexOfTopLevelItem1 (self, item: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidget_headerItem *>
PROCEDURE QTreeWidget_headerItem (self: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_setHeaderItem *>
PROCEDURE QTreeWidget_setHeaderItem (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_setHeaderLabels *>
PROCEDURE QTreeWidget_setHeaderLabels (self, labels: ADDRESS; );

<* EXTERNAL QTreeWidget_setHeaderLabel *>
PROCEDURE QTreeWidget_setHeaderLabel (self, label: ADDRESS; );

<* EXTERNAL QTreeWidget_currentItem *>
PROCEDURE QTreeWidget_currentItem (self: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_currentColumn *>
PROCEDURE QTreeWidget_currentColumn (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidget_itemAt *>
PROCEDURE QTreeWidget_itemAt (self, p: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_itemAt1 *>
PROCEDURE QTreeWidget_itemAt1 (self: ADDRESS; x, y: C.int; ): ADDRESS;

<* EXTERNAL QTreeWidget_visualItemRect *>
PROCEDURE QTreeWidget_visualItemRect (self, item: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_sortColumn *>
PROCEDURE QTreeWidget_sortColumn (self: ADDRESS; ): C.int;

<* EXTERNAL QTreeWidget_sortItems *>
PROCEDURE QTreeWidget_sortItems (self: ADDRESS; column, order: C.int; );

<* EXTERNAL QTreeWidget_setSortingEnabled *>
PROCEDURE QTreeWidget_setSortingEnabled (self: ADDRESS; enable: BOOLEAN; );

<* EXTERNAL QTreeWidget_isSortingEnabled *>
PROCEDURE QTreeWidget_isSortingEnabled (self: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidget_editItem *>
PROCEDURE QTreeWidget_editItem (self, item: ADDRESS; column: C.int; );

<* EXTERNAL QTreeWidget_editItem1 *>
PROCEDURE QTreeWidget_editItem1 (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_openPersistentEditor *>
PROCEDURE QTreeWidget_openPersistentEditor
  (self, item: ADDRESS; column: C.int; );

<* EXTERNAL QTreeWidget_openPersistentEditor1 *>
PROCEDURE QTreeWidget_openPersistentEditor1 (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_closePersistentEditor *>
PROCEDURE QTreeWidget_closePersistentEditor
  (self, item: ADDRESS; column: C.int; );

<* EXTERNAL QTreeWidget_closePersistentEditor1 *>
PROCEDURE QTreeWidget_closePersistentEditor1 (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_itemWidget *>
PROCEDURE QTreeWidget_itemWidget (self, item: ADDRESS; column: C.int; ):
  ADDRESS;

<* EXTERNAL QTreeWidget_setItemWidget *>
PROCEDURE QTreeWidget_setItemWidget
  (self, item: ADDRESS; column: C.int; widget: ADDRESS; );

<* EXTERNAL QTreeWidget_removeItemWidget *>
PROCEDURE QTreeWidget_removeItemWidget
  (self, item: ADDRESS; column: C.int; );

<* EXTERNAL QTreeWidget_isItemSelected *>
PROCEDURE QTreeWidget_isItemSelected (self, item: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidget_setItemSelected *>
PROCEDURE QTreeWidget_setItemSelected
  (self, item: ADDRESS; select: BOOLEAN; );

<* EXTERNAL QTreeWidget_isItemHidden *>
PROCEDURE QTreeWidget_isItemHidden (self, item: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidget_setItemHidden *>
PROCEDURE QTreeWidget_setItemHidden (self, item: ADDRESS; hide: BOOLEAN; );

<* EXTERNAL QTreeWidget_isItemExpanded *>
PROCEDURE QTreeWidget_isItemExpanded (self, item: ADDRESS; ): BOOLEAN;

<* EXTERNAL QTreeWidget_setItemExpanded *>
PROCEDURE QTreeWidget_setItemExpanded
  (self, item: ADDRESS; expand: BOOLEAN; );

<* EXTERNAL QTreeWidget_isFirstItemColumnSpanned *>
PROCEDURE QTreeWidget_isFirstItemColumnSpanned (self, item: ADDRESS; ):
  BOOLEAN;

<* EXTERNAL QTreeWidget_setFirstItemColumnSpanned *>
PROCEDURE QTreeWidget_setFirstItemColumnSpanned
  (self, item: ADDRESS; span: BOOLEAN; );

<* EXTERNAL QTreeWidget_itemAbove *>
PROCEDURE QTreeWidget_itemAbove (self, item: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_itemBelow *>
PROCEDURE QTreeWidget_itemBelow (self, item: ADDRESS; ): ADDRESS;

<* EXTERNAL QTreeWidget_setSelectionModel *>
PROCEDURE QTreeWidget_setSelectionModel (self, selectionModel: ADDRESS; );

<* EXTERNAL QTreeWidget_scrollToItem *>
PROCEDURE QTreeWidget_scrollToItem (self, item: ADDRESS; hint: C.int; );

<* EXTERNAL QTreeWidget_scrollToItem1 *>
PROCEDURE QTreeWidget_scrollToItem1 (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_expandItem *>
PROCEDURE QTreeWidget_expandItem (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_collapseItem *>
PROCEDURE QTreeWidget_collapseItem (self, item: ADDRESS; );

<* EXTERNAL QTreeWidget_clear *>
PROCEDURE QTreeWidget_clear (self: ADDRESS; );

TYPE QTreeWidget = ADDRESS;

END QtTreeWidgetRaw.
