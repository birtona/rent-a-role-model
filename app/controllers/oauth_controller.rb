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

    user = User.update_or_create(access_token)

    if user.nil?
      redirect_to home_index_path
    else
      session[:user_id] = user.id
      if user.user_information
        redirect_to edit_admin_user_user_information_path(user.id)
      else
        redirect_to new_admin_user_user_information_path(user.id)
      end
    end
  end

  private

  def set_client
    @client = XingApi::Client.new
  end
end
