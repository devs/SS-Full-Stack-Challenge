class PagesController < ApplicationController
  def home
    if signed_in?    
      @default_search = "iubb"
      
      if TweetRequest.dupe_request("search", @default_search).recent.any?
        @request = TweetRequest.dupe_request("search", @default_search).recent.first
      else
        @request = TweetRequest.new(:request_type => "search", :parameter => @default_search)
        @request.save
      end
      
      @tweets = @request.tweets
      
      render 'home'
    else
      render 'visitor_home'
    end
  end
  
  def user_tweets
    @screen_name = params["screen_name"]
    
    if TweetRequest.dupe_request("user", @screen_name).recent.any?
      @request = TweetRequest.dupe_request("user", @screen_name).recent.first
    else
      @request = TweetRequest.new(:request_type => "user", :parameter => @screen_name)
      @request.save
    end
    
    @tweets = @request.tweets
  end
  
  def search
    @search_term = params["parameter"]
    
    if TweetRequest.dupe_request("user", @screen_name).recent.any?
      @request = TweetRequest.dupe_request("user", @screen_name).recent.first
    else
      @request = TweetRequest.new(:request_type => "search", :parameter => @search_term)
      @request.save
    end
  
    @tweets = @request.tweets
  end
end
