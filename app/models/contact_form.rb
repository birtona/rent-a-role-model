class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :file,      :attachment => true

  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
  @user = User.find(params[:user_id])
    {
      :subject => "Rent a Role Model request",
      :to => @user.email,
      :from => %("#{name}" <#{email}>)
    }
  end
end