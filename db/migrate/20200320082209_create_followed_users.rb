class CreateFollowedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :followed_users,id: false do |t|
      t.string :twitter_id, primary_key: true
      t.integer :points
      t.integer :followers_num
      t.string :name
      t.string :screen_name
      t.text :profile
      t.string :profile_image_url
      t.boolean :official_account, null: false, default: false
      t.timestamps
    end
  end
end
