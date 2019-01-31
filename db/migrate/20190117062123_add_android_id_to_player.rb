class AddAndroidIdToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :AndroidID, :string
  end
end
