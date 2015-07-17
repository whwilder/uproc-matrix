#PBS -N matrix
#PBS -m bea
#PBS -M whwilder@email.arizona.edu
#PBS -W group_list=bhurwitz
#PBS -q windfall
#PBS -l select=1:ncpus=1:mem=45Gb
#PBS -l pvmem=45gb
#PBS -l cput=1:0:0
#PBS -l walltime=24:00:00

echo $STATION
cd $CWD
DIRS=$(ls -d ${DATA_DIR}/${STATION}_*)
echo $DIRS
#for DIR in $DIRS; do
#   FILES="$FILES $(ls $DIR)"
#done
FILES=$(find $DIRS -type f)
for FILE in $FILES; do
   egrep "^K.*$" $FILE | sort >> ${OUT_DIR}/$STATION
done
