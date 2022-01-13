class AddProjectIdToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :project_id, :integer
    add_column :teams, :sub_project_id, :string
    add_column :teams, :owner_id, :string
    add_column :teams, :project_key, :string
  end
end
