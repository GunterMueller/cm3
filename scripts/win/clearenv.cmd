@rem $Id: clearenv.cmd,v 1.8 2008-01-14 04:59:42 jkrell Exp $

@if "%_echo%" == "" @echo off

@rem
@rem This is meant to be called by other .cmd files and should not have
@rem setlocal/endlocal.
@rem

for %%i in (ACTION ARGS BUILDGLOBAL BUILDLOCAL CLEANGLOBAL       ) do if defined %%i set %%i=
for %%i in (CLEANLOCAL CM3BINSEARCHPATH CM3LIBSEARCHPATH         ) do if defined %%i set %%i=
for %%i in (CM3ROOT CM3VERSION EXE GCC_BACKEND GREP IGNORE_MISS  ) do if defined %%i set %%i=
for %%i in (INSTALLROOT M3BUILD M3GDB M3OSTYPE M3SHIP PKG_ACTION ) do if defined %%i set %%i=
for %%i in (PKGS PKGSDB REALCLEAN ROOT SCRIPTS SYSINFO_DONE      ) do if defined %%i set %%i=
for %%i in (SHIP SL SYSLIBDIR SYSLIBS TAR TARGET TMPDIR          ) do if defined %%i set %%i=
for %%i in (CM3_SYSCALL_WRAPPERS_EXIST                           ) do if defined %%i set %%i=
call :Clear INSTALLROOT_PREVIOUS
call :Clear INSTALLROOT_COMPILER_WITH_PREVIOUS
call :Clear INSTALLROOT_COMPILER_WITH_SELF
call :Clear INSTALLROOT_MIN
call :Clear INSTALLROOT_STD
call :Clear INSTALLROOT_CORE
call :Clear INSTALLROOT_BASE

goto :eof

:Clear
if defined %1 set %1=
goto :eof
