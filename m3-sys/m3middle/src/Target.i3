(* Copyright (C) 1993, Digital Equipment Corporation           *)
(* All rights reserved.                                        *)
(* See the file COPYRIGHT for a full description.              *)
(*                                                             *)
(* File: Target.i3                                             *)
(* Last Modified On Tue Dec 20 14:03:42 PST 1994 By kalsow     *)
(*      Modified On Thu May 20 08:20:38 PDT 1993 By muller     *)

INTERFACE Target;

(*  Modula-3 target description

    This interface defines the host representation of target
    values and the target architecture.  Its primary client
    is the Modula-3 compiler.

    Unless otherwise specified, all sizes and alignments are
    specified in bits.

    'pack' is defined to be 'size' rounded up to an alignment
    boundary (i.e. (size + align - 1) DIV align * align).
*)

TYPE
  Systems = {
    AMD64_DARWIN,
    AMD64_FREEBSD,
    AMD64_LINUX,
    AMD64_NETBSD,
    AMD64_OPENBSD,
    AMD64_SOLARIS,
    ARM_DARWIN,
    FreeBSD4,
    I386_CYGWIN,
    I386_DARWIN,
    I386_FREEBSD,
    I386_INTERIX,
    I386_LINUX,
    I386_MINGW,
    I386_NETBSD,
    I386_NT,
    I386_OPENBSD,
    I386_SOLARIS,
    LINUXLIBC6,
    MIPS64_OPENBSD,
    NT386,
    NT386GNU,
    NetBSD2_i386,
    PA32_HPUX,
    PA64_HPUX,
    PPC32_OPENBSD,
    PPC_DARWIN,
    PPC_LINUX,
    SOLgnu,
    SOLsun,
    SPARC32_LINUX,
    SPARC64_LINUX,
    SPARC64_OPENBSD,
    SPARC64_SOLARIS,
    Undefined
  };

CONST
  SystemNames = ARRAY OF TEXT {
    "AMD64_DARWIN",
    "AMD64_FREEBSD",
    "AMD64_LINUX",
    "AMD64_NETBSD",
    "AMD64_OPENBSD",
    "AMD64_SOLARIS",
    "ARM_DARWIN",
    "FreeBSD4",
    "I386_CYGWIN",
    "I386_DARWIN",
    "I386_FREEBSD",
    "I386_INTERIX",
    "I386_LINUX",
    "I386_MINGW",
    "I386_NETBSD",
    "I386_NT",
    "I386_OPENBSD",
    "I386_SOLARIS",
    "LINUXLIBC6",
    "MIPS64_OPENBSD",
    "NT386",
    "NT386GNU",
    "NetBSD2_i386",
    "PA32_HPUX",
    "PA64_HPUX",
    "PPC32_OPENBSD",
    "PPC_DARWIN",
    "PPC_LINUX",
    "SOLgnu",
    "SOLsun",
    "SPARC32_LINUX",
    "SPARC64_LINUX",
    "SPARC64_OPENBSD",
    "SPARC64_SOLARIS"
  };

CONST
  OSNames = ARRAY OF TEXT { "POSIX", "WIN32" };

TYPE
  M3BackendMode_t =
  {
    (* The primary modes are currently 0 and 3. *)
    IntegratedObject,   (* "0"  -- don't call m3_backend, M3CG produces object code *)
    IntegratedAssembly, (* "1"  -- don't call m3_backend, M3CG produces assembly code *)
    ExternalObject,     (* "2"  -- call m3_backend, it produces object code *)
    ExternalAssembly    (* "3"  -- call m3_backend, it produces assembly code *)
  };

CONST
  BackendModeStrings = ARRAY M3BackendMode_t OF TEXT
  { "IntegratedObject",
    "IntegratedAssembly",
    "ExternalObject",
    "ExternalAssembly" };

  BackendIntegrated = ARRAY M3BackendMode_t OF BOOLEAN { TRUE, TRUE, FALSE, FALSE };
  BackendAssembly = ARRAY M3BackendMode_t OF BOOLEAN { FALSE, TRUE, FALSE, TRUE };

(*-------------------------------------------------------- initialization ---*)

PROCEDURE Init (system: TEXT; osname := "POSIX"; backend_mode := M3BackendMode_t.ExternalAssembly): BOOLEAN;
(* Initialize the variables of this interface to reflect the architecture
   of "system".  Returns TRUE iff the "system" was known and the initialization
   was successful.  *)

VAR (*CONST*)
  System: Systems := Systems.Undefined; (* initialized by "Init" *)

VAR (*CONST*)
  System_name: TEXT := NIL; (* initialized by "Init" *)

VAR (*CONST*)
  OS_name: TEXT := NIL; (* initialized by "Init" *)

(*------------------------------------------ machine/code generator types ---*)

TYPE (* machine supported types *)
  CGType = {
    Word8,  Int8,    (* 8-bit, unsigned & signed integer *)
    Word16, Int16,   (* 16-bit, unsigned & signed integer *)
    Word32, Int32,   (* 32-bit, unsigned & signed integer *)
    Word64, Int64,   (* 64-bit, unsigned & signed integer *)
    Reel,            (* single precision reals *)
    LReel,           (* double precision reals *)
    XReel,           (* extended precision reals *)
    Addr,            (* addresses *)
    Struct,          (* a block of memory *)
    Void             (* not-a-type *)
  };

CONST
  TypeNames = ARRAY CGType OF TEXT {
    "Word.8",  "Int.8",
    "Word.16", "Int.16",
    "Word.32", "Int.32",
    "Word.64", "Int.64",
    "Reel", "LReel", "XReel",
    "Addr",
    "Struct",
    "Void"
  };

CONST
  SignedType = ARRAY CGType OF BOOLEAN {
     FALSE, TRUE,  FALSE, TRUE,  (* Word8 .. Int16 *)
     FALSE, TRUE,  FALSE, TRUE,  (* Word32 .. Int64 *)
     TRUE,  TRUE,  TRUE,         (* Reel .. XReel *)
     FALSE, FALSE, FALSE         (* Addr .. Void *)
  };

CONST
  OrdinalType = ARRAY CGType OF BOOLEAN {
    TRUE,  TRUE,  TRUE,  TRUE,   (* Word.8, Int.8, Word.16, Int.16 *)
    TRUE,  TRUE,  TRUE,  TRUE,   (* Word.32, Int.32, Word.64, Int.64 *)
    FALSE, FALSE, FALSE,         (* Reel, LReel, XReel *)
    TRUE,  FALSE, FALSE          (* Addr, Struct, Void *)
  };

CONST
  FloatType = ARRAY CGType OF BOOLEAN {
    FALSE, FALSE, FALSE, FALSE,  (* Word.8, Int.8, Word.16, Int.16 *)
    FALSE, FALSE, FALSE, FALSE,  (* Word.32, Int.32, Word.64, Int.64 *)
    TRUE,  TRUE,  TRUE,          (* Reel, LReel, XReel *)
    FALSE, FALSE, FALSE          (* Addr, Struct, Void *)
  };

(*-------------------------------------------------------- integer values ---*)

(* The bits of a target INTEGER (in 2's complement) are stored in
   an array of small host values, with the low order bits in the first
   element of the array. *)

TYPE
  Int = (* OPAQUE *) RECORD
    n: CARDINAL;          (* only bytes [0..n-1] contain valid bits *)
    x := IBytes{0,..};    (* default is Zero *)
  END;
  IBytes = ARRAY [0..7] OF IByte;
  IByte = BITS 8 FOR [0..16_ff];

PROCEDURE TargetIntToDiagnosticText(a: Int): TEXT;

TYPE
  Int_type = RECORD
    cg_type : CGType;    (* representation *)
    size    : CARDINAL;  (* bit size *)
    align   : CARDINAL;  (* minimum bit alignment *)
    pack    : CARDINAL;  (* minimum width bit packing *)
    bytes   : CARDINAL;  (* byte size *)
    min     : Int;       (* minimum value of this type *)
    max     : Int;       (* maximum value of this type *)
  END;

(*------------------------------------------------- floating point values ---*)

TYPE
  Precision = { Short, Long, Extended };

  Float = (*OPAQUE*) RECORD
    pre      : Precision;
    exponent : INTEGER;
    fraction : EXTENDED;
  END;

  Float_type = RECORD
    cg_type : CGType;     (* representation *)
    pre     : Precision;  (* precision *)
    size    : CARDINAL;   (* bit size *)
    align   : CARDINAL;   (* minimum bit alignment *)
    bytes   : CARDINAL;   (* byte size *)
    min     : Float;      (* minimum value of this type *)
    max     : Float;      (* maximum value of this type *)
  END;

(*----------------------------------------------- machine supported types ---*)

VAR (*CONST*)
  Address   : Int_type;
  Integer   : Int_type;
  Longint   : Int_type;
  Word      : Int_type;
  Long      : Int_type;
  Real      : Float_type;
  Longreal  : Float_type;
  Extended  : Float_type;
  Int8      : Int_type;
  Int16     : Int_type;
  Int32     : Int_type;
  Int64     : Int_type;
  Word8     : Int_type;
  Word16    : Int_type;
  Word32    : Int_type;
  Word64    : Int_type;
  Void      : Int_type;
  Char      : Int_type;

VAR (*CONST*) (* sorted list of supported machine alignments *)
  Alignments: ARRAY [0..3] OF CARDINAL;

(*------------------------------------------------------- procedure calls ---*)

TYPE
  CallingConvention = REF RECORD
    name               : TEXT;
    m3cg_id            : INTEGER;
    args_left_to_right : BOOLEAN;
    results_on_left    : BOOLEAN;
    standard_structs   : BOOLEAN;
  END;

VAR (*CONST*)
  DefaultCall: CallingConvention := NIL;

PROCEDURE FindConvention (nm: TEXT): CallingConvention;
(* Return the convention with name "nm".  Otherwise, return NIL. *)

PROCEDURE ConventionFromID (id: INTEGER): CallingConvention;
(* Return the convention with "m3cg_id" "id".  Otherwise, return NIL. *)


(*
  name => the name recognized in an <*EXTERNAL*> pragma, or as a prefix
          to a PROCEDURE declaration. 

  m3cg_id => tag used to indicate convention to the back end.

  args_left_to_right => Procedure arguments should be pushed
                        left->right or right->left.

  results_on_left => when the front-end is passing structures the return
                     result is the left-most parameter.  Otherwise, it is
                     the right-most parameter.

  standard_structs =>
     TRUE => the front-end will take care of all structure passing:
       by VALUE parameters: callers pass the address of the structure
          and the callee copies it into a temporary.
       return results: the caller passes as the left-most or right-most
          parameter the address of the temporary that will hold the result
          and the callee copies the value there.
     FALSE =>
       by VALUE parameters: the back-end is responsible.
          (ie. M3CG.T.Pop_struct will be called)
       return results: the caller passes as the left-most or right-most
          parameter the address of the temporary that will hold the result
          and the callee copies the value there.  The start_call, call,
          and exit_proc methods are called with t=Struct.
*)

(*--------------------------------------------------- misc. configuration ---*)

(* sizes are specified in bits *)

CONST
  Byte = 8;  (* minimum addressable unit (in bits) *)

VAR (*CONST*)
  Set_grain : CARDINAL; (* allocation unit for large sets *)
  Set_align : CARDINAL; (* alignment for large sets *)

  Little_endian : BOOLEAN;
  (* TRUE => byte[0] of an integer contains its least-significant bits *)

  PCC_bitfield_type_matters: BOOLEAN;
  (* TRUE => the C compiler uses the type rather than the size of
     a bit-field to compute the alignment of the struct *)

  Structure_size_boundary: CARDINAL;
  (* every structure size must be a multiple of this *)

  Allow_packed_byte_aligned: BOOLEAN;
  (* Allow the compiler to align scalar types on byte boundaries when packing.
     The target processor must support byte alignment of scalar store and
     loads. This does not remove the restriction that bitfields may not cross
     word boundaries. *)

  (* NIL checking *)
  First_readable_addr: CARDINAL;
  (* Read or write references to addresses in the range [0..First_readable-1]
     will cause an address faults.  Hence, no explicit NIL checks are needed
     for dereferencing with offsets in this range. *)

  (* Thread stacks *)
  Jumpbuf_size     : CARDINAL; (* size of a "jmp_buf" *)
  Jumpbuf_align    : CARDINAL; (* alignment of a "jmp_buf" *)

  (* floating point values *)
  All_floats_legal : BOOLEAN;
  (* If all bit patterns are "legal" floating point values (i.e. they can
     be assigned without causing traps or faults). *)

  Has_stack_walker: BOOLEAN;
  (* TRUE => generate PC-tables for exception scopes.  Otherwise, generate
       an explicit stack of exception handler frames. *)

  Setjmp: TEXT;
  (* The C name of the routine used to capture the machine state in
       an exception handler frame. *)

  Aligned_procedures: BOOLEAN;
  (* TRUE => all procedure values are aligned to at least Integer.align
     and can be safely dereferenced.  Otherwise, the code generated to
     test for nested procedures passed as parameters must be more
     elaborate (e.g. HPPA). *)

  EOL: TEXT;
  (* The sequence of characters that conventionally terminate a
     text line on the target system:  '\n' on Unix, '\r\n' on DOS *)

END Target.
