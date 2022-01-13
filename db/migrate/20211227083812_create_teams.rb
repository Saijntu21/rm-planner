class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :manager_id,  null: false
      t.string :manager_name, null: false
      t.integer :team_count, null: false
      t.integer :total_bandwidth
      t.integer :allocated_bandwidth

      t.timestamps
    end
  end
end
