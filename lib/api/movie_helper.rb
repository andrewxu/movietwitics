module Api
  class MovieHelper
    def initialize
      @bf = BadFruit.new('f2953uz7djtrqesuwtrjjwds')
    end

    def movieList
      return @bf.lists.in_theaters
    end
  end
end
