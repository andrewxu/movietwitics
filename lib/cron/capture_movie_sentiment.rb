
module Api

  class CaptureMovieSentiment
    def initialize
      require_relative "../api/movie_helper"
      @movies = ["Hobbit"]
      @movie_helper = Api::MovieHelper.new
      #@movies = @movie_helper.movieList
    end
    
    def start_stream_analyser
      require_relative "../api/tweet_stream_helper"
      @movies.each do |movie|
        twitter_stream_capture = Api::TweetStremHelper.new
        twitter_stream_capture.start_twitter_stream_listener(movie)
      end
    end
    
  end

end


movie_stream_reader = Api::CaptureMovieSentiment.new
#movie_stream_reader.start_stream_analyser
