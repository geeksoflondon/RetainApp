class AddEventBriteId < ActiveRecord::Migration
  def up
     change_table :events do |t|
        t.string :eventbrite_id
      end
  end

  def down
  end
end
