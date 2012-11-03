require 'tools/sentiment-analyser/analyser'

namespace :sentiment do

  desc "Seed the sentiment analyser with initial data"
  task :seed do
    analyser = Analyser.new
    analyser.train_positive 'tools/sentiment-analyser/data/positive'
    analyser.train_negative 'tools/sentiment-analyser/data/positive'

    p "Seeding complete"
  end
  
end