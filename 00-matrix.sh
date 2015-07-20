#!/bin/bash

export CWD=$PWD
export OUT_DIR="/gsfs1/rsgrps/bhurwitz/whwilder/uproc/out"
export DATA_DIR="/rsgrps/bhurwitz/bonnie/tara_bd/kegg/uproc_shortread_to_pfam/data/uproc-out/uproc_pfam"
export SCRIPT_DIR="$CWD/workers"

stations=""
for i in {1..110}; do 
   station=$(ls -d ${DATA_DIR}/Station${i}_* | head -n 1) 2> /dev/null
   if [[ -d $station ]]; then 
      base=$(basename $station)
      stations="$stations ${base%%_*}"
   fi
done
rm $OUT_DIR/Station*
for STATION in $stations;do
   export STATION=$STATION
   qsub -j oe -v OUT_DIR,CWD,STATION,DATA_DIR ${SCRIPT_DIR}/00-matrix_exec.sh
done
