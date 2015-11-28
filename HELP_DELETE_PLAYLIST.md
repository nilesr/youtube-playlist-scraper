# Deleting a playlist
There isn't an official way to do this, but if you want to delete a playlist's songs, cd into the directory of the playlist and paste this (assuming bash)

`for f in *; do rm ../"$(echo $f|awk '{print substr($0, 6)}')"; done`
