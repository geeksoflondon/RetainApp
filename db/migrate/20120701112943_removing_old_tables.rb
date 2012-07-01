class RemovingOldTables < ActiveRecord::Migration
  def up
    drop_table :authentications
    drop_table :users
    drop_table :attendee_profile
  end

  def down
  end
end
