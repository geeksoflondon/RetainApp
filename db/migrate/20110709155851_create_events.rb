class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :start
      t.date :end
      t.string :venue
      t.string :logo

      t.timestamps
    end
  end
end
