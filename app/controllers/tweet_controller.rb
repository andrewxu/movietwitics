
class TweetController < ApplicationController
  #include Api
  require 'api'
  #require 'tweet_stream_helper'  

  def index
    tweet_stream_helper = TweetstreamHelper.new
    @tweet_data = tweet_stream_helper.tweets_with_movie_tag
    @tweet_stuff = "Stuff is here to tweet"
  end
end
