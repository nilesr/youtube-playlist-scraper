This is a tool to download and manage your music on the go using youtube
playlists. An example use of this program would be if you (like I) listen to all
of your music online, and have to go on a long road trip. 

This will either download all of the songs in the playlists at once or just
update their positions, but it will NOT download only new songs. Your best bet
is to just download the new song every time you add a new song to your playlists
and put it in this folder, then run step 4 again (without step 3)

## Requirements
- [youtube-dl](https://github.com/rg3/youtube-dl/#installation)
- ffmpeg (or avconv)
- Youtube API key.
- Nokogiri (`gem install nokogiri`)

## Usage
1. Put your api key in videos.rb
2. Put your playlist IDs in videos.rb. Those can be found in the URLs of the playlists.
3. `ruby videos.rb download`
4. `ruby videos.rb | ./linker.bash`

Step 3 will download every single song in the playlist to the current working
directory.  
Step 4 will create a directory for each of the playlists, and link the mp3 files
in the current directory into those directories with numbers indicating the
position in the playlist. The easiest way to load these is to use VLC's "Open
directory" option, which will load them in order because of the numbers.
