module ApplicationHelper
  include Twitter::Extractor
  
  def insert_links(tweet)
    screen_names = extract_mentioned_screen_names(tweet)
    if screen_names != []
      screen_names.each do |s|
        link_to_user = "<a href='/user_tweets/" + s + "'>" + s + "</a>"
        tweet = tweet.gsub(s, link_to_user)
      end
      tweet
    else
      tweet
    end
  end
end

