# has_secure_passwordの機能を利用するには、第一にUserモデルにpassword_digestカラムを追加する必要があるので、
# rails g migration add_password_digest_to_users password_digest:stringにより、（後でrails db:migrateしてデータを反映）
# まずpassword_digestの次に_to_usersを付けることで、自動的にusersテーブルにカラムを追加するマイグレーションを生成し、
# 次にpassword_digest:stringという引数も入れて今回必要となるカラム名とデータ型を渡したら、
# 第二にbcryptgemを追加することでhas_secure_passwordが使用できるようにする。
# has_secure_passwordメソッドはapp/models/user.rbで記述する。

# has_secure_passwordメソッドとは
# 1. ハッシュ化（入力されたデータ（パスワード）を元に戻せないデータにする処理）
# 　　したパスワードを、データベースのpassword_digestというカラムに保存できるようになる。
# ※パスワードを適切にハッシュ化することで、
# 　万が一ネットによる攻撃を受けてデータベースからパスワードが漏洩してしまった場合でも直接パスワードが渡らず、
# 　最悪の事態を回避することができます。
# 2. ペアとなる仮想的なカラムであるpasswordとpassword_confirmationが使えるようになる。
# 　　さらに存在性と値が一致するかどうかの検証も追加される。
# 3. authenticateメソッドが使用可能となる。
# 　　このメソッドは引数の文字列がパスワードと一致した場合オブジェクトを返し、
#　　 パスワードが一致しない場合はfalseを返す。
# ※このhas_secure_password使用するためにはbcryptと言うgemをインストールする。

class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end
