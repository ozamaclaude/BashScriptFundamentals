#!/bin/bash

DEBUG_FLG=0
# 日付大小比較
# arg1:'yyyy/mm/dd hh:mm:ss'
# arg2:'yyyy/mm/dd hh:mm:ss'
function dateComp()
{
    # 1970/01/01 00:00:00 からの経過秒に変換
    ARG1_SECOND=`date -d "$1" '+%s'`
    ARG2_SECOND=`date -d "$2" '+%s'`

    # 差を返却
    expr $ARG1_SECOND - $ARG2_SECOND
}

function debug_print1()
{
    if [ $DEBUG_FLG = 1 ]; then
        echo "[`date '+%Y/%m/%d %T'`] $1"
		fi
}

