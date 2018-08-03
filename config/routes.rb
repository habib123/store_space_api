require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      resources :stores
      resources :spaces do
        get '/price/:start_date/:end_date', to: 'spaces#price', on: :member
      end
    end
  end
end
