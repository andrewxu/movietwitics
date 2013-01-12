require 'api/tweet_stream_helper'

namespace :twitter do
  desc "Start tweet stream listeners for each movie in the db"
  task :import_sentiment => :environment do

    current_movies = Movie.all
    current_movies.each do |movie|
        twitter_stream_capture = Api::TweetStremHelper.new
        twitter_stream_capture.start_twitter_stream_listener(movie.title)
    end
  end
end
