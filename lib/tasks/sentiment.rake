require 'tools/sentiment-analyser/analyser'
require 'redis'

namespace :sentiment do

  desc "Seed the sentiment analyser with initial data"
  task :seed do

    analyser = Analyser.new
    analyser.train_positive
    analyser.train_negative

    p "Seeding complete"
  end

  desc "Test task to run analyser on a sentence"
  task :analyse, :sentence do |t, args|
    analyser = Analyser.new

    analyser.analyse(args.sentence).to_json
  end
  
end