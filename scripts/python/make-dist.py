#! /usr/bin/env python

import sys
import os.path
import os
import shutil
import pylib
from pylib import *

def contains(s, t):
    return s.find(t) != -1

target      = Target.lower()
currentVC   = ["80", "90"]
nativeNT    = contains(target, "nt386") or target.endswith("_nt")
currentNT   = nativeNT and (GetVisualCPlusPlusVersion() in currentVC)
oldNT       = nativeNT and not currentNT
preferZip   = contains(target, "nt386") or target.endswith("_nt")
supportsMSI = nativeNT or contains(target, "interix") or contains(target, "cygwin") or contains(target, "mingw") or contains(target, "uwin")

def Echo(a):
    print("")
    print("=============================================================================")
    print(a)
    print("=============================================================================")
    print("")

def Run(a):

    print(a + " in " + os.getcwd())
    #return True
    return (os.system(a) == 0)

    # @call :IncrementLogCounter
    # @echo.
    # setlocal
    # remove some extraneous spaces that come
    # concating possibly empty variables with
    # spaces between them
    # set x=%*
    # set x=%x:  = %
    # set x=%x:  = %
    # echo %TIME%>>%STAGE%\logs\%LogCounter%_%~n1.log
    # echo.>> %STAGE%\logs\all.log
    # echo.>> %STAGE%\logs\%LogCounter%_%~n1.log
    # echo %x% >> %STAGE%\logs\%LogCounter%_%~n1.log
    # echo %x% ^>^> %STAGE%\logs\%LogCounter%_%~n1.log
    # call %x% >> %STAGE%\logs\%LogCounter%_%~n1.log or (
    #     echo %TIME%>>%STAGE%\logs\%LogCounter%_%~n1.log
    #     type %STAGE%\logs\%LogCounter%_%~n1.log >> %STAGE%\logs\all.log
    #     echo ERROR: %x% failed
    #     exit /b 1
    # )
    # echo %TIME%>>%STAGE%\logs\%LogCounter%_%~n1.log
    # type %STAGE%\logs\%LogCounter%_%~n1.log >> %STAGE%\logs\all.log
    # endlocal
    # goto :eof

def MakeArchive(PackageSetName, Command, Extension):

    InstallRoot = FormInstallRoot(PackageSetName)
    SymbolsRoot = FormInstallRoot(PackageSetName) + "-symbols"
    
    InstallLicense(Root, InstallRoot)

    #
    # move .pdb files into the symbols directory
    # TBD: use strip and --add-gnu-debuglink
    #
    def Callback(Arg, Directory, Names):
        if GetLastPathElement(Directory).endswith("-symbols"):
            return
        for Name in Names:
            if GetPathExtension(Name).lower() == "pdb":
                DeleteFile(os.path.join(SymbolsRoot, Name))
                MoveFile(os.path.join(Directory, Name), SymbolsRoot)

    CreateDirectory(SymbolsRoot)
    os.path.walk(InstallRoot, Callback, None)

    os.chdir(os.path.dirname(InstallRoot))

    if not os.listdir(SymbolsRoot):
        os.rmdir(SymbolsRoot)
    else:
        Symbols = FormInstallRoot(PackageSetName) + "-symbols." + Extension
        DeleteFile(Symbols)
        Run(Command + " " + os.path.basename(Symbols) + " " + os.path.basename(SymbolsRoot))

    Archive = FormInstallRoot(PackageSetName) + "." + Extension
    DeleteFile(Archive)
    Run(Command + " " + os.path.basename(Archive) + " " + os.path.basename(InstallRoot))

    #
    # Building a self extracting .exe is very easy but not present for now.
    # It is available in history if desired.
    # I think it'd be more valuable if it was a gui. tbd?
    #

def Zip(PackageSetName):
    MakeArchive(PackageSetName, "zip -9 -r -D -X", "zip")

def TarGzip(PackageSetName):
    MakeArchive(PackageSetName, "tar cfvz", "tar.gz")

def TarBzip2(PackageSetName):
    MakeArchive(PackageSetName, "tar cfvj", "tar.bz2")

def MakeArchives():
    for PackageSetName in PackageSets:
        if preferZip:
            Zip(PackageSetName)
        else:
            TarGzip(PackageSetName)

def BuildShip(Packages):
    # This is more indirect than necessary.
    CreateSkel()
    return Do("buildship", Packages)

def RealClean(Packages):
    # This is more indirect than necessary.
    return Do("realclean", Packages)

def CreateSkel():
    for a in ("bin", "pkg"):
        CreateDirectory(os.path.join(InstallRoot, a)) or FatalError()
    return True

def Do(Command, Packages):
    # This is more indirect than necessary.
    return DoPackage(["", Command], Packages)

def FatalError():
    # logs don't work yet
    #print("ERROR: see " + Logs)
    print("fatal error")
    sys.exit(1)

# doesn't work yet
#Logs = os.path.join(GetStage(), "logs")
#os.makedirs(Logs)

#LogCounter = 1

InstallRoot_CompilerWithPrevious = os.path.join(GetStage(), "prev")
InstallRoot_CompilerWithSelf = os.path.join(GetStage(), "self")
PackageSets = {"min" : FormInstallRoot("min"), "all" : FormInstallRoot("all")}
if oldNT:
    del(PackageSets["all"])

OriginalLIB = os.getenv("LIB")
if OriginalLIB:
    OriginalLIB = (os.path.pathsep + OriginalLIB)

OriginalPATH = os.getenv("PATH")
if OriginalPATH:
    OriginalPATH = (os.path.pathsep + OriginalPATH)

# ------------------------------------------------------------------------------------------------------------------------
Echo("build new compiler with old compiler and old runtime (%(InstallRoot)s to %(InstallRoot_CompilerWithPrevious)s)" % vars())
# ------------------------------------------------------------------------------------------------------------------------

# build just compiler this pass, not the runtime
# That is, assuming we have m3core and libm3, build the rest of the compiler.

Packages = [ "import-libs",
             "sysutils",
             "m3middle",
             "m3linker",
             "m3front",
             "m3quake",
             "m3objfile",
             "m3back",
             "m3cc",
             "cm3",
             "mklib" ]

def CopyRecursive(From, To):
    CopyCommand = "xcopy /fiverdh "
    ToParent = os.path.dirname(To)
    if (os.name != "nt"):
        CopyCommand = "cp --preserve  --recursive "
    print("mkdir " + ToParent)
    print(CopyCommand + From + " " + To)
    if os.path.isdir(To):
        shutil.rmtree(To)
    else:
        CreateDirectory(ToParent)
    shutil.copytree(From, To, symlinks=True)
    return True

#
# copy over runtime package store from old to new
# It would be nice to make this optionally incremental.
#
RuntimeToCopy = ["libm3", "m3core"]
for a in RuntimeToCopy:
    CopyRecursive(
        os.path.join(InstallRoot, "pkg", a),
        os.path.join(InstallRoot_CompilerWithPrevious, "pkg", a)) or FatalError()

NewLib = os.path.join(InstallRoot_CompilerWithPrevious, "lib")
CreateDirectory(NewLib)

if Config != "NT386":
    for a in glob.glob(os.path.join(InstallRoot, "lib", "libm3gcdefs.*")):
        CopyFile(a, NewLib) or FatalError()

for a in glob.glob(os.path.join(InstallRoot, "lib", "*.obj")):
    CopyFile(a, NewLib) or FatalError()

#
# cm3 is run out of %path%, but mklib is not, so we have to copy it.
#
CopyMklib(InstallRoot, InstallRoot_CompilerWithPrevious) or FatalError()

def Setup(ExistingCompilerRoot, NewRoot):
    global InstallRoot
    InstallRoot = NewRoot
    os.environ["CM3_INSTALL"] = NewRoot
    if OriginalLIB: # This is Windows-only thing.
        os.environ["LIB"] = os.path.join(NewRoot, "lib") + OriginalLIB
    os.environ["PATH"] = (os.path.join(NewRoot, "bin") + OriginalPATH)

    CopyCompiler(ExistingCompilerRoot, NewRoot) or FatalError()

    if NewRoot == InstallRoot_CompilerWithPrevious:
        NewLib = os.path.join(NewRoot, "lib")
        CreateDirectory(NewLib)
        for a in glob.glob(os.path.join(ExistingCompilerRoot, "lib", "*.obj")):
            CopyFile(a, NewLib) or FatalError()

    CopyConfigForDistribution(NewRoot) or sys.exit(1)

    reload(pylib) or FatalError()

    os.environ["CM3_INSTALL"] = ConvertToCygwinPath(NewRoot)

Setup(InstallRoot, InstallRoot_CompilerWithPrevious)
RealClean(Packages) or FatalError()
os.environ["CM3_NO_SYMBOLS"] = "1"
BuildShip(Packages) or FatalError()
del(os.environ["CM3_NO_SYMBOLS"])
ShipCompiler() or FatalError()
if "m3cc" in Packages:
    Packages.remove("m3cc")
RealClean(Packages) or FatalError()

# ----------------------------------------------------------------------------------------------------------------------------------
Echo("build new compiler and new runtime with new compiler (%(InstallRoot_CompilerWithPrevious)s to %(InstallRoot_CompilerWithSelf)s)" % vars())
# ----------------------------------------------------------------------------------------------------------------------------------

#
# This time build the entire compiler from m3core and on up, and the
# occasional build tools m3bundle, mklib, but don't bother building cm3cg again.
#

Packages += ["m3core", "libm3", "m3bundle", "mklib" ]
if "m3cc" in Packages:
    Packages.remove("m3cc")
Setup(InstallRoot_CompilerWithPrevious, InstallRoot_CompilerWithSelf)
RealClean(Packages) or FatalError()
BuildShip(Packages) or FatalError()
ShipCompiler() or FatalError()

AllPackages = pylib.GetPackageSets()["all"]
if "m3cc" in AllPackages:
    AllPackages.remove("m3cc")
RealClean(AllPackages) or FatalError()

# ----------------------------------------------------------------------------------------------------------------------------------

for p in PackageSets.keys():
    Echo("build " + p + " packages with new compiler")
    Setup(InstallRoot_CompilerWithSelf, PackageSets[p])
    Packages = pylib.GetPackageSets()[p]
    if "m3cc" in Packages:
        Packages.remove("m3cc")
    BuildShip(Packages) or FatalError()

# ----------------------------------------------------------------------------------------------------------------------------------

MakeArchives()

if contains(target, "linux"):
    for name in PackageSets:
        MakeDebianPackage(name, FormInstallRoot(name), GetStage() + "/cm3-" + name + ".deb", "/usr/local/cm3")

if supportsMSI and not oldNT:
    for name in PackageSets:
        MakeMSIWithWix(FormInstallRoot(name))

for a in glob.glob(os.path.join(GetStage(), "*")):
    if (a and os.path.isfile(a)):
        print("Output is " + a)
print("Much intermediate state remains in " + GetStage())
print("%s: Success." % os.path.basename(sys.argv[0]))
sys.exit(0)
