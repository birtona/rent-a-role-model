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

    it 'stores request token and secret in the session' do
      XingApi::Client.any_instance.stub(:get_request_token).and_return(request_token)

      get :sign_up

      expect(session[:request_token]).to eq(request_token[:request_token])
      expect(session[:request_token_secret]).to eq(request_token[:request_token_secret])
    end
  end

  describe '#callback' do
    before do
      XingApi::Client.any_instance.stub(:get_access_token)
      User.should_receive(:update_or_create).and_return(user)
    end

    context 'without user' do
      let(:user) { nil }

      it 'redirects to home_index' do
        expect(get(:callback)).to redirect_to(home_index_path)
      end
    end

    context 'user has no information' do
      let(:user) { create(:user, user_information: nil) }

      it 'redirects to admin/user_information new page' do
        expect(get(:callback)).to redirect_to(new_admin_user_user_information_path(user.id))
      end
    end

    context 'user with information' do
      let(:user) { create(:user) }

      it 'redirects to admin/user_information edit page' do
        expect(get(:callback)).to redirect_to(edit_admin_user_user_information_path(user.id))
      end

      it 'sets session user id' do
        get(:callback)

        expect(session[:user_id]).to eq(user.id)
      end
    end
  end
end
