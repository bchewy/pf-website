class AddAttachToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :attachment, :string
  end
end
