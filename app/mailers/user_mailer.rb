class UserMailer < ActionMailer::Base
  #This domain as http://mail.example.com redirects to the heroku app with a CNAME. This domain needs to be added in the heroku config aswell
  $site_url = 'http://mail.'+ENV['DOMAIN_NAME']
  default from: "contact@"+ENV['DOMAIN_NAME']

  # To unsubscribe from certain emails(must also be the :from of the message. EJ: newsletter@example.com)
  # just add the line
  # @unsubscribe_from = 'an_email@example.com'

  def welcome(user)
    @user = user
    token = @user.tokens.first_or_create
    @token = token.value
    @url  = $site_url+"/activate/#{@token}"

    @unsubscribe_token = @user.tokens.first_or_create.value
    mail(:to => @user.email, :subject => "Welcome")
  end

  def shotgun_email(email)
    @email = email

    mail(:to => Email.separate(email.recipient), :cc => Email.separate(email.cc), :bcc => Email.separate(email.bcc), :from => email.sender, :subject => email.subject)
  end

  def feedback(user)
    @user = user
    @url  = $site_url

    @unsubscribe_token = @user.tokens.first_or_create.value
    mail(:to => user.email, :subject => "Feedback")
  end

  def contact_email(name, email, subject, content)
    @name = name
    @email = email
    @subject = subject
    @content = content
    @user = User.new
    
    @url  = $site_url

    mail(:to => "contact@"+ENV['DOMAIN_NAME'], :from => email, :subject => "Contact")
  end


  def recover_pass(user, token)
    @user = user
    @token = token
    @url  = $site_url+"/change_password/"+@token

    @unsubscribe_token = @user.tokens.first_or_create.value
    mail(:to => user.email, :subject => "Reset your password")
  end



end
