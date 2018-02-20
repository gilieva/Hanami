Rails.application.routes.draw do
  resources :meetings
  root 'home#index'
get 'meetings/index'

  get 'meetings/show'

  get 'meetings/new'

  get 'meetings/edit'

  get 'meetings/update'
  get 'home/destroy'
  get 'home/create'
  get 'home/update'
  post "/create" => "home#create"

  devise_for :users, controllers: {registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
