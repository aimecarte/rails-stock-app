class UserMailer < ApplicationMailer

  default from: 'no-reply@example.com'
  layout false  # <-- Debugger if the layout is the error
  
  def registration_success(user)
    @user = user
    mail(to: @user.email, subject: 'Registration Successful')
  end

  def account_approve(user)
    @user = user
    mail(to: @user.email, subject: 'Your Account Was Approved')
  end
  

end
