Rails.application.routes.draw do
  resources :events, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    resources :pictures, only: [:new, :create, :destroy]
    resources :teams, only: [:show, :new, :create, :destroy]
  end
  resources :players, only: [:index, :new, :create, :destroy]
  get "players/start_sort" => "players#start_sort"
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
