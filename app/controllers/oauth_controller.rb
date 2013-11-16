class OauthController < ApplicationController

  before_filter :set_consumer

  def sign_up
    request_token = @consumer.get_request_token(:oauth_callback => callback_url)
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

    name = user['display_name']
    city = user['private_address']['city'] || user['business_address']['city']
    email = user['active_email']
    image_url = user['photo_urls']['large']
    job = user['professional_experience']['primary_company']['title']
    xing_profile = user['permalink']

    new_user = User.new(name: name, city: city, email: email, image_url: image_url, job: job, xing_profile: xing_profile)

    if new_user.save
      redirect_to home_thanks_path
    else
      redirect_to home_already_path
    end


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

    def callback_url
      if Rails.env.production?
        "http://rent-a-role-model.herokuapp.com/callback"
       else
        "http://localhost:3000/callback"
      end
    end


end
