#!/bin/bash

SAMPLE_FILENAME="sample.txt"
ARG_NUMBER=$#
# 起動スクリプトの格納先
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# 日付
CURRENT_DATE=`date +%Y%m%d_%H-%M-%S`
CURRENT_DATE_COMP=`date +"%Y%m%d %H:%M:%S"`

TEMP_FILEPATH=$SCRIPT_DIR/$SAMPLE_FILENAME
CURL_OUTPUTFILE=$SCRIPT_DIR/"CURL_OUTPUT"

# Initialze
cd $SCRIPT_DIR
source ./utils1.sh

debug_print1 $ARG_NUMBER
debug_print1 $CURRENT_DATE
debug_print1 $SCRIPT_DIR
debug_print1 $TEMP_FILEPATH
# 自身のプロセスID
debug_print1 $$
#ps aux | egrep "$$|PID"

if [ -e $TEMP_FILEPATH ]; then
  debug_print1 "found"
else
  debug_print1 "not found"
fi

# コマンドライン引数の数チェック
if [ $# -ne 1 ]; then
  debug_print1 "Argument Number is not 1."
else
	debug_print1 "Argument Number is 1."
fi

# SED
cat $TEMP_FILEPATH | sed -e 's/XXX/ABC/g' > $SCRIPT_DIR/$CURRENT_DATE".txt"

# curl
curl https://stocks.finance.yahoo.co.jp/stocks/detail/?code=4719.T -o $CURL_OUTPUTFILE &> /dev/null
STOCK_PRICE=`cat $CURL_OUTPUTFILE | grep stock_price`

#debug_print1 $STOCK_PRICE
#echo $STOCK_PRICE | awk '{print $2}'

echo $STOCK_PRICE | awk '        
    {
        num = substr( $2, index( $2, "&" ), 17)
        print num
    }
'

#echo $STOCK_PRICE
# 何日前のタイムスタンプか？
SAMPLE_TIMESTAMP=`date  "+%Y%m%d %H:%M:%S" -r $SCRIPT_DIR/$SAMPLE_FILENAME`
echo $SAMPLE_TIMESTAMP
echo $CURRENT_DATE_COMP

difference=`dateComp $SAMPLE_TIMESTAMP $CURRENT_DATE_COMP`
echo $difference
