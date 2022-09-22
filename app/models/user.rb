# モデルには単数形（User）※コントローラには複数形（Users）
# UserクラスはApplicationRecordクラスを継承しているから、Active Recordのメソッドが使える
class User < ApplicationRecord
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  # before_saveはコールバックメソッドという特定の時点で呼び出されるメソッドであり、
  # オブジェクトが保存される時点で処理を実行できる
  # 現在のメールアドレス（self.email）の値をdowncase(小文字)メソッドを使って小文字に変換
  
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # ↑↑　この正規表現でメールアドレスのフォーマットを検証できる
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    #formatオプションでは引数に正規表現（Regular Expression）を指定
                    # VALID_EMAIL_REGEX＝正規表現＝値が変化することがないため定数として定義
                    #Rubyでは定数を定義する時は、大文字のスネークケースで記述する
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
 # より安全性を高めるため、パスワードの存在性と最小文字数（6文字以上とする）の2つを設定
 
 # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
end
