class User < ActiveRecord::Base
  has_one :user_information
  validates_uniqueness_of :email

  def self.update_or_create(token)
    profile = load_xing_profile(token)
    return unless profile.present?

    (User.find_by(email: profile[:active_email]) || User.new).tap do |user|
      user.access_token = token[:access_token]
      user.access_token_secret = token[:access_token_secret]
      user.update_profile(profile)
      user.save
    end
  end

  def self.load_xing_profile(token)
    client = XingApi::Client.new(
      oauth_token: token[:access_token],
      oauth_token_secret: token[:access_token_secret]
    )

    XingApi::User.me(client: client)[:users].first
  rescue XingApi::Error
    {}
  end

  def profile_owner?(user)
    self.id == user.id
  end

  def update_profile(profile)
    self.name           = profile[:display_name]
    self.email          = profile[:active_email]
    self.city           = profile[:private_address].try(:[], :city) || profile[:business_address].try(:[], :city)
    self.job            = profile[:professional_experience].try(:[], :primary_company).try(:[], :title)
    self.image_url      = profile[:photo_urls].try(:[], :large)
    self.xing_profile   = profile[:permalink]
    self.profile_loaded = true
  end

end
