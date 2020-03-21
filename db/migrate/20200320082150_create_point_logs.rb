class CreatePointLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :point_logs do |t|
      t.string :twitter_id, null: false
      t.integer :points, null: false
      t.date :aggregated_on, null: false
      t.timestamps
    end
    add_index  :point_logs, [:twitter_id, :aggregated_on], unique: true
  end
end
