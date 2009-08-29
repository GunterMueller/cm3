#!/bin/sh
# $Id: make-src-dist-sys.sh,v 1.12.2.4 2009-08-29 05:57:30 jkrell Exp $

if [ -n "$ROOT" -a -d "$ROOT" ] ; then
  sysinfo="$ROOT/scripts/sysinfo.sh"
  root="${ROOT}"; export root
else
  root=`pwd`
  while [ -n "$root" -a ! -f "$root/scripts/sysinfo.sh" ] ; do
    root=`dirname $root`
  done
  sysinfo="$root/scripts/sysinfo.sh"
  if [ ! -f "$sysinfo" ] ; then
    echo "scripts/sysinfo.sh not found" 1>&2
    exit 1
  fi
  export root
fi
. "$sysinfo"
# if a datestamp is set for the build of snapshots, include this, too
if [ -n "$DS" ]; then
  CM3VERSION="${CM3VERSION}-${DS}"
fi
#. "$ROOT/scripts/pkginfo.sh"
#. "$ROOT/scripts/pkgcmds.sh"

STAGE="${STAGE:-${TMPDIR}}"
[ -d "${STAGE}" ] || mkdir "${STAGE}" || mkdir -p "${STAGE}" || exit 1
ARCHIVE="${STAGE}/cm3-src-sys-${CM3VERSION}.tgz"
header "building CM3 source distribution in ${ARCHIVE}"

#-----------------------------------------------------------------------------
# build the source distribution archive
#

cd "${ROOT}" || exit 1

/bin/ls -1d COPYRIGHT-CMASS COPYRIGHT-DEC scripts m3-sys/cm3 > .tar-include
/bin/ls -1d m3-sys/libdump m3-sys/m3back m3-sys/m3cgcat  >> .tar-include
/bin/ls -1d m3-sys/m3cggen m3-sys/m3front m3-sys/m3linker >> .tar-include
/bin/ls -1d m3-sys/m3loader m3-sys/m3middle m3-sys/m3objfile >> .tar-include
/bin/ls -1d m3-sys/m3quake m3-sys/m3scanner m3-sys/scripts >> .tar-include
/bin/ls -1d m3-sys/m3staloneback m3-sys/m3tools m3-sys/mklib >> .tar-include
/bin/ls -1d m3-libs/m3core m3-libs/libm3 m3-libs/sysutils >> .tar-include
/bin/ls -1d m3overrides m3-tools/m3bundle >> .tar-include
/bin/ls -1d m3-*/*/${TARGET} > .tar-exclude
/bin/ls -1d m3-*/*/${TARGET}p >> .tar-exclude
echo "building exclude list..."
$FIND . \( -name '*~' -or -name '*.bak' -or -name '*.orig' -or \
          -name '*.rej'  -or -name 'cvs-nq-up' -or -name '*-diffs' -or \
          -name 'PkgDep' -or -name 'PkgKind' -or -name '.bok' -or \
          -name '*.o' -or -name '*.a' -or -name '*.dll' -or -name '*.obj' -or \
          -name '.errors' -or -name '*.io' -or -name '*.mo' -or \
          -name '*.so' -or -name '*.so.[0-9]*' -or -name '.M3WEB' -or \
          -name '.M3SHIP' -or -name '.M3IMPTAB' -or -name '.M3EXPORTS' -or \
          \( -name 'CVS' -a -type d \) \) -print | \
  sed -e 's;^./;;' >> .tar-exclude

echo "archiving..."
export GZIP="-9 -v"
${TAR} -czf ${ARCHIVE} --files-from .tar-include --exclude-from .tar-exclude \
 || exit 1
ls -l ${ARCHIVE}
if [ -n "${DOSHIP}" ]; then
  if test "x${CM3CVSUSER}" != "x"; then
    CM3CVSUSER_AT="${CM3CVSUSER}@"
  else
    CM3CVSUSER_AT=""
  fi
  WWWSERVER=${WWWSERVER:-${CM3CVSUSER_AT}birch.elegosoft.com}
  WWWDEST=${WWWDEST:-${WWWSERVER}:/var/www/modula3.elegosoft.com/cm3/snaps}
  scp "${ARCHIVE}" "${WWWDEST}" < /dev/null
fi
echo "done"
exit 0

