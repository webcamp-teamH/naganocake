Rails.application.routes.draw do


   #顧客用
  scope module: 'public' do
    devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    root to: "homes#top"
    get "about" => "homes#about"

    resources :items, only: [:index, :show]
    resources :customers, only: [:show]
    get '/customers/infomation/edit' => 'customers#edit'
    patch '/customers/infomation' => 'customers#update'
    get '/customers/cancel' => 'customers#cancel'
    patch '/customers' => 'customers#close'

    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'

    resources :orders, only: [:new, :index, :show, :create]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/finish' => 'orders#finish'

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  #管理者用
  namespace :admin do
    devise_for :admin,skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
    }
    get "/" => "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
