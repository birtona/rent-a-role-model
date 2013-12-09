require 'spec_helper'

describe OauthController do
  describe '#sign_up' do
    let(:request_token) do
      {
        request_token: '123',
        request_token_secret: '234',
        authorize_url: 'http://authorize.url'
      }
    end

    it 'passes correct callback url to get a request token' do
      XingApi::Client.any_instance.
        should_receive(:get_request_token).
        with(callback_url).
        and_return(request_token)

      get :sign_up
    end

    it 'redirects to request token auhthorize url' do
      XingApi::Client.any_instance.stub(:get_request_token).and_return(request_token)

      expect(get(:sign_up)).to redirect_to(request_token[:authorize_url])
    end

    it 'stores reuqest token and secret in the session' do
      XingApi::Client.any_instance.stub(:get_request_token).and_return(request_token)

      get :sign_up

      expect(session[:request_token]).to eq(request_token[:request_token])
      expect(session[:request_token_secret]).to eq(request_token[:request_token_secret])
    end
  end

  describe '#callback' do
    before do
      XingApi::Client.any_instance.stub(:get_access_token)
    end

    it 'redirects to thanks page if new user is created' do
      User.stub(:build_with_xing).and_return(double(save: true))

      expect(get(:callback)).to redirect_to(home_thanks_path)
    end

    it 'redirects to already page if user could not be created' do
      User.stub(:build_with_xing).and_return(double(save: false))

      expect(get(:callback)).to redirect_to(home_already_path)
    end
  end
end
