class CreateImportedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :imported_users do |t|
      t.string :twitter_id, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
