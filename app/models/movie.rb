class Movie < ActiveRecord::Base
  attr_accessible :title, :release_date, :rating, :runtime, :synopsis, :sentiment, :poster_url, :poster_thumbnail, :user_score, :critic_score
end