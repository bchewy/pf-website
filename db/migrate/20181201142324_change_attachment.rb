class ChangeAttachment < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :attachment, :event_banner
  end
end
