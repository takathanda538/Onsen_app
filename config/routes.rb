Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

devise_scope :customer do
  post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

get "search" => "searches#search"
namespace :admin do
    resources :orders, only:[:show,:update]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :genres, only:[:index,:create,:edit,:update]
    resources :items, except:[:destroy]
    resources :order_details, only:[:update]
    root to: 'homes#top'
  end

  scope module: :public do
    get 'posts/search'
    resources :posts do
      resources :post_comments, only: [:create, :destroy,:edit,:update]
      resource :likes, only: [:create, :destroy]
    end

    resources :customers, only:[:show,:edit,:index,:update] do
      member do
        get :follows, :followers,:likes
      end
      resource :relationships, only: [:create, :destroy]
    end
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :index, :show]
    resources :notifications, only: [:index, :destroy]
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
