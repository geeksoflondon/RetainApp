class CreateCheckins < ActiveRecord::Migration
  def up
    create_table :checkins do |t|
      t.integer :attendee_id
      t.integer :event_id
      t.boolean :onsite
      t.timestamps
    end
  end

  def down
  end
end
