require 'api/tweet_stream_helper'
require 'db/movie_tracker_redis'

namespace :movie do

  desc "Stream tweets for a given movie and store and calculate a sentiment rating"
  task :record, :title do |t, args|
    stream_helper = Api::TweetStremHelper.new
    stream_helper.start_twitter_stream_listener args.title
  end

  desc "Fetches a sentiment rating from redis given a movie title"
  task :rating, :title do |t, args|
    movie_tracker = Db::MovieTrackerRedis.new
    p movie_tracker.movie_rating args.title
  end
end