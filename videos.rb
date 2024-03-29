require 'json'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'resolv-replace'
api_key = "CHANGEME"
playlists = Array.new [
	"PLIKcw9O7i0KQqbqKdGuYPzGPEDFs6xDvC", # Playlist -2
	"PLIKcw9O7i0KQaxX8HMGECXVq1-ZCsER-B", # Playlist -1
	"PLIKcw9O7i0KR4Q-pC-7MLb_DoRmzYOCUw", # Playlist 0
	"PLIKcw9O7i0KRZ43r5UVGNraUgvyPaUMBU", # Playlist 1
	"PLIKcw9O7i0KQO4aHOqypivLefSFKq2vp1", # Playlist 2
	"PLIKcw9O7i0KSeW6AmMmg3D4etDs5YeX8q", # Playlist 3
	"PLIKcw9O7i0KTkhLF_MECKCA8DFWQIsGq7", # Playlist 4
	"PLIKcw9O7i0KRlyVVSJZQEt2H-TqU-e_Tf", # Playlist 5
	"PLIKcw9O7i0KS7Ec5_XtTj1yqn7ZCHXUHJ", # Playlist 6
	"PLIKcw9O7i0KQK4AHiQy3cx_7FMIG7aBru", # Playlist 7

	#"PLIKcw9O7i0KTazhuqDrC9TECUlyGiwzuq", # Stadium jams
	#"PLIKcw9O7i0KQE5Yy9McX-FrypzSPO4CpS", # edgy boi 2019 mix
]
playlists.each do |playlist|
	STDERR.puts "Downloading " + playlist
	videos = Array.new
	parsed = JSON.parse(Net::HTTP.get(URI.parse("https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails&playlistId=" + playlist + "&maxResults=50&key=" + api_key)))
	videos << parsed["items"]
	page = 1
	while parsed.include? "nextPageToken" do
		page += 1
		STDERR.puts "Downloading " + playlist + " - Page " + page.to_s
		parsed = JSON.parse(Net::HTTP.get(URI.parse("https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails&playlistId=" + playlist + "&maxResults=50&key=" + api_key + "&pageToken=" + parsed["nextPageToken"])))
		videos << parsed["items"]
	end
	# Videos has now been populated with a lists of lists of the videos in the playlist. Playlist is equal to the playlist ID. Now we just need the index in the playlist
	index = 0
	videos.each do |video_list|
		video_list.each do |video_dict|
			index += 1
			puts index.to_s.rjust(3,"0") + " " + playlist + " " + video_dict["contentDetails"]["videoId"]
		end
	end
	STDERR.puts "Downloaded  " + playlist
end
