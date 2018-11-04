class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :article_id, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :stocks, %i[user_id article_id], unique: true
  end
end
