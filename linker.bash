#!/usr/bin/env bash
while read line; do
	idx=$(echo "$line"|awk '{print $1}')
	playlist=$(echo "$line"|awk '{print $2}')
	id=$(echo "$line"|awk '{print $3}')
	test "$id" = "" && continue
	mkdir "$playlist" 2>/dev/null
	currentfilename=$(find . -name '*'"$id"'*')
	newfilename="$idx. "$(echo "$currentfilename"|awk '{print substr($0, 3)}')
	ln -s "$PWD/$currentfilename" "$playlist"/"$newfilename"
done
