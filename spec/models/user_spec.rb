require 'spec_helper'

describe User do
  describe '#build_with_xing' do
    let(:token) do
      {
        access_token: 'access_token',
        access_token_secret: 'access_token_secret'
      }
    end
    before { User.any_instance.stub(:load_xing_profile) }

    it 'updates the xing profile' do
      User.any_instance.should_receive(:update_profile)

      User.build_with_xing(token)
    end

    it 'stores the xing access token' do
      User.any_instance.stub(:update_profile)
      user = User.build_with_xing(token)

      expect(user.access_token).to eq('access_token')
      expect(user.access_token_secret).to eq('access_token_secret')
    end
  end

  describe '.update_profile' do
    subject { build(:user) }

    context 'valid xing profile' do
      it 'sets profile_loaded to true' do
        subject.update_profile(display_name: 'John Doe')
        expect(subject.profile_loaded).to be_true
      end

      it 'sets name' do
        subject.update_profile(display_name: 'John Doe')
        expect(subject.name).to eq('John Doe')
      end

      it 'sets email' do
        subject.update_profile(active_email: 'john.doe@acme.org')
        expect(subject.email).to eq('john.doe@acme.org')
      end

      it 'sets city to private address' do
        subject.update_profile(private_address: { city: 'New York'})
        expect(subject.city).to eq('New York')
      end

      it 'sets city to business address' do
        subject.update_profile(business_address: { city: 'San Francisco'})
        expect(subject.city).to eq('San Francisco')
      end

      it 'sets city to private address first' do
        subject.update_profile(
          private_address: { city: 'New York'},
          business_address: { city: 'San Francisco'}
        )
        expect(subject.city).to eq('New York')
      end

      it 'sets job' do
        subject.update_profile(
          professional_experience: {
            primary_company: {
              title: 'ACME corp'
            }
          }
        )
        expect(subject.job).to eq('ACME corp')
      end

      it 'sets image_url' do
        subject.update_profile(photo_urls: { large: 'image-url'})
        expect(subject.image_url).to eq('image-url')
      end

      it 'sets xing_profile' do
        subject.update_profile(permalink: 'link-to-xing-profile')
        expect(subject.xing_profile).to eq('link-to-xing-profile')
      end
    end

    context 'invalid xing profile' do
      it 'sets profile_loaded to false' do
        subject.update_profile({})

        expect(subject.profile_loaded).to be_false
      end
    end
  end

  describe '.update_existing_user' do
    let(:new_user) { build(:user) }
    let!(:existing_user) do
      create(
        :user,
        email: new_user.email,
        access_token: 'old access token',
        access_token_secret: 'old acces token secret'
      )
    end

    it 'identifies user by email' do
      updated_user = User.update_existing_user(new_user)

      expect(updated_user).to eq(existing_user)
    end

    it 'updates access token and secret' do
      updated_user = User.update_existing_user(new_user)

      expect(updated_user.access_token).to eq(new_user.access_token)
      expect(updated_user.access_token_secret).to eq(new_user.access_token_secret)
    end

    it 'updates user profile from XING' do
      profile_stub = double
      new_user.stub(:load_xing_profile).and_return(profile_stub)

      User.any_instance.should_receive(:update_profile).with(profile_stub)

      User.update_existing_user(new_user)
    end
  end

  describe 'load_xing_profile' do
    subject { build(:user) }
    let(:user_profile) { double }
    let(:xing_response) { { users: [user_profile] } }

    it 'returns xing user profile' do
      XingApi::User.stub(:me).and_return(xing_response)

      expect(subject.load_xing_profile).to eq(user_profile)
    end

    it 'returns empty profile if loading fails' do
      XingApi::User.stub(:me).and_raise(XingApi::Error.new(nil))

       expect(subject.load_xing_profile).to eq({})
    end
  end
end
