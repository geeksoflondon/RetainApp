class AddPublicProfileTable < ActiveRecord::Migration
  def up
    create_table :attendee_profile do |t|
      t.string :profile_image_url
      t.string :url
      t.string :location
      t.text :description
      t.timestamps
    end
    change_table :attendees do |t|
      t.string :public_profile
    end
  end

  def down
  end
end
