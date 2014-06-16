# encoding: UTF-8

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

    association         :user_information, factory: :user_information
  end

  factory :user_information do
    why       'Ich finde alle Bienen können Honig Sammeln'
    past      'Noch keinem'
    projects  'Bei viele tollen Abenteuern'
    places    'Auf jeder sonnigen Wiese'
  end

end
