# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :accounts
      resources :transactions, only: [:create]
    end
  end
end
