class ChangeEventPics < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :eventpics, :event_pics
  end
end
