#!/bin/bash

SAMPLE_FILENAME="sample.txt"
ARG_NUMBER=$#
# 日付
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# 起動スクリプトの格納先
CURRENT_DATE=`date +%Y%m%d_%H-%M-%S`

TEMP_FILEPATH=$SCRIPT_DIR/$SAMPLE_FILENAME

echo $ARG_NUMBER
echo $CURRENT_DATE
echo $SCRIPT_DIR
echo $TEMP_FILEPATH

if [ -e $TEMP_FILEPATH ]; then
  echo "found"
else
  echo "not found"
fi

# SED
cat $TEMP_FILEPATH | sed -e 's/XXX/ABC/g' > $SCRIPT_DIR/$CURRENT_DATE".txt"

