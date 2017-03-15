(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtDynamicRaw;


IMPORT Ctypes AS C;


TYPE CallbackProc = PROCEDURE (obj: ROOT; args: ADDRESS);



<* EXTERNAL Delete_AbstractDynamicSlot *>
PROCEDURE Delete_AbstractDynamicSlot (self: AbstractDynamicSlot; );

TYPE AbstractDynamicSlot <: ADDRESS;

<* EXTERNAL AbstractDynamicQObject_qt_metacall *>
PROCEDURE AbstractDynamicQObject_qt_metacall
  (self     : AbstractDynamicQObject;
   c        : INTEGER;
   id       : C.int;
   arguments: REF ADDRESS;            ): C.int;

<* EXTERNAL AbstractDynamicQObject_emitDynamicSignal *>
PROCEDURE AbstractDynamicQObject_emitDynamicSignal
  (self     : AbstractDynamicQObject;
   signal   : C.char_star;
   arguments: REF ADDRESS;            ): BOOLEAN;

<* EXTERNAL AbstractDynamicQObject_connectDynamicSlot *>
PROCEDURE AbstractDynamicQObject_connectDynamicSlot
  (self: AbstractDynamicQObject; obj: ADDRESS; signal, slot: C.char_star; ):
  BOOLEAN;

<* EXTERNAL AbstractDynamicQObject_connectDynamicSignal *>
PROCEDURE AbstractDynamicQObject_connectDynamicSignal
  (self  : AbstractDynamicQObject;
   signal: C.char_star;
   obj   : ADDRESS;
   slot  : C.char_star;            ): BOOLEAN;

<* EXTERNAL AbstractDynamicQObject_disConnectDynamicSlot *>
PROCEDURE AbstractDynamicQObject_disConnectDynamicSlot
  (self: AbstractDynamicQObject; obj: ADDRESS; signal, slot: C.char_star; ):
  BOOLEAN;

<* EXTERNAL AbstractDynamicQObject_disConnectDynamicSignal *>
PROCEDURE AbstractDynamicQObject_disConnectDynamicSignal
  (self  : AbstractDynamicQObject;
   signal: C.char_star;
   obj   : ADDRESS;
   slot  : C.char_star;            ): BOOLEAN;

<* EXTERNAL Delete_AbstractDynamicQObject *>
PROCEDURE Delete_AbstractDynamicQObject (self: AbstractDynamicQObject; );

TYPE AbstractDynamicQObject = ADDRESS;

<* EXTERNAL New_DynamicQObject0 *>
PROCEDURE New_DynamicQObject0 (fn: CallbackProc; obj: ROOT; ):
  DynamicQObject;

<* EXTERNAL DynamicQObject_createSlot *>
PROCEDURE DynamicQObject_createSlot
  (self: DynamicQObject; slot: C.char_star; ): ADDRESS;

<* EXTERNAL Delete_DynamicQObject *>
PROCEDURE Delete_DynamicQObject (self: DynamicQObject; );

TYPE DynamicQObject = ADDRESS;

<* EXTERNAL New_Slot0 *>
PROCEDURE New_Slot0 (parent: ADDRESS; fn: CallbackProc; obj: ROOT; ): Slot;

<* EXTERNAL Slot_call *>
PROCEDURE Slot_call
  (self: Slot; sender: ADDRESS; arguments: REF ADDRESS; );

<* EXTERNAL Delete_Slot *>
PROCEDURE Delete_Slot (self: Slot; );

TYPE Slot = ADDRESS;

END QtDynamicRaw.
