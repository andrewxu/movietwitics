
module Api
  class TweetHelper
    def insert_tweets(movie_title)
      @movie_title = movie_title
      self.movie_tweets["results"].each do |tweet|
        puts "Inspect following tweet: #{tweet["text"]}"
      end
    end
    def movie_tweets
      search_url = "#{self.base_url}#{@movie_title}%20movie&rpp=#{self.result_amount}&include_entities=true&result_type=recent"

      require 'curl'
      curl = CURL.new
      page = curl.get(search_url)

      require 'json'
      return JSON.load(page)
    end

    protected
    def base_url
      return "http://search.twitter.com/search.json?q="
    end
    def result_amount
      return 125
    end
  end
end


input_tweet = Api::TweetHelper.new
input_tweet.insert_tweets("Argo")
