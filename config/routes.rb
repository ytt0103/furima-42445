Rails.application.routes.draw do
  devise_for :users
  # root 'items#index' # 既存の行（もしあればコメントアウトするか削除）

  root 'items#index' # 追加または修正: トップページをitems#indexに設定

  resources :items do
    resources :orders, only: [:index, :create]
  end
end
