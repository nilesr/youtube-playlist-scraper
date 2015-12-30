This is a tool to download and manage your music on the go using youtube
playlists. An example use of this program would be if you (like I) listen to all
of your music online, and have to go on a long road trip. 

Every time you change the order of songs in a playlist, remove a song or add a
new song, just delete the playlist folders and repeat step 3. It will
automatically download new songs if necessary and re-link the songs in the
correct order.

It will not delete songs that are removed from playlists.

Another great feature is that if you download a video before it gets deleted or made private, so long as you don't remove it from the playlist through youtube, it will continue linking the already-downloaded mp3 to the correct position. [example](https://i.imgur.com/wrvLGDR.png)

Yet another feature is that if you think someone may delete their account or make a playlist private, you can make a backup of it with `ruby videos.rb |grep PLAYLIST_ID > backup` so you can download the songs even if the playlist is deleted

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
4. If some videos are missing, check fail.log, it should have more info.

## If it stops working
Either youtube has changed their API, or has made it harder to download videos. The first thing you should try is running `sudo youtube-dl -U`. If that doesn't fix it, please open a github issue.
