# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items

  root to: "items#index"
end
