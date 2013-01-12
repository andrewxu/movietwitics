class IndexController < ApplicationController
  require 'api/movie_helper'

  def initialize
    @movie_helper = Api::MovieHelper.new
    super
  end

  def index
    @box_office_movies = @movie_helper.get_movie_list
  end

  def movie
    @movie = Movie.find_by_id params[:id]
  end
end
