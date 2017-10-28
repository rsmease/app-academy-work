require 'rails_helper'

describe User do

  subject(:user) do
    User.new(email: "x", password: "password")
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe '#reset_session_token!' do
    it "sets a new session token on a user" do
      user.valid?
      old_session_token = user.session_token
      user.reset_session_token!
    end
  end

  describe "#is_password?" do
    it "verifies that a password is correct" do
      expect(user.is_password?("password")).to be true
    end
  end

  describe ".find_by_credentials" do
    before { user.save! }

    it "returns user given good credentials" do
      expect(User.find_by_credentials("x", "password")).to eq(user)
    end
  end
end
