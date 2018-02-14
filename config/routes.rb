Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :posts
#  devise_scope :user { delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session }
  
  get 'posts/page/(:page(.:format))', to: 'posts#index'
  get 'home(/:hello)', to: 'home#index'
  root 'home#index'
end
