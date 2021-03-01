Rails.application.routes.draw do
  devise_for :users
  root to: 'leagues#index'

  resources :leagues, except: [:edit] do
    resources :teams, except: %i[edit index]
  end
end
