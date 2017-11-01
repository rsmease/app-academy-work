class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password
  after_initialize :ensure_session_token!

  has_many :subreddits,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Subreddit

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post

  def ensure_session_token!
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(pass)
    @pass = pass
    self.password_digest = BCrypt::Password.create(@pass)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

  def self.find_by_credentials(user, pass)
    user = User.find_by(username: user)
    return nil if user.nil?
    user.is_password?(pass) ? user : nil
  end
end
