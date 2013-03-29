Cathodic
================================

Cathodic was at first a module created for one of the websites I worked on. 
I needed a way to easily access the data tied to a twitch.tv stream, such as the state of the stream (online or offine, thus the boolean), the number of viewers, the stream's status, etc.

Cathodic is now a standalone gem, and it's pretty easy to use, as you can see below.

Using Cathodic
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