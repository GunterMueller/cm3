#!/bin/sh
# $Id$

if [ -n "$ROOT" -a -d "$ROOT" ] ; then
  sysinfo="$ROOT/scripts/sysinfo.sh"
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

FRONTEND="${INSTALLROOT}/bin/cm3"
BACKEND="${INSTALLROOT}/bin/cm3cg"
FRONTEND_SRC="${ROOT}/m3-sys/cm3/${CM3_TARGET}/cm3"
BACKEND_SRC="${ROOT}/m3-sys/m3cc/${CM3_TARGET}/cm3cg"
FRONTEND_CM3VERSION="${FRONTEND}-${CM3VERSION}"
BACKEND_CM3VERSION="${BACKEND}-${CM3VERSION}"

usage()
{
  echo ""
  echo "install-cm3-compiler.sh [ -n ] backup | newversion | upgrade"
  echo "install-cm3-compiler.sh [ -n ] restore <version_number>"
  echo ""
  echo "  backup"
  echo "    will make copies of cm3 front-end and back-end with the cm3"
  echo "    version number as suffix, e.g."
  echo "    ${FRONTEND} --> ${FRONTEND}-x.y.z"
  echo "    ${BACKEND} --> ${BACKEND}-x.y.z"
  echo ""
  echo "  restore <version_number>"
  echo "    will restore copies with suffixed version number as current"
  echo "    version, e.g."
  echo "    ${FRONTEND}-x.y.z --> ${FRONTEND}"
  echo "    ${BACKEND}-x.y.z --> ${BACKEND}"
  echo ""
  echo "  newversion"
  echo "    will install the version from the current workspace with"
  echo "    version number suffixes, e.g."
  echo "    ${FRONTEND_SRC} --> ${FRONTEND}-x.y.z"
  echo "    ${BACKEND_SRC} --> ${BACKEND}-x.y.z"
  echo ""
  echo "  upgrade"
  echo "    will backup the existing version, install new executables"
  echo "    with suffixes and restore them as the current version"
  echo ""
  echo "  Beware: This script relies on the cm3 executable to correctly"
  echo "  identify its version (cm3 -version). If it does not, things will"
  echo "  get messed up."
  echo ""
}

exit_if()
{
  if [ "${NOACTION}" = yes ] ; then
    echo "error ignored due to -n" 1>&2
  else
    exit "$1"
  fi
}

do_cp()
{
  echo cp "$1" "$2"
  if [ "${NOACTION}" != yes ] ; then
    if cp "$1" "$2"; then
      true
    else
      exit_if 1
    fi
  fi
}

cp_if()
{
  if [ ! -r "$1" ] ; then
    echo "cp_if: source does not exist: $1" 1>&2 
    exit_if 1
  fi
  if [ -r "$2" ] ; then
    # destination exists
    if cmp "$1" "$2"; then
      echo "cp_if: $1 and $2 identical" 1>&2
      true
    else
      if [ -w "$2" ] ; then
        do_cp "$1" "$2"
      else
        echo "cp_if: cannot write $2" 1>&2
        exit_if 1
      fi
    fi
  else
    do_cp "$1" "$2"
  fi
}

getversion()
{
  if [ -x "$1" ] ; then
    "$1" -version | grep version | awk '{print $5}'
  else
    echo "$1 is not executable" 1>&2
    exit 1
  fi
}

install_local_as_version()
{
  CM3VERSION=`getversion "${FRONTEND_SRC}"`
  FRONTEND_DEST="${FRONTEND_CM3VERSION}"
  BACKEND_DEST="${BACKEND_CM3VERSION}"
  cp_if "${FRONTEND_SRC}" "${FRONTEND_DEST}"
  if [ "${GCC_BACKEND}" = yes ] ; then
    cp_if "${BACKEND_SRC}" "${BACKEND_DEST}"
  fi
}

backup_old()
{
  OLDCM3VERSION=`getversion "${FRONTEND}"`
  cp_if "${FRONTEND}" "${FRONTEND}-${OLDCM3VERSION}"
  if [ "${GCC_BACKEND}" = yes ] ; then
    cp_if "${BACKEND}" "${BACKEND}-${OLDCM3VERSION}"
  fi
}

rm_curent()
{
  rm -f "${FRONTEND}"
  if [ "${GCC_BACKEND}" = yes ] ; then
    rm -f "${BACKEND}"
  fi
}

cp_version()
{
  cp_if "${FRONTEND_CM3VERSION}" "${FRONTEND}"
  if [ "${GCC_BACKEND}" = yes ] ; then
    cp_if "${BACKEND_CM3VERSION}" "${BACKEND}"
  fi
}

upgrade()
{
  backup_old
  install_local_as_version
  rm_curent
  cp_version
}

if [ "x${1}" = "x-n" ] ; then
  NOACTION=yes
  shift
fi

if [ "x${1}" = "xupgrade" ] ; then
  upgrade
elif [ "x${1}" = "xrestore" ] ; then
  if [ -z "$2" ] ; then
    echo "please specify a version" 1>&2 
    exit 1
  fi
  CM3VERSION="$2"
  FRONTEND_CM3VERSION="${FRONTEND}-${CM3VERSION}"
  BACKEND_CM3VERSION="${BACKEND}-${CM3VERSION}"
  cp_version
elif [ "x${1}" = "xnewversion" ] ; then
  install_local_as_version
elif [ "x${1}" = "xbackup" ] ; then
  backup_old
elif [ "x${1}" = "x" ] ; then
  usage
else
  echo "unknown command: $1" 1>&2
  exit 1
fi

exit 0
