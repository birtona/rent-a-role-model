class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,      :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attr_accessor :user 


  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.

  
def headers
    {
      :subject => "Rent a Role Model request",
      :from => Rails.application.config.action_mailer.default_options[:from],
      :to => @user.email,
      :message => %("#{message}"),
      :reply_to => email
    }
  end
end


