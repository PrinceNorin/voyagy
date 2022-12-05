Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :token, only: [:create]
      resources :vessels, only: [:index, :create, :update] do
        resources :voyages, only: [:index, :create, :update]
      end
    end
  end
end
