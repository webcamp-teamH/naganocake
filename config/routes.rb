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

    get '/customers/mypage' =>'customers#show'
    get '/customers/infomation/edit' => 'customers#edit'
    patch '/customers/infomation' => 'customers#update'
    get '/customers/quit' => 'customers#quit'
    patch '/customers/close' => 'customers#close'

    resources :carts, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end

    post '/orders/confirm' => 'orders#confirm'
    get '/orders/finish' => 'orders#finish'
    resources :orders, only: [:new, :index, :show, :create]

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  #管理者用

   devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: 'admin/sessions'
    }

  namespace :admin do
    get "/" => "homes#top"

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
