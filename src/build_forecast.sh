#! /usr/bin/env bash
#==========================================================================
#
# Description: Builds the UFS Weather Model and puts the executable in
#              ufs_weather_model/test.  This script is usually called
#              from ./build_all.sh.
#
# Note:  Only the CCPP build of the UFS MR Weather Model is supported.
#
# Usage: ./build_forecast.sh
#
#==========================================================================
set -eux

source ./machine-setup.sh > /dev/null 2>&1
cwd=`pwd`

USE_PREINST_LIBS=${USE_PREINST_LIBS:-"true"}
if [ $USE_PREINST_LIBS = true ]; then
  export MOD_PATH=/scratch3/NCEPDEV/nwprod/lib/modulefiles
else
  export MOD_PATH=${cwd}/lib/modulefiles
fi

# Check final exec folder exists
if [ ! -d "../exec" ]; then
  mkdir ../exec
fi

target=${target}.intel
CCPP=${CCPP:-"true"}

cd ufs_weather_model
FV3=$( pwd -P )/FV3
cd tests
 
if [ $CCPP  = true ] || [ $CCPP = TRUE ] ; then
  ./compile.sh "$FV3" "$target" "CCPP=Y STATIC=N 32BIT=Y REPRO=Y"
else
  echo "The non-CCPP build of the UFS MR Weather Model is not supported"
fi
