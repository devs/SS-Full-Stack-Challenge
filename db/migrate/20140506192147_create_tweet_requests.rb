class CreateTweetRequests < ActiveRecord::Migration
  def change
    create_table :tweet_requests do |t|

      t.timestamps
    end
  end
end
