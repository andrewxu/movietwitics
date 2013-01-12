module Api
  class MovieHelper
    def initialize
      @bf = BadFruit.new('f2953uz7djtrqesuwtrjjwds')

      require_relative '../db/movie_tracker_redis'
      @movie_db_obj = Db::MovieTrackerRedis.new
    end

    def get_movie_list
      movies = @bf.lists.in_theaters
      movie_list = []

      movies.each do |m|

        unless movie = Movie.find_by_title(m.name)
          movie = Movie.new
          movie.title = m.name
          movie.release_date = m.release_dates['theater']
          movie.rating = m.mpaa_rating
          movie.runtime = m.runtime
          movie.synopsis = m.synopsis
          movie.poster_url = m.posters.detailed
          movie.poster_thumbnail = m.posters.thumbnail
          movie.critic_score = m.scores.critics_score
          movie.user_score = m.scores.audience_score

          movie.save
        end

        movie_list << movie
      end

      return movie_list
    end
  end
end
