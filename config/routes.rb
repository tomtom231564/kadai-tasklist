Rails.application.routes.draw do
  get 'toppages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  #toppageを最初の入り口にするためtasks#indexをコメントアウト（課題用）
  #root to: 'tasks#index'

  resources :tasks
  
end
