class TweetRequest < ActiveRecord::Base
  
  attr_accessor :tweets
  
  after_initialize :request
  
  scope :recent, lambda { where('created_at > ?', Time.now - 5.minutes) }
  
  def self.dupe_request(request_type, parameter)
    self.where(:request_type => request_type, :parameter => parameter)
  end
  
  def request
    twitter = Twitter.new
    response = twitter.tweets_for_term(twitter.bearer_token, self.parameter)
    body = JSON.parse(response.body)
    self.tweets = Rails.cache.fetch "tweets", :expires_in => 5.minutes do
      tweets = body["statuses"]
    end
  end
end
