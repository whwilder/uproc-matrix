#!/bin/bash

export CWD=$PWD
export OUT_DIR="/gsfs1/rsgrps/bhurwitz/whwilder/uproc/out"
export DATA_DIR="/rsgrps/bhurwitz/bonnie/tara_bd/kegg/uproc_shortread_to_pfam/data/uproc-out/uproc_kegg"

for i in {1..110}; do 
   station=$(ls -d ${DATA_DIR}/Station${i}_* | head -n 1)
   if [[ -d $station ]]; then 
   base=$(basename $station)
   echo ${base%%_*} >> $OUT_DIR/stations
   fi
done

for STATION in $(cat ${OUT_DIR}/stations); do
   export STATION=$STATION
   qsub -j oe -v OUT_DIR,CWD,STATION,DATA_DIR 00-matrix_exec.sh
done
