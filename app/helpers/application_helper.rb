module ApplicationHelper
  include Twitter::Extractor
  
  def insert_links(tweet)
    screen_names = extract_mentioned_screen_names(tweet)
    if screen_names != []
      new_tweet = ""
      screen_names.each do |s|
        link_to_user = "<a href='/user_tweets/" + s + "'>" + s + "</a>"
        new_tweet = tweet.sub(s, link_to_user)
      end
      new_tweet
    else
      tweet
    end
  end
end

