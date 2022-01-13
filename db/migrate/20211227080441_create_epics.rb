class CreateEpics < ActiveRecord::Migration[6.1]
  def change
    create_table :epics do |t|
      t.string :name, null: false
      t.text :description
      t.integer :epic_type, null: false
      t.string :architect_id, null: false
      t.string :architect_name, null: false
      t.integer :priority, null: false
      t.integer :bu_unit, null: false
      t.string :i2p_document
      t.string :assigned_to
      t.string :manager_name
      t.integer :quarter
      t.string :customer_name
      t.string :created_by
      t.text :dependent_workflow
      t.string :impact
      t.integer :eta
      t.integer :status

      t.timestamps
    end
  end
end
