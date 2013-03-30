module Cathodic
	#The chat class represents the twitch.tv chat, you can fetch the embed code or the pop out chat code and links 
	#Author::Paul Forti
	#License::MIT
	#-embed : the url to the embed version of the chat
	#-popout : the url used to pop out the chat
	#-emoticons : the hash containing all the serialized emoticons (image url, regexp, etc)
	#-popout_link : the html link used to pop out the chat
	class Chat
		attr_accessor :embed, :popout, :emoticons, :popout_link

		#The constructor needs to be given an account name, most likely the one retrieved from the stream's url 
		#-account_name : the account name of the stream's chat you want to get 
		def initialize(account_name)
			@account_name = account_name
			generate_links
		end

		#This method fetchs the emoticons info about a stream's chat. It takes a lot of CPU, memory and the query is pretty big
		#Don't use it unless you REALLY need the emoticons
		def fetch_emoticons
			query_point = "https://api.twitch.tv/kraken/chat/"+@account_name+"emoticons"
			@emoticons = open(query_point).read
		end

		private
		def generate_links
			@embed = "http://twitch.tv/chat/embed?channel="+@account_name
			@popout = @embed + "&popout_chat=true"
			@popout_link = "<a href=\""+@popout"\" target=\"_new\">Pop-Out</a>"
		end

	end
end