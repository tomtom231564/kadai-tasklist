Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  #get 'toppages/index' 課題用でコメントアウト
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'#loginのページをloginのURLでつくるよ
  post 'login', to: 'sessions#create'#ログイン成功失敗の切り替え処理のルーター
  delete 'logout', to: 'sessions#destroy'#ログアウト用のルーター
  
  
  #toppageを最初の入り口にするためtasks#indexをコメントアウト（課題用）
  #root to: 'tasks#index'
  resources :users, only: [:create]
  #課題用にtasksを設定
  resources :tasks
  
end
