#!/usr/bin/env bash
function __setpaths() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    DIR="$(dirname $(perl -e 'use Cwd "abs_path";print abs_path(shift)' "${BASH_SOURCE[0]}"))"
  else
    DIR="$(dirname $(readlink -f "${BASH_SOURCE[0]}"))"
  fi

  # $TOOLS = /foss/tools
  export OPENROAD=$TOOLS/openroad-latest
  echo "OpenROAD: ${OPENROAD}"

  export OPENROAD_EXE=$TOOLS/openroad-latest/bin/openroad
  echo "OpenROAD EXE: ${OPENROAD_EXE}"

  export OPENSTA_EXE=$TOOLS/openroad-latest/bin/sta
  echo "OpenSTA EXE: ${OPENSTA_EXE}"

  export YOSYS_EXE=$TOOLS/yosys/bin/yosys
  echo "Yosys EXE : ${YOSYS_EXE}"

  export KLAYOUT_DIR=$TOOLS/klayout
  echo "KLayout DIR: ${KLAYOUT_DIR}"

  if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/Applications/KLayout/klayout.app/Contents/MacOS:$PATH"
    export PATH="$(brew --prefix bison)/bin:$(brew --prefix flex)/bin:$(brew --prefix tcl-tk)/bin:$PATH"
  fi

  export FLOW_HOME=$DIR/flow
}
__setpaths
unset -f __setpaths
