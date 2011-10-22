class AddingAttendeeNotes < ActiveRecord::Migration
  def up
    add_column :attendees, :notes, :text
  end
end
