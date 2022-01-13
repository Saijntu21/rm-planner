class AddThemesToEpics < ActiveRecord::Migration[6.1]
  def change
    add_column :epics, :theme_id, :integer
    add_column :epics, :theme_name, :string
  end
end
