class Task
  include XingProfile

  def self.sync_with_xing(user)
    profile = load_xing_profile!(user.token)
    user.update_profile(profile)
  rescue XingApi::InvalidOauthTokenError
    user.profile_loaded = false
    user.save
  rescue XingApi::Error => e
  end
end
