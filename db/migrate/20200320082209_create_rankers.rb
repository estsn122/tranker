class CreateRankers < ActiveRecord::Migration[5.2]
  def change
    create_table :rankers do |t|
      t.string :twitter_id, null: false, index: { unique: true }
      t.integer :points
      t.string :name
      t.string :screen_name
      t.text :profile
      t.string :profile_image_url
      t.boolean :official, default: false
      t.timestamps
    end
  end
end
