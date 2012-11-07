module Db
  class MovieTrackerRedis
    def write_to_db(movie_title, sentiment)
      require "redis"
      redis = Redis.new(:host => "localhost", :port => 6379)
      #redis.set("stuff_more", 1)
      redis.incr "#{movie_title}_#{sentiment}"
    end
  end
end
