class UserMailer < ApplicationMailer
  default from: 'notifications@LIFO.com'
 
  def alert_email
    @user = params[:user]
    @url  = params[:url]
    mail(to: @user.email, subject: 'Ahoy, '+@user.username.to_s+'!')
  end

  def activity_summary_email
    mail(to: "gregorysdtaylor@gmail.com", subject: 'lifo activity summary')
  end

end
