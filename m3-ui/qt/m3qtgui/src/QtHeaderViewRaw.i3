(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtHeaderViewRaw;


IMPORT Ctypes AS C;




<* EXTERNAL Delete_QHeaderView *>
PROCEDURE Delete_QHeaderView (self: QHeaderView; );

<* EXTERNAL QHeaderView_setModel *>
PROCEDURE QHeaderView_setModel (self: QHeaderView; model: ADDRESS; );

<* EXTERNAL QHeaderView_orientation *>
PROCEDURE QHeaderView_orientation (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_offset *>
PROCEDURE QHeaderView_offset (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_length *>
PROCEDURE QHeaderView_length (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_sizeHint *>
PROCEDURE QHeaderView_sizeHint (self: QHeaderView; ): ADDRESS;

<* EXTERNAL QHeaderView_sectionSizeHint *>
PROCEDURE QHeaderView_sectionSizeHint
  (self: QHeaderView; logicalIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_visualIndexAt *>
PROCEDURE QHeaderView_visualIndexAt (self: QHeaderView; position: C.int; ):
  C.int;

<* EXTERNAL QHeaderView_logicalIndexAt *>
PROCEDURE QHeaderView_logicalIndexAt
  (self: QHeaderView; position: C.int; ): C.int;

<* EXTERNAL QHeaderView_logicalIndexAt1 *>
PROCEDURE QHeaderView_logicalIndexAt1 (self: QHeaderView; x, y: C.int; ):
  C.int;

<* EXTERNAL QHeaderView_logicalIndexAt2 *>
PROCEDURE QHeaderView_logicalIndexAt2 (self: QHeaderView; pos: ADDRESS; ):
  C.int;

<* EXTERNAL QHeaderView_sectionSize *>
PROCEDURE QHeaderView_sectionSize
  (self: QHeaderView; logicalIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_sectionPosition *>
PROCEDURE QHeaderView_sectionPosition
  (self: QHeaderView; logicalIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_sectionViewportPosition *>
PROCEDURE QHeaderView_sectionViewportPosition
  (self: QHeaderView; logicalIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_moveSection *>
PROCEDURE QHeaderView_moveSection (self: QHeaderView; from, to: C.int; );

<* EXTERNAL QHeaderView_swapSections *>
PROCEDURE QHeaderView_swapSections
  (self: QHeaderView; first, second: C.int; );

<* EXTERNAL QHeaderView_resizeSection *>
PROCEDURE QHeaderView_resizeSection
  (self: QHeaderView; logicalIndex, size: C.int; );

<* EXTERNAL QHeaderView_resizeSections *>
PROCEDURE QHeaderView_resizeSections (self: QHeaderView; mode: C.int; );

<* EXTERNAL QHeaderView_isSectionHidden *>
PROCEDURE QHeaderView_isSectionHidden
  (self: QHeaderView; logicalIndex: C.int; ): BOOLEAN;

<* EXTERNAL QHeaderView_setSectionHidden *>
PROCEDURE QHeaderView_setSectionHidden
  (self: QHeaderView; logicalIndex: C.int; hide: BOOLEAN; );

<* EXTERNAL QHeaderView_hiddenSectionCount *>
PROCEDURE QHeaderView_hiddenSectionCount (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_hideSection *>
PROCEDURE QHeaderView_hideSection
  (self: QHeaderView; logicalIndex: C.int; );

<* EXTERNAL QHeaderView_showSection *>
PROCEDURE QHeaderView_showSection
  (self: QHeaderView; logicalIndex: C.int; );

<* EXTERNAL QHeaderView_count *>
PROCEDURE QHeaderView_count (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_visualIndex *>
PROCEDURE QHeaderView_visualIndex
  (self: QHeaderView; logicalIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_logicalIndex *>
PROCEDURE QHeaderView_logicalIndex
  (self: QHeaderView; visualIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_setMovable *>
PROCEDURE QHeaderView_setMovable (self: QHeaderView; movable: BOOLEAN; );

<* EXTERNAL QHeaderView_isMovable *>
PROCEDURE QHeaderView_isMovable (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_setClickable *>
PROCEDURE QHeaderView_setClickable
  (self: QHeaderView; clickable: BOOLEAN; );

<* EXTERNAL QHeaderView_isClickable *>
PROCEDURE QHeaderView_isClickable (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_setHighlightSections *>
PROCEDURE QHeaderView_setHighlightSections
  (self: QHeaderView; highlight: BOOLEAN; );

<* EXTERNAL QHeaderView_highlightSections *>
PROCEDURE QHeaderView_highlightSections (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_setResizeMode *>
PROCEDURE QHeaderView_setResizeMode (self: QHeaderView; mode: C.int; );

<* EXTERNAL QHeaderView_setResizeMode1 *>
PROCEDURE QHeaderView_setResizeMode1
  (self: QHeaderView; logicalIndex, mode: C.int; );

<* EXTERNAL QHeaderView_resizeMode *>
PROCEDURE QHeaderView_resizeMode
  (self: QHeaderView; logicalIndex: C.int; ): C.int;

<* EXTERNAL QHeaderView_stretchSectionCount *>
PROCEDURE QHeaderView_stretchSectionCount (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_setSortIndicatorShown *>
PROCEDURE QHeaderView_setSortIndicatorShown
  (self: QHeaderView; show: BOOLEAN; );

<* EXTERNAL QHeaderView_isSortIndicatorShown *>
PROCEDURE QHeaderView_isSortIndicatorShown (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_setSortIndicator *>
PROCEDURE QHeaderView_setSortIndicator
  (self: QHeaderView; logicalIndex, order: C.int; );

<* EXTERNAL QHeaderView_sortIndicatorSection *>
PROCEDURE QHeaderView_sortIndicatorSection (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_sortIndicatorOrder *>
PROCEDURE QHeaderView_sortIndicatorOrder (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_stretchLastSection *>
PROCEDURE QHeaderView_stretchLastSection (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_setStretchLastSection *>
PROCEDURE QHeaderView_setStretchLastSection
  (self: QHeaderView; stretch: BOOLEAN; );

<* EXTERNAL QHeaderView_cascadingSectionResizes *>
PROCEDURE QHeaderView_cascadingSectionResizes (self: QHeaderView; ):
  BOOLEAN;

<* EXTERNAL QHeaderView_setCascadingSectionResizes *>
PROCEDURE QHeaderView_setCascadingSectionResizes
  (self: QHeaderView; enable: BOOLEAN; );

<* EXTERNAL QHeaderView_defaultSectionSize *>
PROCEDURE QHeaderView_defaultSectionSize (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_setDefaultSectionSize *>
PROCEDURE QHeaderView_setDefaultSectionSize
  (self: QHeaderView; size: C.int; );

<* EXTERNAL QHeaderView_minimumSectionSize *>
PROCEDURE QHeaderView_minimumSectionSize (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_setMinimumSectionSize *>
PROCEDURE QHeaderView_setMinimumSectionSize
  (self: QHeaderView; size: C.int; );

<* EXTERNAL QHeaderView_defaultAlignment *>
PROCEDURE QHeaderView_defaultAlignment (self: QHeaderView; ): C.int;

<* EXTERNAL QHeaderView_setDefaultAlignment *>
PROCEDURE QHeaderView_setDefaultAlignment
  (self: QHeaderView; alignment: C.int; );

<* EXTERNAL QHeaderView_doItemsLayout *>
PROCEDURE QHeaderView_doItemsLayout (self: QHeaderView; );

<* EXTERNAL QHeaderView_sectionsMoved *>
PROCEDURE QHeaderView_sectionsMoved (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_sectionsHidden *>
PROCEDURE QHeaderView_sectionsHidden (self: QHeaderView; ): BOOLEAN;

<* EXTERNAL QHeaderView_reset *>
PROCEDURE QHeaderView_reset (self: QHeaderView; );

<* EXTERNAL QHeaderView_setOffset *>
PROCEDURE QHeaderView_setOffset (self: QHeaderView; offset: C.int; );

<* EXTERNAL QHeaderView_setOffsetToSectionPosition *>
PROCEDURE QHeaderView_setOffsetToSectionPosition
  (self: QHeaderView; visualIndex: C.int; );

<* EXTERNAL QHeaderView_setOffsetToLastSection *>
PROCEDURE QHeaderView_setOffsetToLastSection (self: QHeaderView; );

<* EXTERNAL QHeaderView_headerDataChanged *>
PROCEDURE QHeaderView_headerDataChanged
  (self: QHeaderView; orientation, logicalFirst, logicalLast: C.int; );

TYPE QHeaderView = ADDRESS;

END QtHeaderViewRaw.
