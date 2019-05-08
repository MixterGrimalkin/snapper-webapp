class CreateSnap < ActiveRecord::Migration[5.1]
  def change
    create_table :snaps do |t|
      t.integer :drop_id
      t.string :filename

      t.timestamps
    end
  end
end
