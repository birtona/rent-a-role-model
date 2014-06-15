FactoryGirl.define do
  sequence :email do |n|
    "biene#{n}@maya.de"
  end

  factory :user do
    name                'Biene Maya'
    city                'Bienenstock 15'
    email               { generate(:email) }
    image_url           'https://www.xing.com/img/n/nobody_f.140x185.jpg'
    job                 'Superhacker'
    xing_profile        'https://www.xing.com/profile/Biene_Maya9'
    access_token        'access_token'
    access_token_secret 'access_token_secret'
    profile_loaded      true
  end
end
