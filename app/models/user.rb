class User < ActiveRecord::Base
  has_one :user_information
  validates_uniqueness_of :email

  def self.build_with_xing(token)
    self.new.tap do |user|
      user.access_token = token[:access_token]
      user.access_token_secret = token[:access_token_secret]
      user.update_profile(user.load_xing_profile)
    end
  end

  def self.update_existing_user(new_user)
      user = User.find_by(email:new_user.email)
      user.access_token = new_user.access_token
      user.access_token_secret = new_user.access_token_secret
      user.update_profile(new_user.load_xing_profile)
      user.save

      user
  end

  def update_profile(profile)
    
    if profile.present?
      self.name           = profile[:display_name]
      self.email          = profile[:active_email]
      self.city           = profile[:private_address].try(:[], :city) || profile[:business_address].try(:[], :city)
      self.job            = profile[:professional_experience].try(:[], :primary_company).try(:[], :title)
      self.image_url      = profile[:photo_urls].try(:[], :large)
      self.xing_profile   = profile[:permalink]
      self.profile_loaded = true
    else
      self.profile_loaded = false
    end
  end

  def load_xing_profile
    client = XingApi::Client.new(
      oauth_token: self.access_token,
      oauth_token_secret: self.access_token_secret
    )

    XingApi::User.me(client: client)[:users].first
  rescue XingApi::Error
    {}
  end

end
