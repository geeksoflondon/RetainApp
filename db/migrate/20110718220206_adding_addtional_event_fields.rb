class AddingAddtionalEventFields < ActiveRecord::Migration
  def up
     change_table :events do |t|
        t.string :event_url
        t.string :venue_url
      end
  end
end
