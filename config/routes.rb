Rails.application.routes.draw do
  devise_for :users
  # 3
  #generates crud routes
  resources :pics
  #sets index as homepage/root
  root "pics#index"
end
