Lumos::Application.routes.draw do

  mount Lti2Tc::Engine, at: '/lti2_tc'

  resources :registries
  resources :results

  # cbe resources
  resources :organizations

  get "docs", :to => "docs#show"

  get "home/index"

  root :to => "home#index"

  ActiveAdmin.routes(self)

  post '/admin/register_new_tool', :to => 'admin/register_new_tool#index'

  post '/record_of_performance', :to => 'record_of_performance#post_service'

  devise_for :admin_users, ActiveAdmin::Devise.config

end
