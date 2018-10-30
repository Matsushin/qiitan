class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
