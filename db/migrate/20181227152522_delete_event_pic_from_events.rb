class DeleteEventPicFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :event_pics

  end
end
