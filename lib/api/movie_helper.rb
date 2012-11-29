module Api
  class MovieHelper
    def initialize
      @bf = BadFruit.new('f2953uz7djtrqesuwtrjjwds')
    end

    def movieList
      movies = @bf.lists.in_theaters
      list = []
      movies.each do |m|
        movie_data = {
          'name' => m.name,
          'year' => m.year,
          'thumbnail' => m.posters.thumbnail,
          'critic_score' => m.scores.critics_score,
          'user_score' => m.scores.audience_score
        }
        list <<  movie_data
      end

      return list
    end
  end
end
