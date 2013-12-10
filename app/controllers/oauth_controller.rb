class OauthController < ApplicationController
  before_filter :set_client

  def sign_up
    token = @client.get_request_token(callback_url)
    session[:request_token] = token[:request_token]
    session[:request_token_secret] = token[:request_token_secret]

    redirect_to token[:authorize_url]
  end

  def callback
    access_token = @client.get_access_token(
      params[:oauth_verifier],
      request_token: session[:request_token],
      request_token_secret: session[:request_token_secret]
    )

    new_user = User.build_with_xing(access_token)

    if new_user.save
      redirect_to home_thanks_path
    else
      redirect_to home_already_path
    end
  end

  private

  def set_client
    @client = XingApi::Client.new
  end
end
