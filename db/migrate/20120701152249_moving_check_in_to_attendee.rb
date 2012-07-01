class MovingCheckInToAttendee < ActiveRecord::Migration
  def up
    add_column :attendees, :badged, :boolean
    add_column :attendees, :onsite, :boolean

  end

  def down
  end
end
