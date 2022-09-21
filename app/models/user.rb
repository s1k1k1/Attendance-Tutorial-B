# モデルには単数形（User）※コントローラには複数形（Users）
# UserクラスはApplicationRecordクラスを継承しているから、Active Recordのメソッドが使える
class User < ApplicationRecord
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
end
