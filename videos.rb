require 'json'
require 'net/http'
require 'uri'
require 'nokogiri'
api_key = "CHANGEME"
playlists = Array.new [
	"PLIKcw9O7i0KR4Q-pC-7MLb_DoRmzYOCUw",
	"PLIKcw9O7i0KQO4aHOqypivLefSFKq2vp1",
	"PLIKcw9O7i0KSeW6AmMmg3D4etDs5YeX8q",
	"PLIKcw9O7i0KRZ43r5UVGNraUgvyPaUMBU",
	"PLIKcw9O7i0KTkhLF_MECKCA8DFWQIsGq7",

	"PLIKcw9O7i0KTazhuqDrC9TECUlyGiwzuq", # Stadium jams
	"PLIKcw9O7i0KS7RamPVROlspO6PU_Wq_VT", # Weeb music

	#"LLtgQiU872oPzG0qCEqMQExA" # Jared
]
playlists.each do |playlist|
	videos = Array.new
	parsed = JSON.parse(Net::HTTP.get(URI.parse("https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails&playlistId=" + playlist + "&maxResults=50&key=" + api_key)))
	videos << parsed["items"]
	while parsed.include? "nextPageToken" do
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
end
