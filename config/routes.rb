Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    namespace :api do #👈namesupaceを使い他のコントローラーのURLを含む作成する使いルーティングを作成
      resources :messages, only: :index, defaults: { format: 'json' } #👈json形式でレスポンス
    end
  end
end
