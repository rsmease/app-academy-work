Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy, :show]
  resources :bands, except: [:destroy]

  #add default root when it makes sense to do so
  root to: redirect('/session/new')
end
