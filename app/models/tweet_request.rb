class TweetRequest < ActiveRecord::Base
    
  scope :recent, lambda { where('created_at > ?', Time.now - 5.minutes) }
  
  def self.dupe_request(request_type, parameter)
    self.where(:request_type => request_type, :parameter => parameter)
  end
 
  def tweets
    twitter = Twitter_api.new
    if self.request_type == "search"
      response = twitter.tweets_for_term(twitter.bearer_token, self.parameter)
      body = JSON.parse(response.body)
      Rails.cache.fetch("tweet_request/#{id}/tweets", :expires_in => 5.minutes) do
        body["statuses"]
      end
    elsif self.request_type == "user"
      response = twitter.tweets_for_user(twitter.bearer_token, self.parameter)
      body = JSON.parse(response.body)
      Rails.cache.fetch("tweet_request/#{id}/tweets", :expires_in => 5.minutes) do
        body
      end  
    end
  end
end
