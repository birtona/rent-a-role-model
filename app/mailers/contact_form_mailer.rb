class ContactFormMailer < ActionMailer::Base
  def contact_form_email(user, params)
    @user = user
    @name = params[:name]
    @school = params[:school]
    @event = params[:event]
    @email = params[:email]
    @message = params[:message]
    @datetime = params[:datetime]
    email_with_name = "#{params[:name]} <#{params[:email]}>"
    mail(
      to: "#{@user.name} <#{@user.email}>", 
      subject: "Rent a Role Model Anfrage", 
      from: email_with_name, 
      reply_to: params[:email]
    )
  end
end