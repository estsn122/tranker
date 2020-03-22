class CreateUnregisteredUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :unregistered_users do |t|
      t.string :twitter_id, null: false, index: { unique: true }
      t.boolean :truncation, null: false, default: false
      t.timestamps
    end
  end
end
