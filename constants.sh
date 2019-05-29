shopt -s expand_aliases

ORIG=./raw-data/original
OUT=./raw-data/derived/2019-05-29
mkdir -p $ORIG $OUT

SCHEMA=${SCHEMA-tripods}
s=$SCHEMA # A shortened form sql-scripts

MINYEAR=${MINYEAR-2006}
MAXYEAR=${MAXYEAR-2015}
