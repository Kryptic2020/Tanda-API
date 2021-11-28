class UserNotifierMailer < ApplicationMailer
  default :from => 'aquenzitech@gmail.com'

  require 'sendgrid-ruby'
  include SendGrid
  require 'json'

  # send a reset link to the user, pass in the user object that contains the user's email address
  def forgot_pass(user, token)
    @token = token    
    @user = user
    @url  = "http://localhost:3001/reset-pass/#{@token}"
    mail(to: @user.email, subject: 'Reset Password')
  end

  # send a welcome email to the user, pass in the user object that contains the user's email address
  def welcome(user) 
    @user = user
    @url  = 'https://aquezitech.com/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
 
end
