#!/bin/bash

ThisScript="$0"
InDir="$1"
OutDir="$2"
TempFile=$(mktemp)
Process=0
Width=0
Height=0
Scratch="$@"

# get_book_covers indir outdir -w WIDTH -h HEIGHT


if [[ "$@" =~ "-w" ]]; then
	Process=1
	Width=$(echo "$Scratch" | awk -F "-w " '{print $2}' | awk '{print $1}') 
fi

if [[ "$@" =~ "-h" ]]; then
	Process=1
	Height=$(echo "$Scratch" | awk -F "-h " '{print $2}'| awk '{print $1}')
fi

#Sanity check

if [ "$Process" == "1" ]; then
	if [ "$Width" == "0" ] || [ "$Height" == "0" ];then
		echo "$Process | $Width | $Height"
		echo "You must give both width and height to perform resizing. Use -w NUMBER -h NUMBER."
		echo "Common pairs for mobile devices are:  480x320,600x800,960x640,800x480,1280x800,1920x1080"
		exit 1
	fi
fi



if [ "$1" == "" ];then
	InDir="$PWD"
else
	if [ -d "$1" ]; then
		InDir="$1"
	else
		InDir="$PWD"
	fi
fi
if [ "$2" == "" ];then
	OutDir="$PWD"
else
	if [ -d "$2" ]; then
		OutDir="$2"
	else
		OutDir="$PWD"
	fi
fi


find -H "$InDir" -type f  -name "cover.jpg" -exec echo '{}' ';' | sed "/^\./s#/#$InDir/#" > $TempFile

while read -r line
	do 
	D2=$(dirname "$line")
	bookname=$(basename "$D2" | awk -F " \\\(" '{print $1}' )
	dir1="${line%/*}"
	DIRNAME2="${dir1%/*}"
	authorname=$(basename "$DIRNAME2")	
	echo "Processing $bookname by $authorname"
	filename=$(printf "%s/%s_%s.jpg" "$OutDir" "$authorname" "$bookname")
	if [ "$Process" == "1" ];then
	   convert "$line" -resize "$Width"x"$Height"! "$filename"
	else
		cp "$line" "$filename"
	fi
	done < $TempFile
rm $TempFile
