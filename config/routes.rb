RentARoleModel::Application.routes.draw do
  get 'sign_up' => 'oauth#sign_up'
  get 'callback' => "oauth#callback"
end
