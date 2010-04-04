#! /usr/bin/env python

import sys
import pylib
from pylib import *

cleangcc = not ("nocleangcc" in sys.argv)
clean = not ("noclean" in sys.argv)
argv_RealClean = [sys.argv[0], "realclean"] + sys.argv[1:]
argv_BuildShip = [sys.argv[0], "buildship"] + sys.argv[1:]

def _CleanupEnvironment():
    # pylib.py figures these out correctly and in particular
    # their forms have to change if we upgrade from NT386
    # to NT386GNU or vice versa; reloading pylib.py
    # handles that
    for a in ["M3CONFIG", "CM3_INSTALL", "CM3_ROOT"]:
        if os.environ.get(a):
            del(os.environ[a])

SetupEnvironment()
CopyConfigForDevelopment() or sys.exit(1)

#
# clean everything
#

if clean:
    DoPackage(
        argv_RealClean, [ "import-libs", "m3bundle", "m3middle", "m3quake", "m3objfile",
                          "m3linker", "m3back", "m3front", "sysutils",
                          "cm3", "mklib", "m3cc", "m3core", "libm3",
        ]) or sys.exit(1)
if cleangcc:
    DoPackage(argv_RealClean, [ "m3cc" ]) or sys.exit(1)

#
# Now build the compiler with the installed version of the runtime;
# do _not_ compile m3core and libm3 here.
# We start with the front end...
#
DoPackage(argv_BuildShip, [ "import-libs", "m3bundle", "m3middle", "m3quake", "m3objfile",
                            "m3linker", "m3back", "m3front", "sysutils",
                            "cm3", "mklib",
    ]) or sys.exit(1)

#
# ... and continue with the backend, if needed
#
FilterPackages([ "m3cc" ]) and DoPackage(argv_BuildShip, [ "m3cc" ])

#
# Up to now, the compiler binaries have not been installed.
# We do this now but keep backups of the old ones. (not yet)
#
ShipFront() or sys.exit(1)

#
# Now try the new compiler but building the core system (without
# m3cc, as this is written in C) from scratch with it.
#
os.environ["OMIT_GCC"] = "yes"
_CleanupEnvironment();
reload(pylib) # compiler host type may have changed and need to recompute stuff
CopyConfigForDevelopment() or sys.exit(1)

# once more

DoPackage(argv_RealClean, [ "import-libs", "m3bundle", "m3middle", "m3quake", "m3objfile",
                            "m3linker", "m3back", "m3front", "sysutils",
                            "cm3", "mklib", "m3core", "libm3"
    ]) or sys.exit(1)

DoPackage(argv_BuildShip, [ "import-libs", "m3bundle", "m3middle", "m3quake", "m3objfile",
                            "m3linker", "m3back", "m3front", "sysutils",
                            "cm3", "mklib", "m3core", "libm3"
    ]) or sys.exit(1)

ShipFront() or sys.exit(1)

print("%s: Success." % os.path.basename(sys.argv[0]))
