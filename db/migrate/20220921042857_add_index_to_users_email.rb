# ユーザーが誤って「登録」ボタンを数回クリックした場合、同じデータがクリック回数分保存されないために、
# まずはrails g migration add_index_to_users_emailでマイグレーションファイルを新規作成後、
# changeメソッド内にadd_indexメソッドで、データベース上のemailカラムにインデックス（index）を追加しそれが一意になるように設定。
# ※データベースにおけるインデックスは、検索を早くする仕組み（索引）」
class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
  end
end
