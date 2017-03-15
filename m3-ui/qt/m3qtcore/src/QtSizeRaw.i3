(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtSizeRaw;


IMPORT Ctypes AS C;


<* EXTERNAL New_QSize0 *>
PROCEDURE New_QSize0 (): QSize;

<* EXTERNAL New_QSize1 *>
PROCEDURE New_QSize1 (w, h: C.int; ): QSize;

<* EXTERNAL QSize_isNull *>
PROCEDURE QSize_isNull (self: QSize; ): BOOLEAN;

<* EXTERNAL QSize_isEmpty *>
PROCEDURE QSize_isEmpty (self: QSize; ): BOOLEAN;

<* EXTERNAL QSize_isValid *>
PROCEDURE QSize_isValid (self: QSize; ): BOOLEAN;

<* EXTERNAL QSize_width *>
PROCEDURE QSize_width (self: QSize; ): C.int;

<* EXTERNAL QSize_height *>
PROCEDURE QSize_height (self: QSize; ): C.int;

<* EXTERNAL QSize_setWidth *>
PROCEDURE QSize_setWidth (self: QSize; w: C.int; );

<* EXTERNAL QSize_setHeight *>
PROCEDURE QSize_setHeight (self: QSize; h: C.int; );

<* EXTERNAL QSize_transpose *>
PROCEDURE QSize_transpose (self: QSize; );

<* EXTERNAL QSize_scale *>
PROCEDURE QSize_scale (self: QSize; w, h, mode: C.int; );

<* EXTERNAL QSize_scale1 *>
PROCEDURE QSize_scale1 (self: QSize; s: ADDRESS; mode: C.int; );

<* EXTERNAL QSize_expandedTo *>
PROCEDURE QSize_expandedTo (self: QSize; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSize_boundedTo *>
PROCEDURE QSize_boundedTo (self: QSize; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSize_rwidth *>
PROCEDURE QSize_rwidth (self: QSize; ): UNTRACED REF C.int;

<* EXTERNAL QSize_rheight *>
PROCEDURE QSize_rheight (self: QSize; ): UNTRACED REF C.int;

<* EXTERNAL QSize_PlusEqual *>
PROCEDURE QSize_PlusEqual (self: QSize; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSize_MinusEqual *>
PROCEDURE QSize_MinusEqual (self: QSize; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSize_MultiplyEqual *>
PROCEDURE QSize_MultiplyEqual (self: QSize; c: C.double; ): ADDRESS;

<* EXTERNAL QSize_DivideEqual *>
PROCEDURE QSize_DivideEqual (self: QSize; c: C.double; ): ADDRESS;

<* EXTERNAL Delete_QSize *>
PROCEDURE Delete_QSize (self: QSize; );

TYPE QSize <: ADDRESS;

<* EXTERNAL New_QSizeF0 *>
PROCEDURE New_QSizeF0 (): QSizeF;

<* EXTERNAL New_QSizeF1 *>
PROCEDURE New_QSizeF1 (sz: ADDRESS; ): QSizeF;

<* EXTERNAL New_QSizeF2 *>
PROCEDURE New_QSizeF2 (w, h: C.double; ): QSizeF;

<* EXTERNAL QSizeF_isNull *>
PROCEDURE QSizeF_isNull (self: QSizeF; ): BOOLEAN;

<* EXTERNAL QSizeF_isEmpty *>
PROCEDURE QSizeF_isEmpty (self: QSizeF; ): BOOLEAN;

<* EXTERNAL QSizeF_isValid *>
PROCEDURE QSizeF_isValid (self: QSizeF; ): BOOLEAN;

<* EXTERNAL QSizeF_width *>
PROCEDURE QSizeF_width (self: QSizeF; ): C.double;

<* EXTERNAL QSizeF_height *>
PROCEDURE QSizeF_height (self: QSizeF; ): C.double;

<* EXTERNAL QSizeF_setWidth *>
PROCEDURE QSizeF_setWidth (self: QSizeF; w: C.double; );

<* EXTERNAL QSizeF_setHeight *>
PROCEDURE QSizeF_setHeight (self: QSizeF; h: C.double; );

<* EXTERNAL QSizeF_transpose *>
PROCEDURE QSizeF_transpose (self: QSizeF; );

<* EXTERNAL QSizeF_scale *>
PROCEDURE QSizeF_scale (self: QSizeF; w, h: C.double; mode: C.int; );

<* EXTERNAL QSizeF_scale1 *>
PROCEDURE QSizeF_scale1 (self: QSizeF; s: ADDRESS; mode: C.int; );

<* EXTERNAL QSizeF_expandedTo *>
PROCEDURE QSizeF_expandedTo (self: QSizeF; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSizeF_boundedTo *>
PROCEDURE QSizeF_boundedTo (self: QSizeF; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSizeF_rwidth *>
PROCEDURE QSizeF_rwidth (self: QSizeF; ): UNTRACED REF C.double;

<* EXTERNAL QSizeF_rheight *>
PROCEDURE QSizeF_rheight (self: QSizeF; ): UNTRACED REF C.double;

<* EXTERNAL QSizeF_PlusEqual *>
PROCEDURE QSizeF_PlusEqual (self: QSizeF; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSizeF_MinusEqual *>
PROCEDURE QSizeF_MinusEqual (self: QSizeF; arg2: ADDRESS; ): ADDRESS;

<* EXTERNAL QSizeF_MultiplyEqual *>
PROCEDURE QSizeF_MultiplyEqual (self: QSizeF; c: C.double; ): ADDRESS;

<* EXTERNAL QSizeF_DivideEqual *>
PROCEDURE QSizeF_DivideEqual (self: QSizeF; c: C.double; ): ADDRESS;

<* EXTERNAL QSizeF_toSize *>
PROCEDURE QSizeF_toSize (self: QSizeF; ): ADDRESS;

<* EXTERNAL Delete_QSizeF *>
PROCEDURE Delete_QSizeF (self: QSizeF; );

TYPE QSizeF <: ADDRESS;

END QtSizeRaw.
