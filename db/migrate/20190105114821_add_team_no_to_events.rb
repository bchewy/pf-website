class AddTeamNoToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :eventNoTeams, :integer
  end
end
