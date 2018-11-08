class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :notifiable_id
      t.string :notifiable_type
      t.datetime :read_at

      t.timestamps null: false
    end
    add_index :notifications, %i[user_id notifiable_id notifiable_type], unique: true, name: 'index_notifications_unique_constraints'
  end
end
