class CreateUnregisteredUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :unregistered_users do |t|
      t.string :twitter_id, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
