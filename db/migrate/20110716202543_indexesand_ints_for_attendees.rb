class IndexesandIntsForAttendees < ActiveRecord::Migration
  def up
    change_table :attendees do |t|
      t.index :ticket_id
      t.index :event_id
    end
    change_column :attendees, :ticket_id, :integer
  end
end
