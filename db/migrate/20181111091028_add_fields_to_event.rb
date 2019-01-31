class AddFieldsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :email, :string
    add_column :events, :noppl, :integer
  end
end
