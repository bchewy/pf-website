class AddPicturesToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :eventpics, :string
  end
end
