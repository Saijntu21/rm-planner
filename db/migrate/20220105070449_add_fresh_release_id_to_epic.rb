class AddFreshReleaseIdToEpic < ActiveRecord::Migration[6.1]
  def change
    add_column :epics, :fresh_release_id, :string
  end
end
