require 'twitter/json_stream'
module Api
  # Start helper to create listener for twitter feed
  # Example:
  # twitter_stream_capture = Api::TweetStremHelper.new
  # twitter_stream_capture.start_twitter_stream_listener("Skyfall")

  class TweetStremHelper
    def start_twitter_stream_listener(movie_title)
      @movie_title = movie_title
      EventMachine::run {
        movie_title = movie_title + "\#"
        stream = Twitter::JSONStream.connect(
          :path    => '/1/statuses/filter.json',
          :auth    => 'themovietwitics:$pickles99',
          :method  => 'POST',
          :content => "track=#{@movie_title}"
        )

        stream.each_item do |item|
          require 'json'
          tweet = JSON.load(item)
          puts "Analyze and write to db: #{tweet["text"]}\n\n"
          require_relative '../tools/sentiment-analyser/analyser'
          analyser = Analyser.new
          #puts analyser.analyse(tweet["text"]).to_json
          puts analyser.analyse("Skyfall was amazing").to_json
          puts "\n\n\n"
        end

        stream.on_error do |message|
          $stdout.print "error: #{message}\n"
          $stdout.flush
          #email admin
        end

        stream.on_reconnect do |timeout, retries|
          $stdout.print "reconnecting in: #{timeout} seconds\n"
          $stdout.flush
        end

        stream.on_max_reconnects do |timeout, retries|
          $stdout.print "Failed after #{retries} failed reconnects\n"
          $stdout.flush
        end

        trap('TERM') {  
          stream.stop
          EventMachine.stop if EventMachine.reactor_running? 
        }
      }
      puts "The event loop has ended"
    end
  end
end
