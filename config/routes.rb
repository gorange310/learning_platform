Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root 'programs#index'

    resources :programs
    resources :program_categories
    resources :currencies
    resources :program_types
  end
end
