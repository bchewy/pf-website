class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events , :name, :eventName
    rename_column :events , :noppl, :eventNoOfPpl
    rename_column :events , :email, :eventAdminEmail
  end
end
