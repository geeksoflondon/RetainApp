class AddingTrackingTable < ActiveRecord::Migration
  def up
    create_table :trackings do |t|
      t.integer :attendee_id
      t.integer :event_id
      t.string :action
      t.timestamps
    end
  end

  def down
  end
end
