class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :answers
      t.string :hints
      t.string :event_pics
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
