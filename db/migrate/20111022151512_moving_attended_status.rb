class MovingAttendedStatus < ActiveRecord::Migration
  def up
    change_table :checkins do |t|
      t.boolean :attended
    end
    
    #Fixing the checkin table
    Attendee.all.each do |attendee| 
      attendee.checkin.event_id = attendee.event_id
      attendee.checkin.save
    end
    
  end

  def down
  end
end
