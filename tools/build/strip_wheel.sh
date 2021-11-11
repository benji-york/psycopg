#!/bin/bash

# Strip symbols inplace from the libraries in a zip archive.
#
# Stripping symbols is beneficial (reduction of 30% of the final package, >
# %90% of the installed libraries. However just running `auditwheel repair
# --strip` breaks some of the libraries included from the system, which fail at
# import with errors such as "ELF load command address/offset not properly
# aligned".
#
# System libraries are already pretty stripped. Ours go around 24Mb -> 1.5Mb...
#
# This script is designed to run on a wheel archive before auditwheel.

set -euo pipefail
set -x

wheel=$(realpath "$1")
shift

tmpdir=$(mktemp -d)
trap "rm -r ${tmpdir}" EXIT

cd "${tmpdir}"
python -m zipfile -e "${wheel}" .

find . -name *.so -ls -exec strip "$@" {} \;
# Display the size after strip
find . -name *.so -ls

python -m zipfile -c ${wheel} *

cd -
