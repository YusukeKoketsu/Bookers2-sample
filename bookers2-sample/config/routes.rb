Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    # １つのbookに対していくつもコメントできるので、resoucesと複数形を使用する
    resources :book_comments, onlr: [:create, :destroy]
    # 1つのbookに対してユーザーは一回しかいいねができないようにする為、resourceと単数形を使用する
    resource :favorites, only: [:create, :destroy]
  end

  # create(follow)、destroy(unfollow)とfollows,followersの一覧用を追加
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  	get 'follows' => 'relationships#follows', as: 'follows'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
