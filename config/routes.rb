Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :articles, only: %i[index show]
      resource :authentication, only: %i[create]
      resource :registration, only: %i[create]
      resource :user, only: [] do
        scope module: :user do
          resources :articles, only: %i[index create update destroy]
        end
      end
    end
  end
end
