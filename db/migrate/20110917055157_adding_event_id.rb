class AddingEventId < ActiveRecord::Migration
  def up
    Checkin.all.each do |checkin| 
      checkin.event_id = 1 
      checkin.save 
    end
  end

  def down
  end
end
