module Cathodic
	class Thumbnail
		attr_accessor :small, :medium, :large, :template, :sized_thumb

		#The constructor needs a hash representing the stream object
		def initialize(stream_hash)
			raise "Uncorrect stream hash" if !stream_hash.has_key?("preview")
			@preview = stream_hash.fetch("preview")
			extract_thumbnails
		end

		def sized(width, height)
			@sized_thumb = @template
			@sized_thumb.sub! "{width}", width.to_s
			@sized_thumb.sub! "{height}", height.to_s
		end

		private
		def extract_thumbnails
			@small = @preview["small"]
			@medium = @preview["medium"]
			@large = @preview["large"]
			@template = @preview["template"]
		end
	end
end