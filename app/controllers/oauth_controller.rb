class OauthController < ApplicationController

  before_filter :set_consumer

  def sign_up
    request_token = @consumer.get_request_token(:oauth_callback =>"http://localhost:3000/callback")
    session[:token] = request_token.token
    session[:secret] = request_token.secret
    # print request_token
    redirect_to request_token.authorize_url
  end  

  def callback
    request_token = OAuth::RequestToken.new(@consumer, session[:token], session[:secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier]) 

    result = access_token.request(:get, "https://api.xing.com/v1/users/me")
    user = JSON.parse(result.body)
    user = user["users"].first
    render :json => user
  end

  private

  def set_consumer
    @consumer = OAuth::Consumer.new("1b2197c12ae0e71d54a4", "afac7a8b9bc59b448d744cfbf3ac24e460749fcd", {
      :site => "https://api.xing.com",
      :request_token_path => "/v1/request_token",
      :authorize_path => "/v1/authorize",
      :access_token_path => "/v1/access_token"
    })
  end
 
end