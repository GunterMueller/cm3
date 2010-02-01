#!/bin/sh

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
. "$ROOT/scripts/pkginfo.sh"
. "$ROOT/scripts/pkgcmds.sh"

if [ ! -r "$1" ] ; then
  echo "need file list pathname argument" 1>&2
  exit 1
fi

DATESTR=`date +"%Y-%m-%d"`
STAGE="${STAGE:-${TMPDIR}}"
[ -d "${STAGE}" ] || mkdir "${STAGE}" || mkdir -p "${STAGE}" || exit 1
ARCHIVE="${STAGE}/src-update-${DATESTR}.tgz"
header "building CM3 src-update distribution in ${ARCHIVE}"
echo "using files listed in $1"

#-----------------------------------------------------------------------------
# build the scripts distribution archive
#

cp "$1" "${ROOT}/.tar-include"
cd "${ROOT}" || exit 1
/bin/ls -1d m3overrides COPYRIGHT-CMASS COPYRIGHT-DEC >> .tar-include

echo "archiving..."
export GZIP="-9 -v"
${TAR} -czf ${ARCHIVE} --files-from .tar-include --exclude-from .tar-exclude \
 || exit 1
ls -l ${ARCHIVE}
echo "done"
exit 0
