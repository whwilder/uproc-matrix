#!/bin/bash

export CWD=$PWD
export OUT_DIR="/gsfs1/rsgrps/bhurwitz/whwilder/uproc/out"
export DATA_DIR="/rsgrps/bhurwitz/bonnie/tara_bd/kegg/uproc_shortread_to_pfam/data/uproc-out/uproc_kegg"
export SCRIPT_DIR="$CWD/workers"

qsub -j oe -v SCRIPT_DIR,OUT_DIR,CWD,DATA_DIR ${SCRIPT_DIR}/01-gen-matrix_exec.sh
