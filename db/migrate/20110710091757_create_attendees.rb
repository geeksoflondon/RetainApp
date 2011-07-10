class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :event_id
      t.string :ticket_id
      t.string :status
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :twitter
      t.string :t_shirt
      t.string :diet
      t.string :badge

      t.timestamps
    end
  end
end
