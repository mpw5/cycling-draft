Rails.application.routes.draw do
  resources :leagues, only: %i[index show update]
end
