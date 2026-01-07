#!/usr/bin/env bash
errors=0
while read line; do
	idx=$(echo "$line"|cut -d , -f 1)
	playlist=$(echo "$line"|cut -d , -f 2)
	id=$(echo "$line"|cut -d , -f 3)
	name=$(echo "$line"|cut -d , -f 4)
	test "$id" = "" && continue
	mkdir "$name" 2>/dev/null && echo Created directory "$name"
	currentfilename=$(find . -name '*'"$id"'*' -maxdepth 1)
	echo "Linking $id"
	if test "$currentfilename" = ""; then
		echo "Downloading $id"
		#youtube-dl -w -i "http://youtube.com/watch?v=$id"
		youtube-dl --verbose --add-metadata -x -f bestaudio --audio-format best --audio-quality 0 --postprocessor-args '-strict -2' -w -i "http://youtube.com/watch?v=$id"
		currentfilename=$(find . -name '*'"$id"'*' -maxdepth 1)
	fi
	if test "$currentfilename" = ""; then
		echo "$(date) - The $idx""th song of $playlist ($name) appears to have failed to download. ID $id" | tee -a fail.log
		errors=$(($errors+1))
		continue
	fi
	newfilename="$idx. "$(echo "$currentfilename"|awk '{print substr($0, 3)}')
	ln -s "$PWD/$currentfilename" "$name"/"$newfilename"
done
echo There were $errors errors
