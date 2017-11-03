class Post < ApplicationRecord
  validates :title, presence: true

  has_many :post_subreddits,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :PostSubreddit,
    inverse_of: :post,
    dependent: :destroy

  has_many :subreddits, through: :post_subreddits, source: :subreddit

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

end
