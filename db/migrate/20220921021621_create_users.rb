# マイグレーションファイル…データベースに与える変更を定義したchangeメソッドの集まり
# この段階ではデータベースに反映されていないので、rails db:migrateで反映させる
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
    # create_tableメソッドを呼び出し:usersと指定することによってusersテーブルを作成
    # create_tableメソッドはブロック変数（|t|の部分）を持つ。
    # このブロックの中でnameとemailカラムをデータベースに作成…というのが
    # rails g model User name:string email:stringでUserモデルと同時に自動で作られる。
      t.string :name
      t.string :email

      t.timestamps
      # 自動的に生成される特別なコードで、created_at（datetime型）、updated_at（datetime型）の2つのマジックカラムを生成
      # ブロック内に記述はないが、id（integer型）というIDの役割を持ったカラムも自動で生成
    end
  end
end
