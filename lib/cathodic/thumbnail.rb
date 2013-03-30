module Cathodic
	#The Thumbnail class represents a twitch thumbnail, you can access any type of thumbnail representing a small preview of the stream any time
	#Author::Paul Forti
	#License::MIT
	#-small : the url to a small thumbnail 80x50
	#-medium : the url to a medium thumbnail 320x200
	#-large : the url to a large thumbnail 640x400
	#-template : the url to a generic thumbnail, you have to replace {width} by the width you want, same goes for {height}
	#-sized_thumb : nil if sized has not been called, otherwise it's the url to a custom sized thumbnail (the size is defined when calling sized)
	class Thumbnail
		attr_accessor :small, :medium, :large, :template, :sized_thumb

		#The constructor needs a hash representing the stream object
		#Must be fetched from the Twitch.tv API (or have the same structure)
		#-stream_hash : the hash representing the twitch.tv stream.
		def initialize(stream_hash)
			raise "Uncorrect stream hash" if !stream_hash.has_key?("preview")
			@preview = stream_hash.fetch("preview")
			extract_thumbnails
		end

		#Sized generates the url of a stream thumbnail that is width large and height tall
		#width : The thumbnail's desired width
		#height : The thumbnail's desired height
		def sized(width, height)
			@sized_thumb = @template
			@sized_thumb.sub! "{width}", width.to_s
			@sized_thumb.sub! "{height}", height.to_s
		end

		private

		#Extracts the url of the three different sizes of thumbnail, plus the url of a the template (to generate custom sized thumbnails)
		def extract_thumbnails
			@small = @preview["small"]
			@medium = @preview["medium"]
			@large = @preview["large"]
			@template = @preview["template"]
		end
	end
end