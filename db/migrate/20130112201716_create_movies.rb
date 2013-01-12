class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :release_date
      t.string :rating
      t.integer :runtime
      t.text :synopsis
      t.integer :sentiment
      t.string :poster_url
      t.string :poster_thumbnail
      t.integer :critic_score
      t.integer :user_score

      t.timestamps
    end
  end
end