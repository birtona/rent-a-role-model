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

    result = access_token.request(:get, "https://api.xing.com/v1/users/me?fields=id,display_name,gender")
    render :json => JSON.parse(result.body)
  end

  private

  def set_consumer
    @consumer = OAuth::Consumer.new("4bc912de1d6c2995f20b", "76d85467acc63938c18008140c98e27b60bf6d3d", {
      :site => "https://api.xing.com",
      :request_token_path => "/v1/request_token",
      :authorize_path => "/v1/authorize",
      :access_token_path => "/v1/access_token"
    })
  end
 
end