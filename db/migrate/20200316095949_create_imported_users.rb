class CreateImportedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :imported_users do |t|
      t.integer :twitter_id
      t.date :registered_on
      t.timestamps
    end
  end
end
