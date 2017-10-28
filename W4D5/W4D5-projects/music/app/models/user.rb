class User < ApplicationRecord
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  attr_reader :password

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def self.generate_session_token
    token = SecureRandom.urlsafe_base64(16)

    #To add: prevent session clashes
    # while self.class.exists?(session_token: token)
    #   token = SecureRandom.urlsafe_base64(16)
    # end

    token
  end

  def password=(password)
    @password = password #why instance variable?
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def name
    self.email.split("").shuffle!.join("")
  end
end
