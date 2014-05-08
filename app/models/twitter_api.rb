require 'base64'
require 'httparty'
require 'uri'

class Twitter_api
  attr_accessor :bearer_token
  
  include HTTParty
  base_uri  'https://api.twitter.com'
  format    :json
  
  def initialize
    c_key = "JS1UdlQ0iRNHAmgvJcautARil"
    c_secret = "DPpVFVwysbv0FBteq6SnYhKmjtWAsxLSGuU9Xd0jMxDCPE5hwg"
    c_key_secret = "#{c_key}:#{c_secret}"
    encoded_c_key_secret = Base64.strict_encode64(c_key_secret)
    
    headers = {
      'Authorization' => "Basic #{encoded_c_key_secret}", 
      'Content-Type'  => "application/x-www-form-urlencoded;charset=UTF-8"
    }
    
    body = 'grant_type=client_credentials'
 
    # Request bearer token
    request = Twitter_api.post('/oauth2/token', :body => body, :headers => headers)
  
    if request.code == 200
      self.bearer_token = request['access_token']
    else
      puts "[ERROR] Unable to authenticate with Twitter"
    end
  end
  
  def tweets_for_term(bearer_token, term)
    query = term.gsub(" ","+")
    
    headers = {
      'Authorization' => "Bearer #{bearer_token}", 
    }
    
    tweets = Twitter_api.get("/1.1/search/tweets.json?q=#{query}&count=20", :headers => headers)
  end
  
  def tweets_for_user(bearer_token, user)
    headers = {
      'Authorization' => "Bearer #{bearer_token}", 
    }
    
    tweets = Twitter_api.get("/1.1/statuses/user_timeline.json?screen_name=#{user}&count=20", :headers => headers)
  end
end