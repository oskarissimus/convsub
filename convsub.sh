#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"
subtitles_filename=$1
encoding_part=`chardetect3 "$subtitles_filename" | grep -o Windows`
subtitles_filename_base=`echo $subtitles_filename | rev | cut -f2- -d. | rev`
subtitles_filename_ext=`echo $subtitles_filename | rev | cut -f1 -d. | rev`

if [[ $encoding_part == "Windows" ]]
    then
    echo -e "${RED}windows encoding detected${NOCOLOR}, converting to UTF-8"
    iconv "$subtitles_filename" \
          --output="$subtitles_filename_base.utf8.$subtitles_filename_ext" \
          --from-code=CP1250 \
          --to-code=UTF8
    else
    echo -e "${GREEN}non-windows encoding${NOCOLOR}, keeping it that way"
fi
