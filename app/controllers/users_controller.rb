# コントローラには複数形（Users）※モデルには単数形（User）
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    # @user = User.find(params[:id])
    # リクエストが送信されると、params[:id]は/users/1の1に置き換わり、
    # User.find(params[:id])は、User.find(1)となり/users/1が動作するようになる
    
    # debugger # インスタンス変数を定義した直後にこのメソッドが実行されます。
    # 直接的にデバッグする手法、byebug gemによるdebuggerメソッド。(byebug)プロンプトでアプリケーションの状態を確認
    # サーバーを停止せずにデバッグを終了したいときはfin
    # なにかしらのエラーが発生したときに、エラーの原因を特定しエラー箇所を修正することをデバッグと言います。
    # デバッグが終わったら、showアクション内のdebuggerメソッドの行を忘れずに削除しましょう。
    # メソッドを残したままですと、本番環境の運用などで正常に動作しなくなります。
  end
  
  def new
    @user = User.new # ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # 保存成功後、ログインします。
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    # @user = User.find(params[:id])
    # if @user.update_attributes(user_params)
    #   flash[:success] = "ユーザー情報を更新しました。"
    #   redirect_to @user
    # else
    #   render :edit      
    # end
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # beforeフィルター
    
    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 記憶しているURL(またはデフォルトURL)にリダイレクトします。
    # def redirect_back_or(default_url)
    #   redirect_to(session[:forwarding_url] || default_url)
    #   session.delete(:forwarding_url)
    # end
  
    # アクセスしようとしたURLを記憶します。
    # def store_location
    #   session[:forwarding_url] = request.original_url if request.get?
    # end
    
    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
end