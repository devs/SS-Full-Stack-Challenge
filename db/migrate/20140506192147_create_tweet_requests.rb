class CreateTweetRequests < ActiveRecord::Migration
  def change
    create_table :tweet_requests do |t|
      t.string :request_type
      t.string :parameter

      t.timestamps
    end
  end
end
