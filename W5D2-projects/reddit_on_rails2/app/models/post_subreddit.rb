class PostSubreddit < ApplicationRecord
  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post,
    inverse_of: :post_subreddits

  belongs_to :subreddit,
    primary_key: :id,
    foreign_key: :subreddit_id,
    class_name: :Subreddit,
    inverse_of: :post_subreddits
end
