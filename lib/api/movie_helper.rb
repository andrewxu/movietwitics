module Api
  class MovieHelper
    def initialize
      @bf = BadFruit.new('f2953uz7djtrqesuwtrjjwds')

      require_relative '../db/movie_tracker_redis'
      @movie_db_obj = Db::MovieTrackerRedis.new
    end

    def movieList
      movies = @bf.lists.in_theaters
      list = []
      movies.each do |m|

        movie_data = {
          'id' => m.id,
          'name' => m.name,
          'year' => m.year,
          'thumbnail' => m.posters.thumbnail,
          'critic_score' => m.scores.critics_score,
          'user_score' => m.scores.audience_score,
          'sentiment' => @movie_db_obj.movie_rating(m.name) 
        }
        list <<  movie_data
      end

      return list
    end

    def get_movie_by_id identifier
      movie = @bf.movies.search_by_id identifier

      {
        'name' => movie.name,
        'year' => movie.year,
        'poster_detailed' => movie.posters.detailed,
        'release_date' => movie.release_dates['theater'],
        'rating' => movie.mpaa_rating,
        'runtime' => movie.runtime,
        'synopsis' => movie.synopsis,
        'sentiment' => @movie_db_obj.movie_rating(movie.name)
      }

    end
  end
end
