This is a tool to download and manage your music on the go using youtube
playlists. An example use of this program would be if you (like I) listen to all
of your music online, and have to go on a long road trip. 

Every time you change the order of songs in a playlist, remove a song or add a
new song, just delete the playlist folders and repeat step 3. It will
automatically download new songs if necessary and re-link the songs in the
correct order.

## Requirements
- [youtube-dl](https://github.com/rg3/youtube-dl/#installation)
- ffmpeg (or avconv)
- [Youtube API key](http://console.developers.google.com)
- Nokogiri (`gem install nokogiri`)

## Usage
1. Put your api key in videos.rb
2. Put your playlist IDs in videos.rb. Those can be found in the URLs of the
   playlists.
3. `ruby videos.rb | ./linker.bash`

