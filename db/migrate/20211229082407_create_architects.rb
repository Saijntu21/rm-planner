class CreateArchitects < ActiveRecord::Migration[6.1]
  def change
    create_table :architects do |t|
      t.string :architect_id
      t.string :architect_name

      t.timestamps
    end
  end
end
