Cathodic
================================
[![Dependency Status](https://gemnasium.com/kustom666/cathodic.png)](https://gemnasium.com/kustom666/cathodic)  [![Build Status](https://travis-ci.org/kustom666/cathodic.png?branch=master)](https://travis-ci.org/kustom666/cathodic)

Cathodic was at first a module created for one of the websites I worked on. 
I needed a way to easily access the data tied to a twitch.tv stream, such as the state of the stream (online or offine, thus the boolean), the number of viewers, the stream's status, etc.

Cathodic is now a standalone gem, and it's pretty easy to use, as you can see below.

Installing Cathodic
-----------------------------

If you're working on a ruby project, you just have to run the following command : 
```ruby
	gem install cathodic
```

However, if you're using rails, you might want to use bundler (if you don't, you should, it's awesome), therefore add the following line to your Gemfile
```ruby
	gem cathodic
```

And run the following command : 
```console
	bundle install
```

To install the gem, and correctly add it to your rails project.

Using Cathodic
------------------------------

Cathodic is a very easy to use gem. Once you've installed it, you only need to instanciate a TwitchData object (contained in the Cathodic module) by calling the following constructor :
```ruby
	Cathodic::TwitchData.new(url)
```
Where url is the url of the twitch.tv channel (http://twitch.tv/kustomgames/ for example). This url can be provided by one of your users, or fetched from the twitch.tv api.

The data tied to the stream can now be accessed by using the accessors : if you want to retreive the number of viewers on the stream and put it on the console output you just have to call the viewers accessor : 
```ruby
	data = Cathodic::TwitchData.new(url)
	puts data.viewers
```
Here are all the data you can access at the moment : 

* online : boolean - True if the stream is online, false otherwise
* account_name : string - Contains the account name from the provided url
* thumbnail_address : string - Contains the url of the stream's preview thumbnail (will soon change to a new thumbnail object)
* embed : string - Contains the html embed code for the twitch tv player which will play the stream's livestream
* viewers : integer - Contains the number of people currently watching the stream (when the TwitchData object was created!)
* entry_point : string - Contains the entry point to the api (for future upgrades of the gem, to support multiple providers)
* url : string - Contains the url to the twitch.tv stream page
* game : string - Contains the game currently played on the stream (updated by the streamer, might not be accurate)
* status : string - Contains the status of the stream, a title displayed on top of the embed which describes the current activity on screen (updated by the streamer, might not be accurate)
* logo : string - Contains the url of the stream's logo
* banner : string - Contains the url of the stream's banner
* stream_name : string - The casse sensitive stream name (example : account_name is kustomgames and stream_name is KustomGames)
* chat_embed : string - Conatains the html code used to pop out the stream's chat (incoming)



