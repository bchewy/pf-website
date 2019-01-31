class AddEventIDtoEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :eventID, :integer
  end
end
