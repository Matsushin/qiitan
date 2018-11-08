class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :article_id, index: true, foreign_key: true
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
