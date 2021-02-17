Rails.application.routes.draw do
  root to: 'home#index'

  resources :leagues, except: [:edit] do
    resources :teams, except: %i[edit update index]
  end
end
