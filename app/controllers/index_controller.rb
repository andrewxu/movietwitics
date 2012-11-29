class IndexController < ApplicationController
  require 'api/movie_helper'

  def initialize
    @movie_helper = Api::MovieHelper.new
    super
  end

  def index
    @box_office_movies = @movie_helper.movieList
  end

  def movie
    @movie = @movie_helper.get_movie_by_id params[:id]
  end
end
