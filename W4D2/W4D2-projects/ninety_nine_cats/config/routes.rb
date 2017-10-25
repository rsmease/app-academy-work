Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "cats#index"

  resources :cats, only: [:index, :create, :show, :new, :edit, :update] do
    resources :cat_rental_requests, only: [:index]
  end

  resources :cat_rental_requests, except: [:edit, :update, :index]


end
