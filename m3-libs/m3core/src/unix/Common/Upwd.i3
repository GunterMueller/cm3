(* Copyright (C) 1990, Digital Equipment Corporation.         *)
(* All rights reserved.                                       *)
(* See the file COPYRIGHT for a full description.             *)

<*EXTERNAL*> INTERFACE Upwd;

FROM Ctypes IMPORT char_star, int;
FROM Utypes IMPORT uid_t;

TYPE
  struct_passwd_star = UNTRACED REF RECORD
    pw_name : char_star;
    unused_pw_passwd : char_star;
    pw_uid : uid_t;
    (* There are more fields here, but they are not used,
    nor is the size of this type used (which is why we only
    provide the pointer type and not the value type. *)
  END;

PROCEDURE getpwuid (uid: int): struct_passwd_star;
PROCEDURE getpwnam (name: char_star): struct_passwd_star;

END Upwd.
