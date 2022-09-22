# コントローラには複数形（Users）※モデルには単数形（User）
class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
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
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end