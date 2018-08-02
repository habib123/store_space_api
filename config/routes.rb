Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :stores
      resources :spaces do
        get '/price/:start_date/:end_date', to: 'spaces#price', on: :member
      end
    end
  end
end
