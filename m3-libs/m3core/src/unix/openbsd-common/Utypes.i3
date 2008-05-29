INTERFACE Utypes;

IMPORT Ctypes, Cstddef;

TYPE
  uint8_t = Ctypes.unsigned_char;
  uint16_t = Ctypes.unsigned_short;
  uint32_t = Ctypes.unsigned_int;
  uint64_t = Ctypes.unsigned_long_long;

  int8_t = Ctypes.char;
  int16_t = Ctypes.short;
  int32_t = Ctypes.int;
  int64_t = Ctypes.long_long;

  u_int8_t = uint8_t;
  u_int16_t = uint16_t;
  u_int32_t = uint32_t;
  u_int64_t = uint64_t;
  u_short = uint16_t;

  u_int   = uint32_t;
  u_long = Cstddef.size_t;

  clock_t = int32_t;
  dev_t = int32_t;
  gid_t = uint32_t;
  id_t = uint32_t;
  in_addr_t = int32_t;
  in_port_t = int16_t;
  ino_t = uint32_t;
  mode_t = uint32_t;
  nlink_t = uint32_t;
  off_t = int64_t;
  pid_t = int32_t;
  rlim_t = uint64_t;
  size_t = Cstddef.size_t;
  time_t = int32_t;
  uid_t = uint32_t;

  socklen_t = uint32_t;
  hostent_addrtype_t = int32_t;
  hostent_length_t = int32_t;

END Utypes.
