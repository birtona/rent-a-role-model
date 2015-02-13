class User < ActiveRecord::Base
  include XingProfile
  has_one :user_information
  validates_uniqueness_of :email
  scope :active, -> { where(profile_loaded: true).where.not(access_token: nil) }

  def self.update_or_create(token)
    profile = load_xing_profile(token)
    return unless profile.present?

    (User.find_by(email: profile[:active_email]) || User.new).tap do |user|
      user.token = token
      user.update_profile(profile)
      user.save
    end
  end

  def profile_owner?(user)
    self.id == user.id
  end

  def update_profile(profile)
    self.xing_id        = profile[:id]
    self.name           = profile[:display_name]
    self.email          = profile[:active_email]
    self.city           = profile[:private_address].try(:[], :city) || profile[:business_address].try(:[], :city)
    self.job            = profile[:professional_experience].try(:[], :primary_company).try(:[], :title)
    self.image_url      = profile[:photo_urls].try(:[], :large)
    self.xing_profile   = profile[:permalink]
    self.profile_loaded = true
    self.save
  end

  def token
    {
      access_token: self.access_token,
      access_token_secret: self.access_token_secret
    }
  end

  def token=(token)
    self.access_token = token[:access_token]
    self.access_token_secret = token[:access_token_secret]
  end

end
