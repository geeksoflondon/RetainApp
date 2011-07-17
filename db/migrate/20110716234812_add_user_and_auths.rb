class AddUserAndAuths < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
        t.integer :user_id
        t.string :provider
        t.string :uid
        t.string :access_token

        t.timestamps
    end
    
    create_table :users do |t|
      t.string :name
      t.string :auth_token
      t.boolean :is_admin

      t.timestamps
    end
    
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end
  
  def down
  end
end
