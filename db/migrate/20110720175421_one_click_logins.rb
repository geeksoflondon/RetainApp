class OneClickLogins < ActiveRecord::Migration
  def up
    create_table :oneclicks do |t|
      t.integer :attendee_id
      t.string :token
      t.boolean :used
      t.timestamps
    end
  end

  def down
    drop_table :oneclicks
  end
end
