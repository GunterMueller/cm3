#! /usr/bin/env python

import os
from os import getenv
from os import path
import os.path
import glob
import sys
import platform
import re
import tempfile
import shutil

#-----------------------------------------------------------------------------
# Several important variables are gotten from the environment or probed.
# The probing is usually 100% correct.
#
# CM3_TARGET
#    probed with $OS and uname
#
# CM3_ROOT
#    the root of the source, computed from the path to this file
#
# CM3_INSTALL
#    the root of the installation, computed from finding cm3 in $PATH
#
# M3CONFIG
#    the config file, probed based on a few factors
#

# print("loading pylib..")

if os.environ.get("M3CONFIG", "").lower().find("m3-syscminstallsrcconfig") != -1:
    print("backslash problem; environment variable M3CONFIG is " + getenv("M3CONFIG"))
    sys.exit(1)

def IsInterix():
    return os.name == "posix" and os.uname()[0].lower().startswith("interix")

env_OS = getenv("OS")

if env_OS == "Windows_NT" and not IsInterix():
    def uname():
        PROCESSOR_ARCHITECTURE = getenv("PROCESSOR_ARCHITECTURE")
        return (env_OS, "", PROCESSOR_ARCHITECTURE, "", PROCESSOR_ARCHITECTURE)
    #
    # cmd can run extensionless executables if this code is enabled.
    # This can be useful for example with NT386GNU following more Posix-ish
    # naming styles than even Cygwin usually does.
    #
    #pathext = getenv("PATHEXT")
    #if pathext and not "." in pathext.split(";"):
    #    pathext = ".;" + pathext
    #    os.environ["PATHEXT"] = pathext
    #    print("set PATHEXT=.;%PATHEXT%")
else:
    from os import uname

#-----------------------------------------------------------------------------

_Program = os.path.basename(sys.argv[0])

#-----------------------------------------------------------------------------

def FatalError(a = ""):
    # logs don't work yet
    #print("ERROR: see " + Logs)
    print("fatal error " + a)
    if __name__ != "__main__":
        sys.exit(1)

def RemoveTrailingSlashes(a):
    while len(a) > 0 and (a[-1] == '\\' or a[-1] == '/'):
        a = a[:-1]
    return a

def RemoveTrailingSlash(a):
    if len(a) > 0 and (a[-1] == '\\' or a[-1] == '/'):
        a = a[:-1]
    return a

#print("RemoveTrailingSlash(a\\/):" + RemoveTrailingSlash("a\\/"))
#print("RemoveTrailingSlash(a/\\):" + RemoveTrailingSlash("a/\\"))
#print("RemoveTrailingSlash(a):" + RemoveTrailingSlash("a"))
#print("RemoveTrailingSlashes(a\\\\):" + RemoveTrailingSlashes("a\\\\"))
#print("RemoveTrailingSlashes(a//):" + RemoveTrailingSlashes("a//"))
#print("RemoveTrailingSlashes(a):" + RemoveTrailingSlashes("a"))
#sys.exit(1)

def GetLastPathElement(a):
    a = RemoveTrailingSlashes(a)
    return a[max(a.rfind("/"), a.rfind("\\")) + 1:]

def RemoveLastPathElement(a):
    a = RemoveTrailingSlashes(a)
    return a[0:max(a.rfind("/"), a.rfind("\\"))]

def GetPathExtension(a):
    a = GetLastPathElement(a)
    b = a.rfind(".")
    if b < 0:
        return ""
    return a[b + 1:]

def GetPathBaseName(a):
    a = GetLastPathElement(a)
    b = a.rfind(".")
    if b == -1:
        return a
    return a[0:b]

# print("1:" + GetPathExtension("a"))
# print("2:" + GetPathExtension("a.b"))
# print("3:" + GetPathExtension("a.b/c.d"))
# print("4:" + GetPathExtension("a.b/c"))
# sys.exit(1)
# print("1:" + GetPathBaseName("a"))
# print("2:" + GetPathBaseName("a.b"))
# print("3:" + GetPathBaseName("a.b/c.d"))
# print("4:" + GetPathBaseName("a.b/c"))
# sys.exit(1)


#-----------------------------------------------------------------------------

def _ConvertToCygwinPath(a):
    if IsInterix() or env_OS != "Windows_NT" or a == None:
        return a
    if (a.find('\\') == -1) and (a.find(':') == -1):
        return a
    a = a.replace("\\", "/")
    if a.find(":/") == 1:
        a = "/cygdrive/" + a[0:1] + a[2:]
    return a

#-----------------------------------------------------------------------------

def _ConvertFromCygwinPath(a):
    if IsInterix() or env_OS != "Windows_NT" or a == None:
        return a
    a = a.replace("/", "\\")
    #a = a.replace("\\", "/")
    if a.startswith("\\cygdrive\\"):
        a = a[10] + ":" + a[11:]
    elif a.startswith("\\home\\elego\\"):
        a = "c:\\cygwin\\" + a
    return a

def GetFullPath(a):
    # find what separator it as (might be ambiguous)
    if a.find("/") != -1:
        sep = "/"
    elif a.find("\\") != -1:
        sep = "\\"
    # convert to what Python expects, both due to ambiguity
    a = a.replace("/", os.path.sep)
    a = a.replace("\\", os.path.sep)
    a = os.path.abspath(a)          # have Python do the work
    a = a.replace(os.path.sep, sep) # put back the original separators
    return a

def ConvertPathForWin32(a):
    return _ConvertFromCygwinPath(a)

if os.name == "posix":
    def ConvertPathForPython(a):
        return _ConvertToCygwinPath(a)
else:
    def ConvertPathForPython(a):
        return _ConvertFromCygwinPath(a)

#-----------------------------------------------------------------------------

def isfile(a):
    return os.path.isfile(ConvertPathForPython(a))

def isdir(a):
    return os.path.isdir(ConvertPathForPython(a))

def FileExists(a):
    return isfile(a)

#-----------------------------------------------------------------------------
#
# http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/52224
#

def SearchPath(name, paths = getenv("PATH")):
    #Given a search path, find file
    if (name.find("/") != -1) or (name.find("\\") != -1):
        if isfile(name):
            return name
    if paths == "":
        print("SearchPath returning None 1")
        return None
    (base, exts) = os.path.splitext(name)
    if not exts and not IsInterix():
        exts = (getenv("PATHEXT") or "").lower()
    for ext in exts.split(";"):
        if ext == ".":
            ext = ""
        name = (base + ext)
        seps = [os.pathsep]
        # use ; for portable separator where possible
        if os.pathsep != ';':
            seps.append(';')
        for sep in seps:
            for path in paths.split(sep):
                candidate = os.path.join(path, name)
                if isfile(candidate):
                    return os.path.abspath(candidate)
    #print("SearchPath " + name + " returning None 2")
    return None

#-----------------------------------------------------------------------------

def _FormatEnvironmentVariable(Name):
    if os.name == "nt":
        return "%" + Name + "%"
    else:
        return "$" + Name

#-----------------------------------------------------------------------------

def _CheckSetupEnvironmentVariableAll(Name, RequiredFiles, Attempt, pathsep = os.pathsep):
    AnyMissing = False
    Value = os.environ.get(Name)
    if Value:
        for File in RequiredFiles:
            if not SearchPath(File, Value):
                AnyMissing = True
                break
    else:
        AnyMissing = True
    if AnyMissing:
        if Value:
            NewValue = Attempt + pathsep + Value
        else:
            NewValue = Attempt
        for File in RequiredFiles:
            if not SearchPath(File, NewValue):
                return "ERROR: " + File + " not found in " + _FormatEnvironmentVariable(Name) + "(" + NewValue + ")"
        os.environ[Name] = NewValue
        if Value:
            print(Name + "=" + Attempt + pathsep + _FormatEnvironmentVariable(Name))
        else:
            print(Name + "=" + Attempt)
    return None

def _SetupEnvironmentVariableAll(Name, RequiredFiles, Attempt, pathsep = os.pathsep):
    Error = _CheckSetupEnvironmentVariableAll(Name, RequiredFiles, Attempt, pathsep)
    if Error:
        print(Error)
        if __name__ != "__main__":
            sys.exit(1)

#-----------------------------------------------------------------------------

def _SetupEnvironmentVariableAny(Name, RequiredFiles, Attempt, pathsep = os.pathsep):
    Value = os.environ.get(Name)
    if Value:
        for File in RequiredFiles:
            if SearchPath(File, Value):
                return
    if Value:
        NewValue = Attempt + pathsep + Value
    else:
        NewValue = Attempt
    for File in RequiredFiles:
        if SearchPath(File, NewValue):
            os.environ[Name] = NewValue
            if Value:
                print(Name + "=" + NewValue + pathsep + _FormatEnvironmentVariable(Name))
            else:
                print(Name + "=" + NewValue)
            return
    print("ERROR: " + _FormatEnvironmentVariable(Name) + " does not have any of " + " ".join(RequiredFiles))
    if __name__ != "__main__":
        sys.exit(1)

#-----------------------------------------------------------------------------

def _ClearEnvironmentVariable(Name):
    if Name in os.environ:
        del(os.environ[Name])
        print("set " + Name + "=")

#-----------------------------------------------------------------------------

def _MapTarget(a):

    # Convert sensible names that the user might provide on the
    # command line into the legacy names other code knows about.

    return {
        "I386_LINUX" : "LINUXLIBC6",
        "I386_NT" : "NT386",
        "I386_CYGWIN" : "NT386GNU",
        "I386_MINGW" : "NT386MINGNU",
        "PPC32_DARWIN" : "PPC_DARWIN",
        "PPC32_LINUX" : "PPC_LINUX",
        "I386_FREEBSD" : "FreeBSD4",
        "I386_NETBSD" : "NetBSD2_i386",

        # both options sensible, double HP a bit redundant in the HPUX names

        "HPPA32_HPUX"  : "PA32_HPUX",
        "HPPA64_HPUX"  : "PA64_HPUX",
        "HPPA32_LINUX" : "PA32_LINUX",
        "HPPA64_LINUX" : "PA64_LINUX",
    }.get(a) or a

#-----------------------------------------------------------------------------

def _GetAllTargets():

    # legacy naming

    Targets = [ "NT386", "NT386GNU", "NT386MINGNU", "LINUXLIBC6", "SOLsun", "SOLgnu", "FreeBSD4", "NetBSD2_i386" ]

    for proc in [ "PPC", ]:
        for os in [ "OPENBSD", "NETBSD", "FREEBSD", "DARWIN", "LINUX" ]:
            Targets += [proc + "_" + os]

    # systematic naming

    for proc in [ "I386", "AMD64", "PPC32", "PPC64", "ARM" ]:
        for os in [ "DARWIN" ]:
            Targets += [proc + "_" + os]

    for proc in [ "MIPS64", "I386", "AMD64", "PPC32", "PPC64", "SPARC32", "SPARC64" ]:
        for os in [ "OPENBSD", "NETBSD", "FREEBSD" ]:
            Targets += [proc + "_" + os]

    for proc in [ "MIPS64", "I386", "AMD64", "PPC32", "PPC64", "SPARC32", "SPARC64", "ARM", "PA32", "PA64"]:
        for os in [ "LINUX" ]:
            Targets += [proc + "_" + os]

    for proc in [ "MIPS32", "MIPS64" ]:
        for os in [ "IRIX" ]:
            Targets += [proc + "_" + os]

    for proc in [ "PPC32", "PPC64" ]:
        for os in [ "AIX" ]:
            Targets += [proc + "_" + os]

    for proc in [ "I386", "PPC32", "MIPS32", "ARM", "SH" ]:
        for os in [ "CE" ]:
            Targets += [proc + "_" + os]

    for proc in [ "I386", "AMD64", "IA64" ]:
        for os in [ "CYGWIN", "INTERIX", "NT" ]:
            Targets += [proc + "_" + os]

    for proc in [ "I386", "AMD64", "SPARC32", "SPARC64" ]:
        for os in [ "SOLARIS" ]:
            Targets += [proc + "_" + os]

    for proc in [ "PA32", "PA64", "IA64" ]:
        for os in [ "HPUX" ]:
            Targets += [proc + "_" + os]

    return Targets

#-----------------------------------------------------------------------------

CM3_FLAGS = ""
if "boot" in sys.argv:
    CM3_FLAGS = CM3_FLAGS + " -boot"
if "keep" in sys.argv:
    CM3_FLAGS = CM3_FLAGS + " -keep"

CM3 = ConvertPathForPython(getenv("CM3")) or "cm3"
CM3 = SearchPath(CM3)

#-----------------------------------------------------------------------------
# the root of the installation
# This can be sniffed by finding cm3 in $PATH, else defaulted
# if the defaults contain a cm3.
#

InstallRoot = ConvertPathForPython(getenv("CM3_INSTALL"))
# print("InstallRoot is " + InstallRoot)

if not CM3 and not InstallRoot:
    for a in ["c:\\cm3\\bin\\cm3.exe", "d:\\cm3\\bin\\cm3.exe", "/cm3/bin/cm3", "/usr/local/bin/cm3"]:
        if isfile(a):
            CM3 = a
            bin = os.path.dirname(CM3)
            print("using " + CM3)
            InstallRoot = os.path.dirname(bin)
            _SetupEnvironmentVariableAll("PATH", ["cm3"], bin)
            break

if not InstallRoot:
    if CM3:
        InstallRoot = os.path.dirname(os.path.dirname(CM3))
    else:
        if "realclean" in sys.argv:
            #
            # Realclean does not require knowing CM3_INSTALL or
            # being able to run cm3, so just set dummy values.
            #
            CM3 = __file__
            InstallRoot = __file__
        else:
            FatalError("environment variable CM3_INSTALL not set AND cm3 not found in PATH; please fix")

#-----------------------------------------------------------------------------
# the root of the source tree
# This is always correctly and simply found based on the location of this very code.
#
Root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

#-----------------------------------------------------------------------------
# If the current working drive is the same drive as Root is in, then the Win32
# path can take on a valid working Posix form -- no colon, all forward slashes.
# Plenty of Win32 code accepts forward slashes.
#
# If the current working drive and the drive of Root are different, then this
# is flawed. However, we can and probably should completely fix that by
# merely cd'ing to a directory on the drive of Root, if other paths either
# are also on that drive, or have their drive letter not removed.
#

# This is all well and good for current cm3, but older Win32 cm3 doesn't like
# these paths (even though underlying Win32 does). So try leaving things alone.

# if Root.find(":\\") == 1:
#   Root = Root[2:]
#
# Root = Root.replace("\\\\", "/")
# Root = Root.replace("\\", "/")

#-----------------------------------------------------------------------------

#
# User can override all these from environment, as in sh.
# The environment variable names are all UPPERCASE.
# Ideally this array gets emptied or at least reduced.
#
# THIS IS MOSTLY NOT INTERESTING AS THE DEFAULTS AND PROBING ARE GOOD.
#
Variables = [

    #
    # True or False -- should we build m3gdb.
    #
    "M3GDB",

    #
    # a temporary "staging" location for building distributions
    #
    "STAGE",

    "BuildArgs",
    "CleanArgs",
    "ShipArgs",

    "BuildLocal",
    "CleanLocal",
    "BuildGlobal",
    "CleanGlobal",
    "Ship",

    "CM3_BuildLocal",
    "CM3_CleanLocal",
    "CM3_BuildGlobal",
    "CM3_CleanGlobal",
    "CM3_Ship",

    "RealClean",
    "HAVE_TCL",
    "HAVE_SERIAL",
    "OMIT_GCC",
]

#-----------------------------------------------------------------------------

Versions = {
    "CM3VERSION" : None,
    "CM3VERSIONNUM" : None,
    "CM3LASTCHANGED" : None,
    }

Variables += Versions.keys()

#
# Ensure all variables have some value.
#
b = ""
for a in Variables:
    b += ("%s = os.getenv(\"%s\") or \"\"\n" % (a, a.upper()))
exec(b)

for a in Versions.keys():
    Versions[a] = eval(a)

#-----------------------------------------------------------------------------

def header(a):
    print("")
    print( "----------------------------------------------------------------------------")
    print(a)
    print("----------------------------------------------------------------------------")
    print("")

#-----------------------------------------------------------------------------
# set some defaults

def GetVersion(Key):
    #
    # Only read the file if an environment variable is "missing" (they
    # usually all are, ok), and only read it once.
    #
    #print("WriteVariablesIntoEnvironment:3")
    Value = Versions.get(Key)
    if Value:
        return Value
    #
    # CM3VERSION d5.7.1
    # CM3VERSIONNUM 050701
    # CM3LASTCHANGED 2009-01-21
    #
    RegExp = re.compile("(" + "|".join(Versions.keys()) + ") (.+)$", re.IGNORECASE)
    ShFilePath = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "version")
    for Line in open(ShFilePath):
        Match = RegExp.match(Line)
        if Match:
            MatchKey = Match.group(1)
            #
            # We are here because one of them wasn't found, but we should be
            # sure only to overwrite what we don't have.
            #
            if not Versions[MatchKey]:
                Value = Match.group(2)
                Versions[MatchKey] = Value
                exec("%s = \"%s\"" % (MatchKey, Value), locals(), globals())

    #
    # Make sure we found every key in the file (at least those
    # not defined in the environment)
    #
    MissingKey = None
    for Item in Versions.iteritems():
        #print(Item)
        if Item[1] is None:
            MissingKey = Item[0]
            File = __file__
            sys.stderr.write("%(File)s: %(MissingKey)s not found in %(ShFilePath)s\n" % vars())

    if MissingKey:
        sys.exit(1)

    return Versions.get(Key)

CM3VERSION = getenv("CM3VERSION") or GetVersion("CM3VERSION")
CM3VERSIONNUM = getenv("CM3VERSIONNUM") or GetVersion("CM3VERSIONNUM")
CM3LASTCHANGED = getenv("CM3LASTCHANGED") or GetVersion("CM3LASTCHANGED")

CM3_GDB = False


#-----------------------------------------------------------------------------
#
# some dumb detail as to where quotes are needed on command lines
#

Q = "'"
Q = "" # TBD

#-----------------------------------------------------------------------------
#
# GCC_BACKEND is almost always true.
#

GCC_BACKEND = True

#-----------------------------------------------------------------------------
#
# Sniff to determine host.
#

UNameCommand = os.popen("uname").read().lower()
UNameTuple = uname()
UName = UNameTuple[0].lower()
UNameArchP = platform.processor().lower()
UNameArchM = UNameTuple[4].lower()
UNameRevision = UNameTuple[2].lower()

Host = None

if (UName.startswith("windows")
        or UNameCommand.startswith("mingw")
        or UNameCommand.startswith("cygwin")):

    Host = "NT386"
    # Host = "I386_NT"

elif IsInterix():

    Host = "I386_INTERIX"

elif UName.startswith("freebsd"):

    if UNameArchM == "i386":
        if UNameRevision.startswith("1"):
            Host = "FreeBSD"
        elif UNameRevision.startswith("2"):
            Host = "FreeBSD2"
        elif UNameRevision.startswith("3"):
            Host = "FreeBSD3"
        else:
            Host = "FreeBSD4"
        # Host = "I386_FREEBSD"
    elif UNameArchM == "amd64":
        Host = "AMD64_FREEBSD"
    else:
        Host = "FBSD_ALPHA"
        # Host = "ALPHA64_FREEBSD"

elif UName.startswith("openbsd"):

    if UNameArchM == "sparc64":
        Host = "SPARC64_OPENBSD"
    elif UNameArchM == "macppc":
        Host = "PPC32_OPENBSD"
    elif UNameArchM == "i386":
        Host = "I386_OPENBSD"
    else:
        FatalError("unknown OpenBSD platform")

elif UName.startswith("darwin"):

    # detect the m3 platform (Darwin runs on ppc32, ppc64, x86, amd64)
    if UNameArchP == "powerpc":
        Host = "PPC_DARWIN"
    elif re.match("i[3456]86", UNameArchP):
        if os.popen("sysctl hw.cpu64bit_capable").read() == "hw.cpu64bit_capable: 1\n":
            Host = "AMD64_DARWIN"
        else:
            Host = "I386_DARWIN"
    elif UNameArchP == "x86-64":
        Host = "AMD64_DARWIN"
    elif UNameArchP == "powerpc64":
        Host = "PPC64_DARWIN"

elif UName.startswith("sunos"):

    Host = "SOLgnu"
    #Host = "SOLsun"
    #Host = "SPARC32_SOLARIS"

elif UName.startswith("linux"):

    if UNameArchM == "ppc":
        Host = "PPC_LINUX"
    elif UNameArchM == "x86_64":
        Host = "AMD64_LINUX"
    elif UNameArchM == "sparc64":
        Host = "SPARC32_LINUX"
    else:
        # Host = "I386_LINUX"
        Host = "LINUXLIBC6"

elif UName.startswith("netbsd"):

    # Host = "I386_NETBSD"
    Host = "NetBSD2_i386" # only arch/version combination supported yet

elif UName.startswith("irix"):

    Host = "MIPS32_IRIX"
    # later
    # if UName.startswith("irix64"):
    #   Host = "MIPS64_IRIX"

elif UName.startswith("hp-ux"):

    Host = "PA32_HPUX"
    #
    # no good way found to sniff for 64bit, not even from 64bit Python
    # user will have to say PA64_HPUX manually on the command line
    #

else:
    # more need to be added here, I haven't got all the platform info ready
    pass

#-----------------------------------------------------------------------------
#
# Target is:
#   - any parameter on the command line that is a platform
#   - CM3_TARGET environment variable
#   - defaults to host
#

Target = None
for a in _GetAllTargets():
    if a in sys.argv:
        Target = _MapTarget(a)
Target = Target or getenv("CM3_TARGET") or Host

#-----------------------------------------------------------------------------
#
# OSType is almost always POSIX, the user cannot set it, it is changed to WIN32 sometimes later
#

OSType = "POSIX"

#-----------------------------------------------------------------------------
#
# Usually Config == Target, except NT386 has multiple configurations.
#

Config = Target

#-----------------------------------------------------------------------------
#
# Set data that derives from target/config.
#

#
# Is this the right default?
#
HAVE_SERIAL = False

if Target.startswith("NT386"):

    # q for quote: This is probably about the host, not the target.
    Q = ""

    HAVE_SERIAL = True

    #
    # TBD:
    # If cl is not in the path, or link not in the path (Cygwin link doesn't count)
    # then error toward GNU, and probe uname and gcc -v.
    #
    if Target == "NT386GNU":
        Config = "NT386GNU"
        OSType = "POSIX"

    elif Target == "NT386MINGNU":
        Config = "NT386MINGNU"
        OSType = "WIN32"

    else:
        Config = "NT386"
        OSType = "WIN32"
        GCC_BACKEND = False

    Target = "NT386"

#-----------------------------------------------------------------------------

M3GDB = (M3GDB or CM3_GDB)
PKGSDB = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "PKGS")

#-----------------------------------------------------------------------------

def GetConfigForDistribution(Target):
#
# Favor the config-no-install directory, else fallback to config.
#
    if False:
        a = os.path.join(Root, "m3-sys", "cminstall", "src")
        b = os.path.join(a, "config-no-install", Target)
        if isfile(b):
            return b
        # b = os.path.join(a, "config", Target)
        b = os.path.join(a, "config-no-install", Target)
        # print("GetConfigForDistribution:" + b)
        return b
    else:
        b = os.path.join(Root, "m3-sys", "cminstall", "src", "config-no-install", Target)
        # print("GetConfigForDistribution:" + b)
        return b

#-----------------------------------------------------------------------------

def SetEnvironmentVariable(Name, Value):
    if not os.environ.get(Name) or (os.environ[Name] != Value):
        os.environ[Name] = Value
        print("set " + Name + "=" + Value)

#-----------------------------------------------------------------------------

def IsCygwinBinary(a):
    if IsInterix() or env_OS != "Windows_NT":
        return False
    if not isfile(a):
        FatalError(a + " does not exist")
    a = a.replace("/cygdrive/c/", "c:\\")
    a = a.replace("/cygdrive/d/", "d:\\")
    a = a.replace("/", "\\")
    a = _ConvertFromCygwinPath(a)
    #print("a is " + a)
    return (os.system("findstr 2>&1 >" + os.devnull + " /m cygwin1.dll \"" + a + "\"") == 0)

#-----------------------------------------------------------------------------

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    if IsCygwinBinary(CM3):
        CM3IsCygwin = True
        def ConvertPathForCM3(a):
            return _ConvertToCygwinPath(a)
    else:
        CM3IsCygwin = False
        def ConvertPathForCM3(a):
            return _ConvertFromCygwinPath(a)

#-----------------------------------------------------------------------------
#
# reflect what we decided back into the environment
#

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    SetEnvironmentVariable("CM3_TARGET", Target)
    SetEnvironmentVariable("CM3_INSTALL", ConvertPathForCM3(InstallRoot))
    SetEnvironmentVariable("M3CONFIG", ConvertPathForCM3(os.environ.get("M3CONFIG") or GetConfigForDistribution(Config)))
    #SetEnvironmentVariable("CM3_ROOT", ConvertPathForCM3(Root).replace("\\", "\\\\"))
    SetEnvironmentVariable("CM3_ROOT", ConvertPathForCM3(Root).replace("\\", "/"))

# sys.exit(1)

#-----------------------------------------------------------------------------
# define build and ship programs for Critical Mass Modula-3
#

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    DEFS = "-DROOT=%(Q)s%(Root)s%(Q)s"
    DEFS += " -DCM3_VERSION_TEXT=%(Q)s%(CM3VERSION)s%(Q)s"
    DEFS += " -DCM3_VERSION_NUMBER=%(Q)s%(CM3VERSIONNUM)s%(Q)s"
    DEFS += " -DCM3_LAST_CHANGED=%(Q)s%(CM3LASTCHANGED)s%(Q)s"
    
    NativeRoot = Root
    #Root = ConvertPathForCM3(Root).replace("\\", "\\\\")
    Root = ConvertPathForCM3(Root).replace("\\", "/")
    DEFS = (DEFS % vars())
    Root = NativeRoot

#-----------------------------------------------------------------------------
# Make sure these variables all start with a space if they are non-empty.
#

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    if BuildArgs:
        BuildArgs = " " + BuildArgs
    
    if CleanArgs:
        CleanArgs = " " + CleanArgs
    
    if ShipArgs:
        ShipArgs = " " + ShipArgs

#-----------------------------------------------------------------------------
# form the various commands we might run
#

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    Debug = "" # " -debug "
    CM3_BuildLocal = CM3_BuildLocal or BuildLocal or "%(CM3)s %(CM3_FLAGS)s " + Debug + " -build -override %(DEFS)s%(BuildArgs)s"
    CM3_CleanLocal = CM3_CleanLocal or CleanLocal or "%(CM3)s %(CM3_FLAGS)s " + Debug + " -clean -build -override %(DEFS)s%(CleanArgs)s"
    CM3_BuildGlobal = CM3_BuildGlobal or BuildGlobal or "%(CM3)s %(CM3_FLAGS)s " + Debug + " -build %(DEFS)s%(BuildArgs)s"
    CM3_CleanGlobal = CM3_CleanGlobal or CleanGlobal or "%(CM3)s %(CM3_FLAGS)s " + Debug + " -clean %(DEFS)s%(CleanArgs)s"
    CM3_Ship = CM3_Ship or Ship or "%(CM3)s %(CM3_FLAGS)s -ship %(DEFS)s%(ShipArgs)s"

# other commands

    if os.name == "nt":
        RealClean = RealClean or "if exist %(Config)s rmdir /q/s %(Config)s"
    else:
        RealClean = RealClean or "rm -rf %(Config)s"
    
    RealClean = (RealClean % vars())

#-----------------------------------------------------------------------------
# choose the compiler to use
# pm3/dec/m3build is not tested and likely cm3 is all that works (heavily used)
#

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    if SearchPath(CM3):
        BuildLocal = CM3_BuildLocal
        CleanLocal = CM3_CleanLocal
        BuildGlobal = CM3_BuildGlobal
        CleanGlobal = CM3_CleanGlobal
        Ship = CM3_Ship
    else:
        if (not BuildLocal) or (not BuildGlobal) or (not Ship):
            File = __file__
            sys.stderr.write(
                "%(File)s: %(CM3)s or %(M3Build)s not found in your path, don't know how to compile\n"
                % vars())
            sys.exit(1)
    
    BuildLocal = BuildLocal.strip() % vars()
    CleanLocal = CleanLocal.strip() % vars()
    BuildGlobal = BuildGlobal.strip() % vars()
    CleanGlobal = CleanGlobal.strip() % vars()
    Ship = Ship.strip() % vars()

#-----------------------------------------------------------------------------

def format_one(width, string):
    return ("%-*s" % (width, string))

#-----------------------------------------------------------------------------

def print_list(strings, NumberOfColumns):
    Result = ""
    Width = (72 / NumberOfColumns)
    Length = len(strings)
    i = 0
    while (i != Length):
        j = 0
        while ((i != Length) and (j != NumberOfColumns)):
            if j == 0:
                if i != 0:
                    Result += "\n"
                Result += "  "
            Result += format_one(Width, strings[i])
            i += 1
            j += 1
    return Result

#-----------------------------------------------------------------------------

def PrintList2(strings):
    return print_list(strings, 2)

#-----------------------------------------------------------------------------

def PrintList4(strings):
    return print_list(strings, 4)

#-----------------------------------------------------------------------------

def ShowUsage(args, Usage, P):
    for arg in args[1:]:
        if arg in ["-h", "-help", "--help", "-?"]:
            print("")
            print("usage " + os.path.basename(args[0]) + ":")
            if Usage:
                BaseName = os.path.basename(args[0])
                GenericCommands = """
  build | buildlocal          build a package with local overrides (default)
  buildglobal | buildship     build a package without overrides and ship it
  ship                        ship a package
  clean | cleanlocal          clean a package with local overrides
  cleanglobal                 clean a package without overrides
  realclean                   remove the TARGET directory of a package
"""

                GenericOptions = """
  -n                          no action (do not execute anything)
  -k                          keep going (ignore errors if possible)
"""
                if P:
                    N = len(P)
                    Packages = PrintList4(P)
                print(Usage % vars())
            else:
                print("")
                print("No specific usage notes available.")
                print("")
                print("Generic commands:")
                print(GenericCommands)
                print("Generic options:")
                print(GenericOptions)
            sys.exit(0)

#-----------------------------------------------------------------------------

def MakePackageDB():
    if not isfile(PKGSDB):
        #
        # Look for all files src/m3makefile in the CM3 source
        # and write their relative paths from Root to PKGSDB.
        #
        def Callback(Result, Directory, Names):
            if os.path.basename(Directory) != "src":
                return
            if Directory.find("_darcs") != -1:
                return
            if Directory.find("examples/web") != -1:
                return
            if Directory.find("examples\\web") != -1:
                return
            if not "m3makefile" in Names:
                return
            if not isfile(os.path.join(Directory, "m3makefile")):
                return
            Result.append(Directory[len(Root) + 1:-4].replace('\\', "/") + "\n")

        print("making " + PKGSDB + ".. (slow but rare)")
        Result = [ ]

        os.path.walk(Root, Callback, Result)

        Result.sort()
        open(PKGSDB, "w").writelines(Result)

        if not isfile(PKGSDB):
            File = __file__
            sys.stderr.write("%(File)s: cannot generate package list\n" % vars())
            sys.exit(1)

#-----------------------------------------------------------------------------

PackageDB = None

def ReadPackageDB():
    MakePackageDB()
    global PackageDB
    PackageDB = (PackageDB or map(lambda(a): a.replace("\n", "").replace('\\', '/').replace("\r", ""), open(PKGSDB)))

#-----------------------------------------------------------------------------

def IsPackageDefined(a):
    a = a.replace('\\', '/').lower()
    ReadPackageDB()
    a = ('/' + a)
    for i in PackageDB:
        if i.lower().endswith(a):
            return True

#-----------------------------------------------------------------------------

def GetPackagePath(a):
    a = a.replace('\\', '/')
    ReadPackageDB()
    b = ('/' + a).lower()
    for i in PackageDB:
        if i.lower().endswith(b):
            return i.replace('/', os.path.sep)
    File = __file__
    sys.stderr.write("%(File)s: package %(a)s not found (%(b)s)\n" % vars())

def ListPackages(pkgs):
    ReadPackageDB()
    Result = [ ]
    if pkgs:
        for pkg in pkgs:
            pkg = pkg.replace('\\', '/')
            # remove Root from the start
            if pkg.lower().startswith(Root.lower() + '/'):
                pkg = pkg[len(Root) + 1:]
            # if no slashes, then need a leading slash
            if pkg.find('/') == -1:
                pkg = ('/' + pkg)
            for q in PackageDB:
                q = q.replace('\\', '/')
                if q.lower().find(pkg.lower()) != -1:
                    Result.append(q)
                    break
    else:
        Result = PackageDB
    return map(lambda(a): (Root + '/' + a), Result)

#-----------------------------------------------------------------------------

def _Run(NoAction, Actions, PackageDirectory):

    print(" +++ %s +++" % Actions)

    if NoAction:
        return 0

    #return 0

    PreviousDirectory = os.getcwd()
    os.chdir(PackageDirectory.replace('/', os.path.sep))

    Result = os.system(Actions)

    os.chdir(PreviousDirectory)
    return Result

#-----------------------------------------------------------------------------

def _BuildLocalFunction(NoAction, PackageDirectory):
    return _Run(NoAction, BuildLocal, PackageDirectory)

#-----------------------------------------------------------------------------

def _BuildGlobalFunction(NoAction, PackageDirectory):
    return _Run(NoAction, BuildGlobal, PackageDirectory)

#-----------------------------------------------------------------------------

def _ShipFunction(NoAction, PackageDirectory):
    return _Run(NoAction, Ship, PackageDirectory)

#-----------------------------------------------------------------------------

def _CleanLocalFunction(NoAction, PackageDirectory):
    return _Run(NoAction, CleanLocal, PackageDirectory)

#-----------------------------------------------------------------------------

def _CleanGlobalFunction(NoAction, PackageDirectory):
    return _Run(NoAction, CleanGlobal, PackageDirectory)

#-----------------------------------------------------------------------------

def _RealCleanFunction(NoAction, PackageDirectory):
#
# This in particular need not run commands but can be implemented
# directly in Python.
#
    return _Run(NoAction, RealClean, PackageDirectory)

#-----------------------------------------------------------------------------

def _MakeArchive(a):
    #
    # OpenBSD doesn't have bzip2 in base, so use gzip instead.
    #
    DeleteFile(a + ".tar.gz")
    b = "tar cfz " + a + ".tar.gz " + a
    print(b + "\n")
    os.system(b)

#-----------------------------------------------------------------------------

def Boot():

    global BuildLocal
    BuildLocal += " -boot -keep -DM3CC_TARGET=" + Target

    Version = "1"

    # This information is duplicated from the config files.
    # TBD: put it only in one place.
    # The older bootstraping method does get that right.

    SunCompile = "/usr/ccs/bin/cc -g -mt -xcode=pic32 -xldscope=symbolic "

    GnuCompile = {
        # gcc -fPIC generates incorrect code on Interix
        "I386_INTERIX"    : "gcc -g "
        }.get(Target) or "gcc -g -fPIC "

    if Target.endswith("_SOLARIS") or Target == "SOLsun":
        Compile = SunCompile
    else:
        Compile = GnuCompile

    Compile = Compile + ({
        "AMD64_LINUX"     : " -m64 -mno-align-double ",
        "AMD64_DARWIN"    : " -arch x86_64 ",
        "ARM_DARWIN"      : " -march=armv6 -mcpu=arm1176jzf-s ",
        "LINUXLIBC6"      : " -m32 -mno-align-double ",
        "MIPS64_OPENBSD"  : " -mabi=64 ",
        "SOLgnu"          : " -m32 ",
        "SOLsun"          : " -xarch=v8plus ",
        "SPARC32_LINUX"   : " -m32 -munaligned-doubles ",
        "SPARC64_LINUX"   : " -m64 -munaligned-doubles ",
        "SPARC64_SOLARIS" : " -xarch=v9 ",
        }.get(Target) or " ")

    SunLink = " -lrt -lm -lnsl -lsocket -lpthread "

    Link = Compile + ({
        "ARM_DARWIN"      : " ",
        "AMD64_DARWIN"    : " ",
        "I386_DARWIN"     : " ",
        "I386_INTERIX"    : " -lm ",
        "PPC_DARWIN"      : " ",
        "PPC64_DARWIN"    : " ",
        "SOLgnu"          : SunLink,
        "SOLsun"          : SunLink,
        "SPARC64_SOLARIS" : SunLink,
        "PA32_HPUX"       : " -lrt -lm ",
        }.get(Target) or " -lm -lpthread ")

    # not in Link
    Compile += " -c "
    
    if Target.endswith("_SOLARIS") or Target.startswith("SOL"):
        Assemble = "/usr/ccs/bin/as "
    else:
        Assemble = "as "

    if Target != "PPC32_OPENBSD" and Target != "PPC_LINUX":
        if Target.find("LINUX") != -1 or Target.find("BSD") != -1:
            if Target.find("64") != -1 or Target.find("ALPHA") != -1:
                Assemble = Assemble + " --64"
            else:
                Assemble = Assemble + " --32"

    Assemble = (Assemble + ({
        "AMD64_DARWIN"      : " -arch x86_64 ",
        "ARM_DARWIN"        : " -arch armv6 ",
        "SOLgnu"            : " -s -xarch=v8plus ",
        "SOLsun"            : " -s -xarch=v8plus ",
        "SPARC64_SOLARIS"   : " -s -xarch=v9 ",
        }.get(Target) or ""))

    GnuPlatformPrefix = {
        "ARM_DARWIN"      : "arm-apple-darwin8-",
        }.get(Target) or ""

    Compile = GnuPlatformPrefix + Compile
    Link = GnuPlatformPrefix + Link
    Assemble = GnuPlatformPrefix + Assemble

    #
    # squeeze runs of spaces and spaces at end
    #
    Compile = re.sub("  +", " ", Compile)
    Compile = re.sub(" +$", "", Compile)
    Link = re.sub("  +", " ", Link)
    Link = re.sub(" +$", "", Link)
    Assemble = re.sub("  +", " ", Assemble)
    Assemble = re.sub(" +$", "", Assemble)

    BootDir = "./cm3-boot-" + Target + "-" + Version

    P = [ "m3cc", "import-libs", "m3core", "libm3", "sysutils",
          "m3middle", "m3quake", "m3objfile", "m3linker", "m3back",
          "m3front", "cm3" ]

    #DoPackage(["", "realclean"] + P) or sys.exit(1)
    DoPackage(["", "buildlocal"] + P) or sys.exit(1)

    try:
        shutil.rmtree(BootDir)
    except:
        pass
    try:
        os.mkdir(BootDir)
    except:
        pass

    #
    # This would probably be a good use of XSL (xml style sheets)
    #
    Make = open(os.path.join(BootDir, "make.sh"), "wb")
    Makefile = open(os.path.join(BootDir, "Makefile"), "wb")
    UpdateSource = open(os.path.join(BootDir, "updatesource.sh"), "wb")

    Makefile.write(".SUFFIXES:\nall: cm3\n\n")

    for a in [UpdateSource, Make]:
        a.write("#!/bin/sh\n\nset -e\nset -x\n\n")

    for a in [Makefile]:
        a.write("# edit up here\n\n")
        a.write("Assemble=" + Assemble + "\nCompile=" + Compile + "\nLink=" + Link + "\n")
        a.write("\n\n# no more editing should be needed (except on Interix, look at the bottom)\n\n")

    for a in [Make]:
        a.write("Assemble=\"" + Assemble + "\"\nCompile=\"" + Compile + "\"\nLink=\"" + Link + "\"\n")

    for q in P:
        dir = GetPackagePath(q)
        for a in os.listdir(os.path.join(Root, dir, Config)):
            if not (a.endswith(".ms") or a.endswith(".is") or a.endswith(".s") or a.endswith(".c") or a.endswith(".h")):
                continue
            CopyFile(os.path.join(Root, dir, Config, a), BootDir)
            if a.endswith(".h"):
                continue
            Makefile.write("Objects += " + a + ".o\n" + a + ".o: " + a + "\n\t")
            if a.endswith(".c"):
                Command = "Compile"
            else:
                Command = "Assemble"
            for b in [Make, Makefile]:
                b.write("${" + Command + "} " + a + " -o " + a + ".o\n")

    Makefile.write("cm3: $(Objects)\n\t")

    for a in [Make, Makefile]:
        if Target.find("INTERIX") == -1:
            a.write("$(Link) -o cm3 *.o\n")
        else: # Do we still need this variation?
            a.write("rm -f ntdll.def ntdll.lib ntdll.dll ntdll.o ntdll.c.o a.out a.exe cm3 cm3.exe libntdll.a _m3main.c.o _m3main.o\n")
            a.write("gcc -g -o cm3 _m3main.c *.o -lm -L . -lntdll\n")

    Common = "Common"

    for a in [
            #
            # Add to this list as needed.
            # Adding more than necessary is ok -- assume the target system has no changes,
            # so we can replace whatever is there.
            #
            "m3-libs/libm3/src/os/POSIX/OSConfigPosix.m3",
            "m3-libs/libm3/src/random/m3makefile",
            "m3-libs/m3core/src/m3makefile",
            "m3-libs/m3core/src/Uwaitpid.quake",
            "m3-libs/m3core/src/thread.quake",
            "m3-libs/m3core/src/C/m3makefile",
            "m3-libs/m3core/src/C/" + Target + "/m3makefile",
            "m3-libs/m3core/src/C/" + Common + "/m3makefile",
            "m3-libs/m3core/src/Csupport/m3makefile",
            "m3-libs/m3core/src/float/m3makefile",
            "m3-libs/m3core/src/runtime/m3makefile",
            "m3-libs/m3core/src/runtime/common/m3makefile",
            "m3-libs/m3core/src/runtime/common/Compiler.tmpl",
            "m3-libs/m3core/src/runtime/common/m3text.h",
            "m3-libs/m3core/src/runtime/common/RTError.h",
            "m3-libs/m3core/src/runtime/common/RTMachine.i3",
            "m3-libs/m3core/src/runtime/common/RTProcess.h",
            "m3-libs/m3core/src/runtime/common/RTSignalC.c",
            "m3-libs/m3core/src/runtime/common/RTSignalC.h",
            "m3-libs/m3core/src/runtime/common/RTSignalC.i3",
            "m3-libs/m3core/src/runtime/common/RTSignal.i3",
            "m3-libs/m3core/src/runtime/common/RTSignal.m3",
            "m3-libs/m3core/src/runtime/" + Target + "/m3makefile",
            "m3-libs/m3core/src/runtime/" + Target + "/RTMachine.m3",
            "m3-libs/m3core/src/runtime/" + Target + "/RTSignal.m3",
            "m3-libs/m3core/src/runtime/" + Target + "/RTThread.m3",
            "m3-libs/m3core/src/text/TextLiteral.i3",
            "m3-libs/m3core/src/thread/m3makefile",
            "m3-libs/m3core/src/thread/PTHREAD/m3makefile",
            "m3-libs/m3core/src/thread/PTHREAD/ThreadPThread.m3",
            "m3-libs/m3core/src/thread/PTHREAD/ThreadPThreadC.i3",
            "m3-libs/m3core/src/thread/PTHREAD/ThreadPThreadC.c",
            "m3-libs/m3core/src/time/POSIX/m3makefile",
            "m3-libs/m3core/src/unix/m3makefile",
            "m3-libs/m3core/src/unix/linux-32/m3makefile",
            "m3-libs/m3core/src/unix/linux-64/m3makefile",
            "m3-libs/m3core/src/unix/freebsd-common/m3makefile",
            "m3-libs/m3core/src/unix/freebsd-common/Uerror.i3",
            "m3-libs/m3core/src/unix/freebsd-common/Usysdep.i3",
            "m3-libs/m3core/src/unix/freebsd-common/Uucontext.i3",
            "m3-libs/m3core/src/unix/Common/m3makefile",
            "m3-libs/m3core/src/unix/Common/m3unix.h",
            "m3-libs/m3core/src/unix/Common/Udir.i3",
            "m3-libs/m3core/src/unix/Common/UdirC.c",
            "m3-libs/m3core/src/unix/Common/Usignal.i3",
            "m3-libs/m3core/src/unix/Common/Ustat.i3",
            "m3-libs/m3core/src/unix/Common/UstatC.c",
            "m3-libs/m3core/src/unix/Common/UtimeC.c",
            "m3-libs/m3core/src/unix/Common/Uucontext.i3",
            "m3-sys/cminstall/src/config-no-install/SOLgnu",
            "m3-sys/cminstall/src/config-no-install/SOLsun",
            "m3-sys/cminstall/src/config-no-install/Solaris.common",
            "m3-sys/cminstall/src/config-no-install/Unix.common",
            "m3-sys/cminstall/src/config-no-install/cm3cfg.common",
            "m3-sys/cminstall/src/config-no-install/" + Target,
            "m3-sys/m3cc/src/m3makefile",
            "m3-sys/m3cc/src/gcc/m3cg/parse.c",
            "m3-sys/m3middle/src/Target.i3",
            "m3-sys/m3middle/src/Target.m3",
            "scripts/python/pylib.py",
            "m3-libs/m3core/src/C/" + Target + "/Csetjmp.i3",
            "m3-libs/m3core/src/C/" + Target + "/m3makefile",
            "m3-libs/m3core/src/C/" + Common + "/Csetjmp.i3",
            "m3-libs/m3core/src/C/" + Common + "/Csignal.i3",
            "m3-libs/m3core/src/C/" + Common + "/Cstdio.i3",
            "m3-libs/m3core/src/C/" + Common + "/Cstring.i3",
            "m3-libs/m3core/src/C/" + Common + "/m3makefile",
            ]:
        source = os.path.join(Root, a)
        if FileExists(source):
            name = GetLastPathElement(a)
            reldir = RemoveLastPathElement(a)
            destdir = os.path.join(BootDir, reldir)
            dest = os.path.join(destdir, name)
            try:
                os.makedirs(destdir)
            except:
                pass
            CopyFile(source, dest)

            for b in [UpdateSource, Make]:
                b.write("mkdir -p /dev2/cm3/" + reldir + "\n")
                b.write("cp " + a + " /dev2/cm3/" + a + "\n")

    for a in [UpdateSource, Make, Makefile]:
        a.close()

    _MakeArchive(BootDir[2:])

#-----------------------------------------------------------------------------
# map action names to code and possibly other data

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    ActionInfo = {
        "build":
        {
            "Commands": [_BuildLocalFunction],
        },
        "buildlocal":
        {
            "Commands": [_BuildLocalFunction],
        },
        "buildglobal":
        {
            "Commands": [_BuildGlobalFunction, _ShipFunction],
        },
        "buildship":
        {
            "Commands": [_BuildGlobalFunction, _ShipFunction],
        },
        "ship":
        {
            "Commands": [_ShipFunction],
        },
        "clean":
        {
            "Commands": [_CleanLocalFunction],
            "KeepGoing": True,
        },
        "cleanlocal":
        {
            "Commands": [_CleanLocalFunction],
            "KeepGoing": True,
        },
        "cleanglobal":
        {
            "Commands": [_CleanGlobalFunction],
            "KeepGoing": True,
        },
        "realclean":
        {
            "Commands": [_RealCleanFunction],
            "KeepGoing": True,
        },
    }

#-----------------------------------------------------------------------------

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    BuildAll = getenv("CM3_ALL") or False

def _FilterPackage(Package):
    PackageConditions = {
        "m3gdb":
            (M3GDB or CM3_GDB) and
            {"FreeBSD4": True,
            "LINUXLIBC6" : True,
            "SOLgnu" : True,
            "NetBSD2_i386" : True,
            "NT386GNU" : True,
            }.get(Target, False),

        "tcl": BuildAll or HAVE_TCL,
        "tapi": BuildAll or OSType == "WIN32",
        "serial": BuildAll or HAVE_SERIAL,
        "X11R4": BuildAll or OSType != "WIN32",
        "m3cc": (GCC_BACKEND and (not OMIT_GCC) and (not "skipgcc" in sys.argv) and (not "omitgcc" in sys.argv) and (not "nogcc" in sys.argv)),
    }
    return PackageConditions.get(Package, True)

#-----------------------------------------------------------------------------

def FilterPackages(Packages):
    Packages = filter(_FilterPackage, Packages)
    return Packages

#-----------------------------------------------------------------------------

if _Program != "make-msi.py":
# general problem of way too much stuff at global scope
# workaround some of it
    PackageSets = {
    #
    # These lists are deliberately in a jumbled order
    # in order to depend on OrderPackages working.
    #
    # This needs to be still further data driven,
    # and a full ordering is not necessary, only
    # a partial ordering -- stuff could build in parallel.
    #
        "min" :
            [
            "import-libs",
            "libm3",
            "m3core",
            ],
    
        "std" :
            [
    
        # demo programs
    
            "cube",
            "calculator",
            "fisheye",
            "mentor",
    
        # system / compiler libraries and tools
    
            "m3quake",
            "m3middle",
            "m3scanner",
            "m3tools",
            "m3cgcat",
            "m3cggen",
            "m3cc",
            "m3objfile",
            "m3linker",
            "m3back",
            "m3staloneback",
            "m3front",
            "cm3",
            "m3gdb",
            "m3bundle",
            "mklib",
            "fix_nl",
            "libdump",
            "windowsResources",
            "cm3ide",
    
        # more useful quasi-standard libraries
    
            "arithmetic",
            "bitvector",
            "digraph",
            "parseparams",
            "realgeometry",
            "set",
            "slisp",
            "sortedtableextras",
            "table-list",
            "tempfiles",
            "tcl",
            "tcp",
            "udp",
            "libsio",
            "libbuf",
            "debug",
            "listfuncs",
            "embutils",
            "m3tk-misc",
            "http",
            "binIO",
            "deepcopy",
            "sgml",
            "commandrw",
    
            # some CM3 communication extensions
    
            "tapi",
            "serial",
    
            # tools
    
            "m3tk",
            "mtex",
            "m3totex",
            "m3tohtml",
            "m3scan",
            "m3markup",
            "m3browser",
            "cmpdir",
            "cmpfp",
            "dirfp",
            "uniq",
            "pp",
            # "kate"   # can be shipped only on systems with KDE
            # "nedit",
    
            # network objects -- distributed programming
    
            "netobj",
            "netobjd",
            "stubgen",
            "events",
            "rdwr",
            "sharedobj",
            "sharedobjgen",
    
            # database packages
    
            "odbc",
            "postgres95",
            "db",
            "smalldb",
            "stable",
            "stablegen",
    
            # the standard graphical user interface: trestle and formsvbt
    
            "X11R4",
            "ui",
            "PEX",
            "vbtkit",
            "cmvbt",
            "jvideo",
            "videovbt",
            "web",
            "formsvbtpixmaps",
            "formsvbt",
            "formsview",
            "formsedit",
            "codeview",
            "mg",
            "mgkit",
            "opengl",
            "anim3D",
            "zeus",
            "m3zume",
    
            # obliq
            "synloc",
            "synex",
            "metasyn",
            "obliqrt",
            "obliqparse",
            "obliqprint",
            "obliq",
            "obliqlibemb",
            "obliqlibm3",
            "obliqlibui",
            "obliqlibanim",
            "obliqlib3D",
            "obliqsrvstd",
            "obliqsrvui",
            "obliqbinmin",
            "obliqbinstd",
            "obliqbinui",
            "obliqbinanim",
            "visualobliq",
            "vocgi",
            "voquery",
            "vorun",
    
            # more graphics depending on obliq
    
            "webvbt",
    
            # more tools
    
            "recordheap",
            "rehearsecode",
            "replayheap",
            "showheap",
            "shownew",
            "showthread",
    
            # The Juno-2 graphical constraint based editor
    
            "pkl-fonts",
            "juno-machine",
            "juno-compiler",
            "juno-app",
    
            "deckscape",
            "webscape",
            "webcat",
    
            "import-libs",
            "m3core",
            "libm3",
            "sysutils",
    
            # cvsup
            "cvsup/suplib",
            "cvsup/client",
            "cvsup/server",
            "cvsup/cvpasswd",
            ],
    
    
        "all": # in order
            [
        # backend
            "m3cc",
    
        # base libraries
    
            "import-libs",
            "m3core",
            "libm3",
            "windowsResources",
            "sysutils",
            "patternmatching",
    
        # system / compiler libraries and tools
    
            "m3middle",
            "m3objfile",
            "m3linker",
            "m3back",
            "m3staloneback",
            "m3front",
            "m3quake",
            "cm3",
            "m3scanner",
            "m3tools",
            "m3cgcat",
            "m3cggen",
    
            "m3gdb",
            "m3bundle",
            "mklib",
            "fix_nl",
            "libdump",
    
        # more useful quasi-standard libraries
    
            "arithmetic",
            "bitvector",
            "digraph",
            "parseparams",
            "realgeometry",
            "set",
            "slisp",
            "sortedtableextras",
            "table-list",
            "tempfiles",
            "tcl",
            "tcp",
            "udp",
            "libsio",
            "libbuf",
            "debug",
            "listfuncs",
            "embutils",
            "m3tk-misc",
            "http",
            "binIO",
            "deepcopy",
            "sgml",
            "commandrw",
    
            "cm3ide",
    
            # some CM3 communication extensions
    
            "tapi",
            "serial",
    
            # tools
    
            "m3tk",
            "mtex",
            "m3totex",
            "m3tohtml",
            "m3scan",
            "m3markup",
            "m3browser",
            "cmpdir",
            "cmpfp",
            "dirfp",
            "uniq",
            # "kate"   # can be shipped only on systems with KDE
            # "nedit",
    
            # network objects -- distributed programming
    
            "netobj",
            "netobjd",
            "stubgen",
            "events",
            "rdwr",
            "sharedobj",
            "sharedobjgen",
    
            # database packages
    
            "odbc",
            "postgres95",
            "db",
            "smalldb",
            "stable",
            "stablegen",
    
            # the standard graphical user interface: trestle and formsvbt
    
            "X11R4",
            "ui",
            "PEX",
            "vbtkit",
            "cmvbt",
            "jvideo",
            "videovbt",
            "web",
            "formsvbtpixmaps",
            "formsvbt",
            "formsview",
            "formsedit",
            "codeview",
            "mg",
            "mgkit",
            "opengl",
            "anim3D",
            "zeus",
            "m3zume",
    
            # obliq
            "synloc",
            "synex",
            "metasyn",
            "obliqrt",
            "obliqparse",
            "obliqprint",
            "obliq",
            "obliqlibemb",
            "obliqlibm3",
            "obliqlibui",
            "obliqlibanim",
            "obliqlib3D",
            "obliqsrvstd",
            "obliqsrvui",
            "obliqbinmin",
            "obliqbinstd",
            "obliqbinui",
            "obliqbinanim",
            "visualobliq",
            "vocgi",
            "voquery",
            "vorun",
    
            # more graphics depending on obliq
    
            "webvbt",
    
            # more tools
    
            "recordheap",
            "rehearsecode",
            "replayheap",
            "showheap",
            "shownew",
            "showthread",
    
            # The Juno-2 graphical constraint based editor
    
            "pkl-fonts",
            "juno-machine",
            "juno-compiler",
            "juno-app",
    
            # demo programs
    
            "cube",
            "calculator",
            "fisheye",
            "mentor",
    
            "cit_common",
            "m3tmplhack",
            "cit_util",
            "term",
            "deepcopy",
            "paneman",
            "paneman/kemacs",
            "drawcontext",
            "drawcontext/dcpane",
            "drawcontext/kgv",
            "hack",
            "m3browserhack",
            "parserlib/ktoklib",
            "parserlib/klexlib",
            "parserlib/kyacclib",
            "parserlib/ktok",
            "parserlib/klex",
            "parserlib/kyacc",
            "parserlib/kext",
            "parserlib/parserlib",
            #"parserlib/parserlib/test",
            "pp",
            #"kate",
            "sgml",
    
            "deckscape",
            "webscape",
            "webcat",

            # cvsup
            "cvsup/suplib",
            "cvsup/client",
            "cvsup/server",
            "cvsup/cvpasswd",
            ],
    }

#-----------------------------------------------------------------------------

def OrderPackages(Packages):
    AllPackagesInOrder = PackageSets["all"]
    AllPackagesHashed = dict.fromkeys(AllPackagesInOrder)
    PackagesInOrder =  [ ]
    PackagesHashed = dict.fromkeys(Packages)

    #
    # Make sure everything is in AllPackagesInOrder.
    #
    for Package in Packages:
        if not Package in AllPackagesHashed:
            print("ERROR: " + Package + " is not in PackageSets[\"all\"]")
            sys.exit(1)

    for Package in AllPackagesInOrder:
        if Package in PackagesHashed:
            PackagesInOrder += [Package]
            del PackagesHashed[Package]

    return PackagesInOrder

#-----------------------------------------------------------------------------

def DoPackage(args, PackagesFromCaller = None):

    SetupEnvironment()

    # print("args is " + str(args))
    # sys.stdout.flush()

    if not (PackagesFromCaller is None):
        PackagesFromCaller = FilterPackages(PackagesFromCaller)
        PackagesFromCaller = OrderPackages(PackagesFromCaller)
        if not PackagesFromCaller:
            print("no packages left")
            return True

    if PackagesFromCaller:
        Usage = \
"""
%(BaseName)s [ GenericOptions ] [ GenericCommand ]

  will apply the given symbolic command to the following %(N)s packages:

%(Packages)s

GenericOptions:
%(GenericOptions)s

GenericCommand:
%(GenericCommands)s"""
    else:
        Usage = \
"""
%(BaseName)s [ GenericOptions ] [ GenericCommand ] pkg+

will apply the given symbolic command to one or more CM3 packages.

GenericOptions:
%(GenericOptions)s

GenericCommand:
%(GenericCommands)s"""

    ShowUsage(
        args,
        Usage,
        PackagesFromCaller)

    if (not PackagesFromCaller) and (not args[1:]):
        print("no actions and no packages specified\n")
        sys.stdout.flush()
        sys.exit(1)

    PackagesFromCommandLine = []
    ActionCommands = []
    Packages = None
    ListOnly = False
    KeepGoing = False
    NoAction = False
    AllTargets = _GetAllTargets()
    for arg in args[1:]:
        if ((arg == "")
            or (arg in AllTargets)
            or (arg == "keep")
            or (arg == "noclean")
            or (arg == "nocleangcc")
            or (arg == "nogcc")
            or (arg == "skipgcc")
            or (arg == "omitgcc")
            or (arg == "boot")):
            continue
        if arg.startswith("-"):
            if arg == "-l":
                ListOnly = True
            elif arg == "-k":
                KeepGoing = True
            elif arg == "-n":
                NoAction = True
            else:
                ExtraArgs += arg
        else:
            if not ActionCommands:
                Action = ActionInfo.get(arg)
                if Action:
                    ActionCommands = Action["Commands"]
                    KeepGoing = Action.get("KeepGoing", False)
                else:
                    PackagesFromCommandLine.append(arg)
            else:
                PackagesFromCommandLine.append(arg)

    if not ActionCommands:
        if PackagesFromCaller:
            ActionCommands = ActionInfo["build"]["Commands"]
        else:
            print("no actions specified " + args[0])
            sys.stdout.flush()
            sys.exit(1)

    if PackagesFromCaller:
        if PackagesFromCommandLine:
            print("cannot specify packages on command line with " + args[0])
            sys.stdout.flush()
            sys.exit(1)
        Packages = PackagesFromCaller
    else: # not PackagesFromCaller:
        if not PackagesFromCommandLine:
            print("no packages specified " + args[0])
            sys.stdout.flush()
            sys.exit(1)
        Packages = PackagesFromCommandLine

    PackageDirectories = [ ]

    for p in Packages:

        q = GetPackagePath(p)
        if not q:
            File = __file__
            sys.stderr.write("%(File)s *** cannot find package %(p)s\n" % vars())
            sys.exit(1)

        q = os.path.join(Root, q)
        if isfile(os.path.join(q, "src", "m3makefile")):
            PackageDirectories.append(q)
            continue

        File = __file__
        sys.stderr.write("%(File)s *** cannot find package %(p)s / %(q)s\n" % vars())
        sys.exit(1)

    if not ActionCommands:
        File = __file__
        sys.stderr.write("%(File)s: no action defined, aborting\n" % vars())
        sys.exit(1)
        #return False

    if not PackageDirectories:
        File = __file__
        sys.stderr.write("%(File)s: no packages\n" % vars())
        sys.exit(1)
        #return False

    if ListOnly:
        ListPackage(PackageDirectories)
        sys.exit(0)
        #return True

    Success = True

    for p in PackageDirectories:
        print("== package %(p)s ==" % vars())
        print("")
        for a in ActionCommands:
            ExitCode = a(NoAction, p)
            if ExitCode != 0:
                Success = False
                if not KeepGoing:
                    print(" *** execution of %s failed ***" % (str(ActionCommands)))
                    sys.exit(1)
            if KeepGoing:
                print(" ==> %s returned %s" % (str(ActionCommands), ExitCode))
                print("")
            else:
                print(" ==> %(p)s done" % vars())
                print("")

    return Success

#-----------------------------------------------------------------------------

def DeleteFile(a):
    if os.name != "nt":
        print("rm -f " + a)
    else:
        print("del /f /a " + a)
    if isfile(a):
        os.chmod(ConvertPathForPython(a), 0700)
        os.remove(ConvertPathForPython(a))

def MoveFile(a, b):
    if os.name != "nt":
        print("mv " + a + " " + b)
    else:
        print("move " + a + " " + b)
    shutil.move(ConvertPathForPython(a), ConvertPathForPython(b))

#-----------------------------------------------------------------------------

def CreateDirectory(a):
    if os.name != "nt":
        print("mkdir -p " + a)
    else:
        print("mkdir " + a)
    if not isdir(a):
        os.makedirs(a)
    return True

#-----------------------------------------------------------------------------

def MakeTempDir():
    if getenv("TMPDIR"):
        if not os.path.exists(getenv("TMPDIR")):
            CreateDirectory(getenv("TMPDIR"))
        return
    if getenv("TEMP") and not os.path.exists(getenv("TEMP")):
        CreateDirectory(getenv("TEMP"))

MakeTempDir()

#-----------------------------------------------------------------------------

def CopyFile(From, To):
    if isdir(To):
        To = os.path.join(To, os.path.basename(From))
    # Cygwin says foo exists when only foo.exe exists, and then remove fails.
    if isfile(To):
        try:
            os.remove(ConvertPathForPython(To))
        except:
            pass
    CopyCommand = "copy"
    if os.name != "nt":
        CopyCommand = "cp -Pv"
    print(CopyCommand + " " + From + " " + To)
    if os.path.islink(ConvertPathForPython(From)):
        os.symlink(os.readlink(ConvertPathForPython(From)), ConvertPathForPython(To))
    else:
        shutil.copy(ConvertPathForPython(From), ConvertPathForPython(To))
    return True

#-----------------------------------------------------------------------------

def CopyFileIfExist(From, To):
    if isfile(From):
        return CopyFile(From, To)
    return True

#-----------------------------------------------------------------------------

def CopyConfigForDevelopment():
    #
    # The development environment is easily reconfigured
    # for different targets based on environment variables and `uname`.
    # The use of `uname` is not fully fleshed out (yet).
    #
    # The development environment depends on having a source tree, at least the cminstall\src\config directory.
    #

    To = os.path.join(InstallRoot, "bin")

    #
    # First delete all the "distribution config files".
    #
    a = os.path.join(Root, "m3-sys", "cminstall", "src")

    for b in ["config", "config-no-install"]:
        for File in glob.glob(os.path.join(a, b, "*")):
            if isfile(File):
                DeleteFile(os.path.join(To, os.path.basename(File)))

    # CopyFile(os.path.join(Root, a, "config", "cm3.cfg"), To) or FatalError()
    CopyFile(os.path.join(Root, a, "config-no-install", "cm3.cfg"), To) or FatalError()
    return True

#-----------------------------------------------------------------------------

#def CopyDirectoryNonRecursive(From, To):
#    CreateDirectory(To)
#    for File in glob.glob(os.path.join(From, "*")):
#        if isfile(File):
#            print(File + " => " + To + "\n")
#            CopyFile(File, To)
#    return True

#-----------------------------------------------------------------------------

def CopyConfigForDistribution(To):
    #
    # The distributed environment is minimal and targets only one
    # or a small number of targets (e.g. NT386*).
    #
    # The distributed environment does not require a source tree.
    #
    Bin  = os.path.join(To, "bin")
    dir = os.path.join(Bin, "config")
    CreateDirectory(dir)
    for b in [Target + "*", "*.common"]:
        for File in glob.glob(os.path.join(Root, "m3-sys", "cminstall", "src", "config-no-install", b)):
            if isfile(File):
                #print(File + " => " + dir + "\n")
                CopyFile(File, dir)
    open(os.path.join(Bin, "cm3.cfg"), "w").write("INSTALL_ROOT = (path() & \"/..\")\ninclude(path() & \"/config/" + Config + "\")\n")
    return True

#-----------------------------------------------------------------------------

def _CopyCompiler(From, To):

    CreateDirectory(To)

    from_cm3 = os.path.join(From, "cm3")
    from_cm3exe = os.path.join(From, "cm3.exe")
    from_cm3cg = os.path.join(From, "cm3cg")
    from_cm3cgexe = os.path.join(From, "cm3cg.exe")

    if (Config != "NT386"
            and not FileExists(from_cm3)
            and not FileExists(from_cm3exe)
            and not FileExists(from_cm3cg)
            and not FileExists(from_cm3cgexe)):
        FatalError("none of " + from_cm3 + ", " + from_cm3exe + ", " + from_cm3cg + ", " + from_cm3cgexe + " exist")

    #
    # check .exe first to avoid being fooled by Cygwin
    #
    if FileExists(from_cm3exe):
        from_cm3 = from_cm3exe
    elif FileExists(from_cm3):
        pass
    else:
        from_cm3 = None
        from_cm3exe = None

    if from_cm3:
        #
        # delete .exe first to avoid being fooled by Cygwin
        #
        DeleteFile(os.path.join(To, "cm3.exe"))
        DeleteFile(os.path.join(To, "cm3"))
        CopyFile(from_cm3, To) or FatalError("3")
        CopyFileIfExist(os.path.join(From, "cm3.pdb"), To) or FatalError("5")

    if FileExists(from_cm3cgexe):
        from_cm3cg = from_cm3cgexe
    elif FileExists(from_cm3cg):
        pass
    else:
        from_cm3cg = None
        from_cm3cgexe = None
    if from_cm3cg:
        #
        # delete .exe first to avoid being fooled by Cygwin
        #
        DeleteFile(os.path.join(To, "cm3cg.exe"))
        DeleteFile(os.path.join(To, "cm3cg"))
        CopyFile(from_cm3cg, To) or FatalError("4")

    return True

#-----------------------------------------------------------------------------

def ShipBack():
    return _CopyCompiler(os.path.join(Root, "m3-sys", "m3cc", Config),
                         os.path.join(InstallRoot, "bin"))

#-----------------------------------------------------------------------------

def ShipFront():
    return _CopyCompiler(os.path.join(Root, "m3-sys", "cm3", Config),
                         os.path.join(InstallRoot, "bin"))

#-----------------------------------------------------------------------------

def ShipCompiler():
    return ShipBack() and ShipFront()

#-----------------------------------------------------------------------------

def CopyMklib(From, To):
    #
    # Copy mklib from one InstallRoot to another, possibly having cleaned out the intermediate directories.
    #
    From = os.path.join(From, "bin")
    To = os.path.join(To, "bin")
    CreateDirectory(To)

    mklib = os.path.join(From, "mklib")
    mklibexe = os.path.join(From, "mklib.exe")
    if FileExists(mklibexe):
        mklib = mklibexe
    elif FileExists(mklib):
        pass
    else:
        FatalError("neither " + mklib + " nor " + mklibexe + " exist")

    # important to delete mklib.exe ahead of mklib for Cygwin
    DeleteFile(os.path.join(To, "mklib.exe"))
    DeleteFile(os.path.join(To, "mklib"))

    CopyFile(mklib, To) or FatalError("6")

    CopyFileIfExist(os.path.join(From, "mklib.pdb"), To) or FatalError("8")
    return True

#-----------------------------------------------------------------------------

def CopyCompiler(From, To):
    #
    # Copy the compiler from one InstallRoot to another, possibly having cleaned out the intermediate directories.
    # The config file always comes right out of the source tree.
    #
    _CopyCompiler(os.path.join(From, "bin"), os.path.join(To, "bin"))
    CopyMklib(From, To) or FatalError("9")
    return True

#-----------------------------------------------------------------------------

def GetProgramFiles():
    # Look for Program Files.
    # This is expensive and callers are expected to cache it.
    ProgramFiles = []
    for d in ["PROGRAMFILES", "PROGRAMFILES(X86)", "PROGRAMW6432"]:
        e = os.environ.get(d)
        if e and (not (e in ProgramFiles)) and isdir(e):
            ProgramFiles.append(e)
    if len(ProgramFiles) == 0:
        SystemDrive = os.environ.get("SystemDrive", "")
        a = os.path.join(SystemDrive, "Program Files")
        if isdir(a):
            ProgramFiles.append(a)
    return ProgramFiles

def SetupEnvironment():
    SystemDrive = os.environ.get("SystemDrive", "")
    if os.environ.get("OS") == "Windows_NT":
        HostIsNT = True
    else:
        HostIsNT = False

    SystemDrive = os.environ.get("SYSTEMDRIVE")
    if SystemDrive:
        SystemDrive += os.path.sep

    # Do this earlier so that its link isn't a problem.
    # Looking in the registry HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2
    # would be reasonable here.

    if CM3IsCygwin:
        _SetupEnvironmentVariableAll(
            "PATH",
            ["cygwin1.dll"],
            os.path.join(SystemDrive, "cygwin", "bin"))

    # some host/target confusion here..

    if Target == "NT386" and HostIsNT and Config == "NT386" and (not GCC_BACKEND) and OSType == "WIN32":

        VCBin = ""
        VCInc = ""
        VCLib = ""
        MspdbDir = ""

        # 4.0 e:\MSDEV
        # 5.0 E:\Program Files\DevStudio\SharedIDE
        MSDevDir = os.environ.get("MSDEVDIR")

        # 5.0
        MSVCDir = os.environ.get("MSVCDIR") # E:\Program Files\DevStudio\VC

        # 7.1 Express
        VCToolkitInstallDir = os.environ.get("VCTOOLKITINSTALLDIR") # E:\Program Files\Microsoft Visual C++ Toolkit 2003 (not set by vcvars32)

        # 8.0 Express
        # E:\Program Files\Microsoft Visual Studio 8\VC
        # E:\Program Files\Microsoft Visual Studio 8\Common7\Tools
        DevEnvDir = os.environ.get("DevEnvDir") # E:\Program Files\Microsoft Visual Studio 8\Common7\IDE
        VSInstallDir = os.environ.get("VSINSTALLDIR") # E:\Program Files\Microsoft Visual Studio 8
        # VS80CommonTools = os.environ.get("VS80COMNTOOLS") # E:\Program Files\Microsoft Visual Studio 8\Common7\Tools
        VCInstallDir = os.environ.get("VCINSTALLDIR") # E:\Program Files\Microsoft Visual Studio 8\VC

        # 9.0 Express
        # always, global
        #VS90COMNTOOLS=D:\msdev\90\Common7\Tools\
        # after running the shortcut
        #VCINSTALLDIR=D:\msdev\90\VC
        #VSINSTALLDIR=D:\msdev\90
        
        VSCommonTools = os.environ.get("VS90COMNTOOLS")
        
        if VSCommonTools and not VSInstallDir:
            VSInstallDir = RemoveLastPathElement(RemoveLastPathElement(VSCommonTools))
        
        # The Windows SDK is carried with the express edition and tricky to find.
        # Best if folks just run the installed shortcut probably.
        # We do a pretty good job now of finding it, be need to encode
        # more paths to known versions.

        # This is not yet finished.
        #
        # Probe the partly version-specific less-polluting environment variables,
        # from newest to oldest.
        # That is, having setup alter PATH, INCLUDE, and LIB system-wide is not
        # a great idea, but having setup set DevEnvDir, VSINSTALLDIR, VS80COMNTOOLS, etc.
        # isn't so bad and we can temporarily establish the first set from the second
        # set.

        if VSInstallDir:
            # Visual C++ 2005/8.0, at least the Express Edition, free download
            # also Visual C++ 2008/9.0 Express Edition

            if not VCInstallDir:
                VCInstallDir = os.path.join(VSInstallDir, "VC")
                #print("VCInstallDir:" + VCInstallDir)
            if not DevEnvDir:
                DevEnvDir = os.path.join(VSInstallDir, "Common7", "IDE")
                #print("DevEnvDir:" + DevEnvDir)

            MspdbDir = DevEnvDir

        elif VCToolkitInstallDir:
            # free download Visual C++ 2003; no longer available

            VCInstallDir = VCToolkitInstallDir

        elif MSVCDir and MSDevDir:
            # Visual C++ 5.0

            pass # do more research
            # VCInstallDir = MSVCDir

        elif MSDevDir:
            # Visual C++ 4.0, 5.0

            pass # do more research
            # VCInstallDir = MSDevDir

        else:
            # This is what really happens on my machine, for 8.0.
            # It might be good to guide pylib.py to other versions,
            # however setting things up manually suffices and I have, um,
            # well automated.

            Msdev = os.path.join(SystemDrive, "msdev", "80")
            VCInstallDir = os.path.join(Msdev, "VC")
            DevEnvDir = os.path.join(Msdev, "Common7", "IDE")

        if VCInstallDir:
            VCBin = os.path.join(VCInstallDir, "bin")
            VCLib = os.path.join(VCInstallDir, "lib")
            VCInc = os.path.join(VCInstallDir, "include")

        if DevEnvDir:
            MspdbDir = DevEnvDir
        #elif VCBin:
        #    MspdbDir = VCBin

        # Look for SDKs.
        # expand this as they are released/discovered
        # ordering is from newest to oldest
        
        PossibleSDKs = [os.path.join("Microsoft SDKs", "Windows", "v6.0A"), "Microsoft Platform SDK for Windows Server 2003 R2"]        
        SDKs = []

        for a in GetProgramFiles():
            #print("checking " + a)
            for b in PossibleSDKs:
                c = os.path.join(a, b)
                #print("checking " + c)
                if isdir(c) and not (c in SDKs):
                    SDKs.append(c)

        # Make sure %INCLUDE% contains errno.h and windows.h.
        # This doesn't work correctly for Cygwin Python, ok.

        if _CheckSetupEnvironmentVariableAll("INCLUDE", ["errno.h", "windows.h"], VCInc):
            for a in SDKs:
                b = os.path.join(a, "include")
                if isfile(os.path.join(b, "windows.h")):
                    _SetupEnvironmentVariableAll("INCLUDE", ["errno.h", "windows.h"], VCInc + ";" + b, ";")
                    break

        # Make sure %LIB% contains kernel32.lib and libcmt.lib.
        # We carry our own kernel32.lib so we don't look in the SDKs.
        # We usually use msvcrt.lib and not libcmt.lib, but Express 2003 had libcmt.lib and not msvcrt.lib
        # I think, and libcmt.lib is always present.

        _SetupEnvironmentVariableAll(
            "LIB",
            ["kernel32.lib", "libcmt.lib"],
            VCLib + ";" + os.path.join(InstallRoot, "lib"))

        # Check that cl.exe and link.exe are in path, and if not, add VCBin to it,
        # checking that they are in it.
        #
        # Do this before mspdb*dll because it sometimes gets it in the path.
        # (Why do we care?)

        _SetupEnvironmentVariableAll("PATH", ["cl", "link"], VCBin)
        
        # If none of mspdb*.dll are in PATH, add MpsdbDir to PATH, and check that one of them is in it.

        _SetupEnvironmentVariableAny(
            "PATH",
            ["mspdb80.dll", "mspdb71.dll", "mspdb70.dll", "mspdb60.dll", "mspdb50.dll", "mspdb41.dll", "mspdb40.dll", "dbi.dll"],
            MspdbDir)

        # Try to get mt.exe in %PATH% if it isn't already.
        # We only need this for certain toolsets.

        if not SearchPath("mt.exe", os.environ.get("PATH")):
            for a in SDKs:
                b = os.path.join(a, "bin")
                if isfile(os.path.join(b, "mt.exe")):
                    SetEnvironmentVariable("PATH", os.environ.get("PATH") + os.pathsep + b)
                    break

        # sys.exit(1)

        # The free Visual C++ 2003 has neither delayimp.lib nor msvcrt.lib.
        # Very old toolsets have no delayimp.lib.
        # The Quake config file checks these environment variables.

        Lib = os.environ.get("LIB")
        if not SearchPath("delayimp.lib", Lib):
            os.environ["USE_DELAYLOAD"] = "0"
            print("set USE_DELAYLOAD=0")

        if not SearchPath("msvcrt.lib", Lib):
            os.environ["USE_MSVCRT"] = "0"
            print("set USE_MSVCRT=0")

    # some host/target confusion here..

    if Target == "NT386MINGNU" or (Target == "NT386" and GCC_BACKEND and OSType == "WIN32"):

        _ClearEnvironmentVariable("LIB")
        _ClearEnvironmentVariable("INCLUDE")

        _SetupEnvironmentVariableAll(
            "PATH",
            ["gcc", "as", "ld"],
            os.path.join(SystemDrive, "mingw", "bin"))

        # need to probe for ld that accepts response files.
        # For example, this version does not:
        # C:\dev2\cm3\scripts\python>ld -v
        # GNU ld version 2.15.91 20040904
        # This comes with Qt I think (free Windows version)
        #
        # This version works:
        # C:\dev2\cm3\scripts\python>ld -v
        # GNU ld version 2.17.50 20060824

        # Ensure msys make is ahead of mingwin make, by adding
        # msys to the start of the path after adding mingw to the
        # start of the path. Modula-3 does not generally use
        # make, but this might matter when building m3cg, and
        # is usually the right thing.

        _SetupEnvironmentVariableAll(
            "PATH",
            ["sh", "sed", "gawk", "make"],
            os.path.join(SystemDrive, "msys", "1.0", "bin"))

    # some host/target confusion here..

    if Target == "NT386GNU" or (Target == "NT386" and GCC_BACKEND and OSType == "POSIX"):

        #_ClearEnvironmentVariable("LIB")
        #_ClearEnvironmentVariable("INCLUDE")

        #if HostIsNT:
        #    _SetupEnvironmentVariableAll(
        #        "PATH",
        #        ["cygX11-6.dll"],
        #        os.path.join(SystemDrive, "cygwin", "usr", "X11R6", "bin"))

        _SetupEnvironmentVariableAll(
            "PATH",
            ["gcc", "as", "ld"],
            os.path.join(SystemDrive, "cygwin", "bin"))

#-----------------------------------------------------------------------------

# ported from scripts/win/sysinfo.cmd
# not currently used

def CheckForLinkSwitch(Switch):
    EnvName = "USE_" + Switch
    EnvValue = "0"
    if os.system("link | findstr /i /c:\" /" + Switch + "\" >" + os.devnull) == 0:
        EnvValue = "1"
    os.environ[EnvName] = EnvValue
    print("set " + EnvName + "=" + EnvValue)

#-----------------------------------------------------------------------------

# packaging support

def InstallLicense(Root, InstallRoot):

    license = os.path.join(InstallRoot, "license")
    CreateDirectory(license)

    for a in glob.glob(os.path.join(Root, "COPYRIGHT*")):
        CopyFile(a, os.path.join(license, GetLastPathElement(a))) or FatalError()

    CopyFile(os.path.join(Root, "m3-libs", "arithmetic", "copyrite.txt"), os.path.join(license, "COPYRIGHT-M3NA")) or FatalError()
    CopyFile(os.path.join(Root, "m3-tools", "cvsup", "License"), os.path.join(license, "COPYRIGHT-JDP-CVSUP")) or FatalError()
    CopyFile(os.path.join(Root, "m3-sys", "COPYRIGHT-CMASS"), os.path.join(license, "COPYRIGHT-CMASS")) or FatalError()

    open(os.path.join(license, "COPYRIGHT-ELEGO-SYSUTILS"), "w").write(
"""Copyright 1999-2002 elego Software Solutions GmbH, Berlin, Germany.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
""")

    open(os.path.join(license, "COPYRIGHT-OLIVETTI"), "w").write(
"""                      Copyright (C) Olivetti 1989 
                          All Rights reserved

Use and copy of this software and preparation of derivative works based
upon this software are permitted to any person, provided this same
copyright notice and the following Olivetti warranty disclaimer are
included in any copy of the software or any modification thereof or
derivative work therefrom made by any person.

This software is made available AS IS and Olivetti disclaims all
warranties with respect to this software, whether expressed or implied
under any law, including all implied warranties of merchantibility and
fitness for any purpose. In no event shall Olivetti be liable for any
damages whatsoever resulting from loss of use, data or profits or
otherwise arising out of or in connection with the use or performance
of this software.
""")

    class State:
        pass

    state = State()
    state.id = 0

    def Callback(state, dir, entries):
        for a in entries:
            if a == "COPYRIGHT":
                state.id += 1
                CopyFile(os.path.join(dir, a), os.path.join(license, "COPYRIGHT-CALTECH-" + str(state.id)))

    os.path.walk(os.path.join(Root, "caltech-parser"), Callback, state)

def GetStage():
    global STAGE
    STAGE = ConvertPathForPython(getenv("STAGE"))

    if (not STAGE):
        #tempfile.tempdir = os.path.join(tempfile.gettempdir(), "cm3", "make-dist")
        #CreateDirectory(tempfile.tempdir)
        STAGE = tempfile.mkdtemp()
        SetEnvironmentVariable("STAGE", STAGE)
    return STAGE

# The way this SHOULD work is we build the union of all desired,
# and then pick and chose from the output into the .zip/.tar.bz2.
# For now though, we only build min.

def FormInstallRoot(PackageSetName):
    return os.path.join(GetStage(), "cm3-" + PackageSetName + "-" + Config + "-" + CM3VERSION)

def MakeMSIWithWix(input):
# input is a directory such as c:\stage1\cm3-min-NT386-d5.8.1
# The output goes to input + ".msi" and other temporary files go similarly (.wix, .wixobj)M
    import uuid
    
    InstallLicense(Root, input)

    wix = open(input + ".wxs", "w")
    wix.write("""<?xml version='1.0' encoding='windows-1252'?>
<Wix xmlns='http://schemas.microsoft.com/wix/2006/wi'>
    <Product Name='Modula-3' Id='%s' Language='1033' Codepage='1252' Version='1.0.0' Manufacturer='.'>
        <Package Id='*' Keywords='.' Description="." Comments='.' Manufacturer='.' InstallerVersion='100' Languages='1033' Compressed='yes' SummaryCodepage='1252'/>
        <Media Id='1' Cabinet='Sample.cab' EmbedCab='yes'/>
        <Directory Id='TARGETDIR' Name='SourceDir'>
            <Directory Id='INSTALLDIR' Name='cm3'>""" % (str(uuid.uuid4()).upper()))

    class State:
        pass

    state = State()
    state.dirID = 0
    state.fileID = 0
    state.componentID = 0

    def HandleDir(state, dir):
        for a in os.listdir(dir):
            b = os.path.join(dir, a)
            if isdir(b):
                wix.write("""<Directory Id='d%d' Name='%s'>\n""" % (state.dirID, ConvertPathForWin32(a)))
                state.dirID += 1
                HandleDir(state, b) # recursion!
                wix.write("</Directory>\n")
            else:
                wix.write("""<Component Id='c%s' Guid='%s'>\n""" % (str(state.componentID), str(uuid.uuid4())))
                state.componentID += 1
                if state.componentID == 1:
                    wix.write("""<Environment Id="envPath" Action="set" Name="PATH" Part="last" Permanent="no" Separator=";" Value='[INSTALLDIR]bin'/>\n""")

                wix.write("""<File Id='f%d' Name='%s' Source='%s'/>\n""" % (state.fileID, a, ConvertPathForWin32(b)))
                state.fileID += 1
                wix.write("</Component>\n")

    HandleDir(state, input)

    wix.write("</Directory>\n")
    wix.write("</Directory>\n")

    wix.write("<Feature Id='Complete' Title='Modula-3' Description='everything' Display='expand' Level='1' ConfigurableDirectory='INSTALLDIR'>\n")

    for a in range(0, state.componentID):
        wix.write("<ComponentRef Id='c%d'/>\n" % a)

    # WixUI_Advanced
    # WixUI_Mondo
    # WixUI_InstallDir
    # WixUI_FeatureTree
    # are all good, but we need the package sets for some of them to make more sense

    wix.write("""
        </Feature>
        <Property Id="WIXUI_INSTALLDIR" Value="INSTALLDIR"/>
        <UIRef Id="WixUI_InstallDir" />
        <UIRef Id="WixUI_ErrorProgressText" />
    </Product>
</Wix>
""")

    wix.close()

    print("SearchPath candle light")

    if not SearchPath("candle") or not SearchPath("light"):
        for a in GetProgramFiles():
            b = os.path.join(ConvertPathForPython(a), "Windows Installer XML v3", "bin")
            if isdir(b):
                SetEnvironmentVariable("PATH", b + os.pathsep + os.environ["PATH"])
                break

    command = "candle " + ConvertPathForWin32(input) + ".wxs -out " + ConvertPathForWin32(input) + ".wixobj" + " 2>&1"
    if os.name == "posix":
        command = command.replace("\\", "\\\\")
    print(command)
    os.system(command)
    DeleteFile(input + ".msi")

    # This is similar to the toplevel README in the source tree.
    licenseText = \
"""The Critical Mass Modula-3 Software Distribution may be freely distributed as
open source according to the various copyrights under which different parts of
the sources are placed. Please read the files found in the license directory."""

    license = input + "-license.rtf"
    open(license, "w").write(
"""{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0\\fnil\\fcharset0 Courier New;}}
{\\*\\generator Msftedit 5.41.15.1515;}\\viewkind4\\uc1\\pard\\lang1033\\f0\\fs20""" + licenseText.replace("\n", "\\par\n")
+ "}")

    command = "light -out " + ConvertPathForWin32(input) + ".msi " + ConvertPathForWin32(input) + ".wixobj -ext WixUIExtension -cultures:en-us -dWixUILicenseRtf=" + ConvertPathForWin32(license) + " 2>&1"
    if os.name == "posix":
        command = command.replace("\\", "\\\\")
    print(command)
    os.system(command)

#MakeMSIWithWix("C:\\stage1\\cm3-min-NT386-d5.8.1")
#sys.exit(1)

def DiscoverHardLinks(r):
#
# return a hash of inode to array of paths
#
    result = { }
    for root, dirs, files in os.walk(r):
        for f in files:
            p = root + "/" + f
            if not os.path.islink(p):
                result.setdefault(os.stat(p).st_ino, []).append(p)
    return result

def BreakHardLinks(links):
#
# take the output from DiscoverHardLinks and replace all but the first
# element in each array with a zero size file
#
    for inode in links:
        first = links[inode][0]
        for other in links[inode][1:]:
            print("breaking link " + other + " <=> " + first)
            os.remove(ConvertPathForPython(other))
            open(ConvertPathForPython(other), "w")

def RestoreHardLinks(links):
#
# take the output of DiscoverHardLinks and reestablish the links
#
    for inode in links:
        first = links[inode][0]
        for other in links[inode][1:]:
            print("restoring link " + other + " <=> " + first)
            os.remove(ConvertPathForPython(other))
            os.link(ConvertPathForPython(first), ConvertPathForPython(other))

def MoveSkel(prefix):
#
# Move the usual toplevel cm3 directories under another directory.
# for example:
#  /tmp/stage/cm3-min/bin
#  /tmp/stage/cm3-min/lib
# =>
#  /tmp/stage/cm3-min/usr/local/cm3/bin
#  /tmp/stage/cm3-min/usr/local/cm3/lib
#
# This is temporarily destructive, for the purposes of building Debian packages.
# It is reversed by RestoreSkel.
#
    CreateDirectory("." + prefix)
    for a in ["bin", "pkg", "lib", "www", "man", "etc"]:
        if isdir(a):
            print("mv " + a + " ." + prefix + "/" + a)
            os.rename(a, "." + prefix + "/" + a)

def RestoreSkel(prefix):
#
# Undo the work of MoveSkel;
#
    for a in ["bin", "pkg", "lib", "www", "man", "etc"]:
        if isdir("." + prefix + "/" + a):
            print("mv ." + prefix + "/" + a + " " + a)
            os.rename("." + prefix + "/" + a, a)

# Debian architecture strings:
# see http://www.debian.org/doc/debian-policy/footnotes.html#f73

DebianArchitecture = {
  "LINUXLIBC6" : "i386",
  "FreeBSD4" : "i386",
  "NetBSD2_i386" : "i386",
  "NT386" : "i386",
  "NT386GNU" : "i386",
  "NT386MINGNU" : "i386",
  "I386" : "i386",
  "IA64" : "ia64",
  "ALPHA" : "alpha",
  "AMD64" : "amd64",
  "HPPA" : "hppa",
  "PA32" : "hppa",
  "PA64" : "hppa",
  "MIPS" : "mips",
  "MIPS32" : "mips",
  "MIPS64" : "mips",
  "PPC" : "powerpc",
  "PPC32" : "powerpc",
  "PPC64" : "ppc",
  "SOLsun" : "sparc",
  "SOLgnu" : "sparc",
  "SPARC" : "sparc",
  "SPARC32" : "sparc",
  "SPARC64" : "sparc",
  }

def MakeDebianPackage(name, input, output, prefix):
#
# .deb file format:
# an ar archive containing (I think the order matters):
#   debian-binary:
#     text file that just says "2.0\n"
#   control.tar.gz:
#     metadata, minimum is control file
#   data.tar.gz or .bz2 or .lzma
#     payload
# User has no choice where the install goes.
#
    if SearchPath("lzma"):
        compresser = "lzma"
        compressed_extension = "lzma"
    elif isfile("/home/jkrell/bin/lzma"):
        compresser = "/home/jkrell/bin/lzma"
        compressed_extension = "lzma"
    else:
        compresser = "gzip"
        compressed_extension = "gz"
    # while testing, gzip is much faster
    # compresser = "gzip"
    # compressed_extension = "gz"
    print("cd " + input)
    os.chdir(input)
    CreateDirectory("./debian")
    MoveSkel(prefix)
    newline = "\012" # take no chances
    open("./debian-binary", "w").write("2.0" + newline)
    os.chdir("./debian")
    architecture = DebianArchitecture.get(Target) or DebianArchitecture.get(Target[:Target.index("_")])
    control = (
      "Package: cm3-" + Target + "-" + CM3VERSION + newline
    + "Version: 1.0" + newline
    + "Maintainer: somebody@somewhere.com" + newline
    + "Architecture: " + architecture + newline
    + "Description: good stuff" + newline)
    print("control:" + control)
    open("./control", "w").write(control)

    command = "tar cfz ../control.tar.gz ."    
    print(command)
    os.system(command)
    os.chdir(input)
    command = "tar cf data.tar ." + prefix
    if isfile("data.tar." + compressed_extension) or isfile("data.tar"):
        print("skipping " + command)
    else:
        print(command)
        os.system(command)
    command = compresser + " data.tar"
    if isfile("data.tar." + compressed_extension):
        print("skipping " + command)
    else:
        print(command)
        os.system(command)

    command = "ar cr " + input + ".deb debian-binary control.tar.gz data.tar." + compressed_extension
    print(command)
    os.system(command)
    RestoreSkel(prefix)

#-----------------------------------------------------------------------------

if __name__ == "__main__":

    #
    # run test code if module run directly
    #

    print("CM3VERSION is " + GetVersion("CM3VERSION"))
    print("CM3VERSIONNUM is " + GetVersion("CM3VERSIONNUM"))
    print("CM3LASTCHANGED is " + GetVersion("CM3LASTCHANGED"))
    #sys.stdout.flush()
    #os.system("set")
    sys.exit(1)

    CopyConfigForDevelopment()
    sys.exit(1)

    CheckForLinkSwitch("DELAYLOAD")
    sys.exit(1)

    for a in [
            "a", "a/b", "a\\b", "\\a",
            "\\a/b", "\\a\\b", "/a", "/a/b",
            "/a\\b", "/a\\", "/a/b\\", "/a\\b\\",
            "ac", "a/bc", "a\\bc", "\\ac",
            "\\a/bc", "\\a\\bc", "/ac", "/a/bc",
            "/a\\bc", "/ac\\", "/a/bc\\", "/a\\bc\\",
            "a", "ac/b", "ac\\b", "\\a",
            "\\ac/b", "\\ac\\b", "/a", "/ac/b",
            "/ac\\b", "/a\\", "/ac/b\\", "/ac\\b\\",
            ]:
        print("RemoveLastPathElement(%s):%s" % (a, RemoveLastPathElement(a)))
        print("GetLastPathElement(%s):%s" % (a, GetLastPathElement(a)))
    sys.exit(1)

    print(_ConvertFromCygwinPath("\\cygdrive/c/foo"))
    print(_ConvertFromCygwinPath("//foo"))
    sys.exit(1)

    print(SearchPath("juno"))
    sys.exit(1)

    print(_ConvertToCygwinPath("a"))
    print(_ConvertToCygwinPath("a\\b"))
    print(_ConvertToCygwinPath("//a\\b"))
    print(_ConvertToCygwinPath("c:\\b"))
    print(_ConvertToCygwinPath("c:/b"))
    print(_ConvertToCygwinPath("/b"))
    print(_ConvertToCygwinPath("\\b"))
    sys.exit(1)
    print(IsCygwinBinary("c:\\cygwin\\bin\\gcc.exe"))
    print(IsCygwinBinary("c:\\bin\\cdb.exe"))
    sys.exit(1)

    print("\n\ncore: " + str(OrderPackages(PackageSets["core"])))
    print("\n\nbase: " + str(OrderPackages(PackageSets["base"])))
    print("\n\nmin: " + str(OrderPackages(PackageSets["min"])))
    print("\n\nstd: " + str(OrderPackages(PackageSets["std"])))
    sys.exit(1)

    #print(listpkgs("libm3"))
    #print(listpkgs("m3-libs/libm3"))
    #print(listpkgs(Root + "/m3-libs/libm3"))

    PrintList2(["a"])
    print("PrintList2------------------------------")
    PrintList2(["a", "b"])
    print("PrintList2------------------------------")
    PrintList2(["a", "b", "c"])
    print("PrintList2------------------------------")
    PrintList2(["a", "b", "c", "d"])
    print("PrintList2------------------------------")
    PrintList2(["a", "b", "c", "d", "e"])
    print("PrintList2------------------------------")

    PrintList4(["a"])
    print("PrintList4------------------------------")
    PrintList4(["a", "b"])
    print("PrintList4------------------------------")
    PrintList4(["a", "b", "c"])
    print("PrintList4------------------------------")
    PrintList4(["a", "b", "c", "d"])
    print("PrintList4------------------------------")
    PrintList4(["a", "b", "c", "d", "e"])
    print("PrintList4------------------------------")

    CommandLines = [
        [],
        ["build"],
        ["buildlocal"],
        ["buildglobal"],
        ["buildship"],
        ["ship"],
        ["clean"],
        ["cleanlocal"],
        ["cleanglobal"],
        ["realclean"],
        ["-foo", "build"],
        #["unknown"],
        ["clean", "-bar"],
        ["-a", "-b", "-c"],

        #["m3core", "libm3"],
        ["build", "m3core", "libm3"],
        ["buildlocal", "m3core", "libm3"],
        ["buildglobal", "m3core", "libm3"],
        ["buildship", "m3core", "libm3"],
        ["ship", "m3core", "libm3"],
        ["clean", "m3core", "libm3"],
        ["cleanlocal", "m3core", "libm3"],
        ["cleanglobal", "m3core", "libm3"],
        ["realclean", "m3core", "libm3"],
        ["-foo", "build", "m3core", "libm3"],
        #["unknown", "m3core", "libm3"],
        ["clean", "-bar", "m3core", "libm3"],
        #["-a", "-b", "-c", "m3core", "libm3"],
        ]

    Functions = [
        map_action,
        add_action_opts,
        extract_options,
        get_args,
        ]

    Width = 0
    for CommandLine in CommandLines:
        Length = 0
        for Arg in CommandLine:
            Length += 4
            Length += len(Arg)
        if Length > Width:
            Width = Length

    for Function in Functions:
        for CommandLine in CommandLines:
            print("%s(%-*s): %s" % (Function.__name__, Width, CommandLine, Function(CommandLine)))

    pkgmap(["-c"])
