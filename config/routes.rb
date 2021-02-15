Rails.application.routes.draw do
  resources :leagues, except: [:edit] do
    resources :teams, except: %i[edit update index]
  end
end
