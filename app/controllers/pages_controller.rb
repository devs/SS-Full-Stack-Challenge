class PagesController < ApplicationController
  def home
    if signed_in?    
      default_search = "iubb"
      
      if TweetRequest.dupe_request("search", default_search).recent.any?
        @request = TweetRequest.dupe_request("search", default_search).recent.first
      else
        @request = TweetRequest.new(:request_type => "search", :parameter => default_search)
        @request.save
      end
      
      @tweets = @request.tweets
      
      render 'home'
    else
      render 'visitor_home'
    end
  end
end
