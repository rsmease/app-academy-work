class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Please enter a password' }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    #has password
    #confirm password is the same as password_digest
    user = User.find_by(username: username)
    valid_password = BCrypt::Password.new(user.password_digest).is_password?(password)
    user && valid_password ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.reset_session_token!
    #generate new session_toke and user.save!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  #why doesn't the solution have @password_digest = ...?
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end
end
