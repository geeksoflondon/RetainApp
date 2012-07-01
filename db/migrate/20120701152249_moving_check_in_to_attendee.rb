class MovingCheckInToAttendee < ActiveRecord::Migration
  def up
    add_column :attendees, :badged, :boolean
    add_column :attendees, :onsite, :boolean

    #migrate the data
    Checkin.all.each do |checkin|
      a = Attendee.find(checkin.attendee.id)
      a.badged = true
      a.onsite = false
      a.save
    end

    #cleanup some old data issues related to checkins
    Attendee.all.each do |attendee|
      if attendee.status == 'attended'
        attendee.status = 'confirmed'
        attendee.badged = true
        attendee.save
      end
    end

    drop_table :checkins

  end

  def down
  end
end
