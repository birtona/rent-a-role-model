module XingProfile
  extend ActiveSupport::Concern

  module ClassMethods
    def load_xing_profile!(token)
      client = XingApi::Client.new(
        oauth_token: token[:access_token],
        oauth_token_secret: token[:access_token_secret]
      )

      XingApi::User.me(client: client)[:users].first
    end

    def load_xing_profile(token)
      load_xing_profile!(token)
    rescue XingApi::Error
      {}
    end
  end
end
