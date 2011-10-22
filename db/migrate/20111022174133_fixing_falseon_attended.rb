class FixingFalseonAttended < ActiveRecord::Migration
  def up
    change_column :checkins, :attended, :boolean, :default => false
  end

  def down
  end
end
