class AddBarcodes < ActiveRecord::Migration
  def up
    change_table :attendees do |t|
      t.string :barcode
    end
  end

  def down
  end
end
