Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  options '*path', to: 'application#cors_preflight_check'

  # Defines the root path route ("/")
  namespace :api do
    namespace :v1 do
      resources :players, only: %i[show create update]
      resources :sessions, only: %i[show create] do
        patch :start, on: :member
        patch :finish, on: :member
        patch :cash_out, on: :member
      end

      resources :games, only: %i[index]

      namespace :games do
        namespace :frutty_tutty do
          patch :start
          patch :play
          patch :finish
          patch :cash_out
          patch :top_up
        end
      end
    end
  end
end
