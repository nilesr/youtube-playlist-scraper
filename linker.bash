#!/usr/bin/env bash
while read line; do
	idx=$(echo "$line"|awk '{print $1}')
	playlist=$(echo "$line"|awk '{print $2}')
	id=$(echo "$line"|awk '{print $3}')
	test "$id" = "" && continue
	mkdir "$playlist" 2>/dev/null && echo Created directory "$playlist"
	currentfilename=$(find . -name '*'"$id"'*' -maxdepth 1)
	if test "$currentfilename" = ""; then
	   	youtube-dl -x -f bestaudio --audio-format best --audio-quality 9 --postprocessor-args '-strict -2' -w -C -i "http://youtube.com/watch?v=$id"
		currentfilename=$(find . -name '*'"$id"'*' -maxdepth 1)
	fi
	if test "$currentfilename" = ""; then
		echo "$(date) - The $idx""th song of $playlist appears to have failed to download. ID $id" | tee -a fail.log
		continue
	fi
	newfilename="$idx. "$(echo "$currentfilename"|awk '{print substr($0, 3)}')
	ln -s "$PWD/$currentfilename" "$playlist"/"$newfilename"
done
