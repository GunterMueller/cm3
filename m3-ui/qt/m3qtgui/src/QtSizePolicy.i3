(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.10
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE QtSizePolicy;

FROM QtNamespace IMPORT Orientations;


TYPE
  T = QSizePolicy;
  ControlTypes = INTEGER;


CONST                            (* Enum PolicyFlag *)
  GrowFlag   = 1;
  ExpandFlag = 2;
  ShrinkFlag = 4;
  IgnoreFlag = 8;

TYPE                             (* Enum PolicyFlag *)
  PolicyFlag = [1 .. 8];


CONST                            (* Enum Policy *)
  Fixed            = 0;
  Minimum          = 1;
  Maximum          = 4;
  Preferred        = 5;
  MinimumExpanding = 3;
  Expanding        = 7;
  Ignored          = 13;

TYPE                             (* Enum Policy *)
  Policy = [0 .. 13];


CONST                            (* Enum ControlType *)
  DefaultType = 1;
  ButtonBox   = 2;
  CheckBox    = 4;
  ComboBox    = 8;
  Frame       = 16;
  GroupBox    = 32;
  Label       = 64;
  Line        = 128;
  LineEdit    = 256;
  PushButton  = 512;
  RadioButton = 1024;
  Slider      = 2048;
  SpinBox     = 4096;
  TabWidget   = 8192;
  ToolButton  = 16384;

TYPE                             (* Enum ControlType *)
  ControlType = [1 .. 16384];


TYPE
  QSizePolicy <: QSizePolicyPublic;
  QSizePolicyPublic =
    BRANDED OBJECT
      cxxObj: ADDRESS;
    METHODS
      init_0 (): QSizePolicy;
      init_1 (horizontal, vertical: Policy; ): QSizePolicy;
      init_2 (horizontal, vertical: Policy; type: ControlType; ):
              QSizePolicy;
      horizontalPolicy     (): Policy;
      verticalPolicy       (): Policy;
      controlType          (): ControlType;
      setHorizontalPolicy  (d: Policy; );
      setVerticalPolicy    (d: Policy; );
      setControlType       (type: ControlType; );
      expandingDirections  (): Orientations;
      setHeightForWidth    (b: BOOLEAN; );
      hasHeightForWidth    (): BOOLEAN;
      setWidthForHeight    (b: BOOLEAN; );
      hasWidthForHeight    (): BOOLEAN;
      horizontalStretch    (): INTEGER;
      verticalStretch      (): INTEGER;
      setHorizontalStretch (stretchFactor: CHAR; );
      setVerticalStretch   (stretchFactor: CHAR; );
      transpose            ();
      destroyCxx           ();
    END;


END QtSizePolicy.
