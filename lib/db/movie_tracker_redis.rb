module Db
  class MovieTrackerRedis
    POSITIVE_RATING_CHAR="P"
    NEGATIVE_RATING_CHAR="N"
    def initialize(host = "localhost", port = 6379)
      require "redis"
      @redis = Redis.new(:host => host, :port => port)
    end

    def write_to_db(movie_title, is_positive)
      @redis.incr "#{movie_title}_#{db_sentiment(is_positive)}"
    end
    
    def movie_rating(movie_title)
      positive_reviews = @redis.get("#{movie_title}_#{POSITIVE_RATING_CHAR}")
      negative_reviews = @redis.get("#{movie_title}_#{NEGATIVE_RATING_CHAR}")
      if positive_reviews.nil? && negative_reviews.nil?
        return "Not yet rated"
      else
        return positive_reviews.to_i / (positive_reviews.to_i + negative_reviews.to_i)
      end
    end

    def db_sentiment(is_positive)
      if is_positive
        return POSITIVE_RATING_CHAR
      end
      return NEGATIVE_RATING_CHAR
    end
  end


end
