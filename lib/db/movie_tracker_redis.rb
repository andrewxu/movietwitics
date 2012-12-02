module Db
  class MovieTrackerRedis
    def initialize(host = "localhost", port = 6379)
      require "redis"
      @redis = Redis.new(:host => host, :port => port)
    end

    def write_to_db(movie_title, sentiment)
      @redis.incr "#{movie_title}_#{sentiment}"
    end
    
    def movie_rating(movie_title)
      positive_reviews = @redis.get("#{movie_title}_P")
      negative_reviews = @redis.get("#{movie_title}_N")

      if positive_reviews.nil? && negative_reviews.nil?
        return "-" #not yet rated
      end

      positive_reviews.to_i.percent_of(positive_reviews.to_f + negative_reviews.to_f).round(0)
    end

  end
end

# Add a new method to Numeric class for converting to percent
class Numeric
  def percent_of(total)
    (self.to_f / total.to_f) * 100.0
  end
end
