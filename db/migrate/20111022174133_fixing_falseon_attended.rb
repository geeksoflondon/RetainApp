class FixingFalseonAttended < ActiveRecord::Migration
  def up
    
    change_column :checkins, :attended, :boolean, :default => false
    
    Checkin.all.each do |checkin|
      checkin.attended = false unless checkin.attended = true
      checkin.save
    end
    
  end

  def down
  end
end
