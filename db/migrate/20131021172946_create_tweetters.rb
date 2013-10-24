class CreateTweetters < ActiveRecord::Migration
  def change
    create_table :tweetters do |t|
      t.string :text
      t.datetime :created
      t.string :location

      t.timestamps
    end
  end
end
