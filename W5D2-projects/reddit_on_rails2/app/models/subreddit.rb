class Subreddit < ApplicationRecord
  validates :title, :description, null: false
  validates :description, length: { minimum: 20 }

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

  has_many :post_subreddits, inverse_of: :subreddit, dependent: :destroy
  has_many :posts, through: :post_subreddits, source: :post

end
