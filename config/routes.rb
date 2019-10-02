# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  resources :items

  root to: "items#index"

  mount Sidekiq::Web => "/sidekiq"
end
