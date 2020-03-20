class CreatePointLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :point_logs do |t|
      t.string :twitter_id, null: false
      t.integer :points
      t.timestamps
    end
  end
end
