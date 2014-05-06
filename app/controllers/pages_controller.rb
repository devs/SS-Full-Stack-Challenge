class PagesController < ApplicationController
  def home
    if signed_in?
      render 'home'
    else
      render 'visitor_home'
    end
  end
end
