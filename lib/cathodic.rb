require "cathodic/version"
require 'json'
require 'open-uri'
require 'openssl'
require "cathodic/thumbnail"

module Cathodic
  class TwitchData
  	attr_accessor :account_name, :online, :thumbnail, :embed, :viewers, :entry_point, :url, :game, :status, :logo, :banner, :stream_name, :chat_embed

  	def initialize(url)
  		@entry_point = "https://api.twitch.tv/kraken"
  		@url = url
  		extract_account
  		@query_point = @entry_point + "/streams/" + @account_name
  		extract_data
  	end

  	private
  	def extract_account
  		raise "Bad url" if !@url.include? "twitch.tv"

  		regexp = /twitch.tv\/\w*/
	    m = regexp.match @url
	    buff = m.to_s
	    buff.sub! "twitch.tv/", ""
	    @account_name = buff
  	end

  	def extract_data
  		answer_string = open(@query_point).read
  		parsed_answer = JSON.parse(answer_string)

  		if parsed_answer["stream"] == nil
  			@online = false
  		else
  			@online = true
  			stream = parsed_answer.fetch("stream")
  			channel = stream.fetch("channel")
  			
  			@thumbnail = Cathodic::Thumbnail.new(stream)
  			@game = stream["game"]
  			@viewers = stream["viewers"]

  			@url = channel["url"]
  			@status = channel["status"]
  			@logo = channel["logo"]
  			@banner = channel["banner"]
  			@stream_name = channel["display_name"]

  			@embed =  "<object type=\"application/x-shockwave-flash\" height=\"360\" width=\"640\" id=\"live_embed_player_flash\" data=\"http://en.twitch.tv/widgets/live_embed_player.swf?channel="+@account_name+"\" bgcolor=\"#000000\"><param name=\"allowFullScreen\" value=\"true\" /><param name=\"allowScriptAccess\" value=\"always\" /><param name=\"allowNetworking\" value=\"all\" /><param name=\"movie\" value=\"http://en.twitch.tv/widgets/live_embed_player.swf\" /><param name=\"flashvars\" value=\"hostname=en.twitch.tv&channel="+@account_name+"&auto_play=true&start_volume=25\" /></object>"
  		  @chat_embed = "http://twitch.tv/chat/embed?channel="+@account_name+"&popout_chat=true"
      end
  	end
  end
end
