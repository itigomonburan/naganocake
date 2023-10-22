Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

# 顧客ルーティング
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'customers' => 'customers#show'
    get 'customers/edit' => 'customers#edit'
    patch 'customers' => 'customers#update'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdraw' => 'customers#withdraw'
    

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items' => 'cart_items#destroy_all', as: 'cart_item_destroy_all'
    resources :orders

    get 'genre/seach' => 'seaches#genre_search'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items

  end

# 管理者ルーティング
  namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者ルーティング
  namespace :admin do
    get '/' => 'homes#top'
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end

