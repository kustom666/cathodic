#Cathodic takes the url of a twitch.tv stream and fetch every data tied to it, such as the status, logo, numbed of viewers, thumnails and game
#Author::Paul Forti
#License::MIT

require "cathodic/version"
require 'json'
require 'open-uri'
require 'openssl'
require "cathodic/thumbnail"
require "cathodic/chat"

module Cathodic
  class TwitchData
  	attr_accessor :account_name, :online, :thumbnail, :embed, :viewers, :entry_point, :url, :game, :status, :logo, :banner, :stream_name, :chat, :embed_width, :embed_height

  	def initialize(url, embed_width = 640, embed_height = 360)
  		@entry_point = "https://api.twitch.tv/kraken"
  		@url = url
  		extract_account
  		@query_point = @entry_point + "/streams/" + @account_name
      @embed_width = embed_width
      @embed_height = embed_height
  		extract_data
  	end

    def refresh_data
      answer_string = open(@query_point).read
      parsed_answer = JSON.parse(answer_string)

      if parsed_answer["stream"] == nil
        @online = false
      else
        @online = true

        @game = stream["game"]
        @viewers = stream["viewers"]
        @status = channel["status"]
      end
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

  			@embed =  "<object bgcolor='#000000' data='//www-cdn.jtvnw.net/swflibs/TwitchPlayer.swf' height='#{@embed_height}' id='clip_embed_player_flash' type='application/x-shockwave-flash' width='#{@embed_width}'><param name='movie' value='//www-cdn.jtvnw.net/swflibs/TwitchPlayer.swf' /><param name='allowScriptAccess' value='always' /><param name='allowNetworking' value='all' /><param name='allowFullScreen' value='true' /><param name='flashvars' value='channel=#{@channel}&start_volume=25&auto_play=true' /></object>"
  		  @chat_embed = Cathodic::Chat.new(@account_name)
      end
  	end
  end
end
