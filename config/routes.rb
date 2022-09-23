# ルーティングの設定とは利用者からのリクエストを表すURLから呼び出すべきコントローラとアクションを見つけ出すルールのこと。
# URLをどのコントローラのどのアクションで処理するかを記述。
Rails.application.routes.draw do
  # get 'sessions/new'

  root 'static_pages#top'
  # rootはルートドメイン（例 https://example.com）にアクセスしたときに表示するページの指定です。
  # rootを指定しない場合は、railsのデフォルトページが表示されます。
  # 基本形は root to: ですが、to: を省略することができます。
  # /へのアクセスをStaticPages(コントローラ)のtop(アクション)で処理させることができる。つまり、rootで最初のページを指定できる。
  # 最初に設定したトップページは、このアプリケーションの初期ページとなるのでroot設定に割り当てる
  # rootルーティングは、ルーティングファイルの冒頭に記述
  # rootは最もよく使用されるルーティングであり、最初にマッチする必要がある
  # rootへのルーティング設定するには、controllerを作成し、config/routes.rbファイルを編集する必要がある。
  # このように置き換えるとコントローラー#アクションへの関連付けが変わり、
  # ルートURL/へのGETリクエスト（HTTP通信でWebブラウザ等のクライアントからWebサーバへと送られる、HTTPリクエストの一種です。 
  # 基本的に、Webサーバから情報を取り出す（GET）するために使用されます。）が、
  # StaticPagesコントローラーのtopアクションにルーティングされるようになる。
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
  # /users/1を追加するためのコードであり、ユーザーのURLを生成するための多数のルーティングヘルパーと共に、
  # RESTfulなUsersリソースで必要となる全てのアクションも利用できるようになる。
  # ↑　要するに色んなアクションやルーティングヘルパー（users_pathなど）やURL（/users）を使えるようにする。
  # 但し、ファイルは自動生成されないため手動で作成する必要有。
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
    end
    resources :attendances, only: :update
  end
end