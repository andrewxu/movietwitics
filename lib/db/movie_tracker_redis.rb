module Db
  class MovieTrackerRedis
    POSITIVE_RATING_CHAR="P"
    NEGATIVE_RATING_CHAR="N"
    def initialize
      require "redis"
      @redis = Redis.new(:host => "localhost", :port => 6379)
    end
    def write_to_db(movie_title, sentiment)
      @redis.incr "#{movie_title}_#{sentiment}"
    end
    def movie_rating(movie_title)
      positive_reviews = @redis.get("#{movie_title}_#{self::POSITIVE_RATING_CHAR}")
      negative_reviews = @redis.get("#{movie_title}_#{self::NEGATIVE_RATING_CHAR}")
      if positive_reviews.nil? && negative_reviews.nil?
        return "Not yet rated"
      else
        return positive_reviews.to_i / (positive_reviews.to_i + negative_reviews.to_i)
      end
    end
  end
end
