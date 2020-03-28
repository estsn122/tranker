class CreatePointRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :point_records do |t|
      t.string :twitter_id, null: false
      t.integer :points, null: false
      t.date :recorded_on, null: false
      t.timestamps
    end
    add_index  :point_records, [:twitter_id, :recorded_on], unique: true
  end
end
