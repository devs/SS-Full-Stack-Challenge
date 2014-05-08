class TweetRequestsController < ApplicationController
  def index
    @requests = TweetRequest.find(:all, :order => "id desc", :limit => 100)
  end
end
