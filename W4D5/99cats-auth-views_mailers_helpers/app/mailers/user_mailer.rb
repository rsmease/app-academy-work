class UserMailer < ApplicationMailer
  default from: 'rsmease@gmail.com'

  def welcome_email(user)
    yield :welcome_email
  end
end
