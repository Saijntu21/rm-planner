class CreateWishLists < ActiveRecord::Migration[6.1]
  def change
    create_table :wish_lists do |t|
      t.string :name, null: false
      t.text :description
      t.integer :wish_list_type, null: false
      t.integer :priority, null: false
      t.string :customer_name
      t.integer :quarter
      t.integer :bu_unit, null: false
      t.string :dependent_workflow
      t.string :impact
      t.integer :status
      t.string :created_by

      t.timestamps
    end
  end
end
