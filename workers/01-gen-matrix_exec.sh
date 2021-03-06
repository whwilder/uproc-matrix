#PBS -N gen-matrix
#PBS -m bea
#PBS -M whwilder@email.arizona.edu
#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=1:mem=40Gb
#PBS -l pvmem=40Gb
#PBS -l cput=2:0:0
#PBS -l walltime=2:00:00

cd $OUT_DIR
echo $DIRS
FILES=$(ls Station*)
#for DIR in $DIRS; do
#   FILES="$FILES $(ls $DIR)"
#done
ruby ${SCRIPT_DIR}/matrix.rb $FILES > sample-matrix_pfam
