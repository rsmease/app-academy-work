class CreatePostSubreddits < ActiveRecord::Migration[5.1]
  def change
    create_table :post_subreddits do |t|
      t.integer :post_id, null: false
      t.integer :subreddit_id, null: false
      t.timestamps
    end
    add_index :post_subreddits, :post_id
    add_index :post_subreddits, :subreddit_id
  end
end
