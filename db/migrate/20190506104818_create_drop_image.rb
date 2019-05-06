class CreateDropImage < ActiveRecord::Migration[5.1]
  def change
    create_table :drop_images do |t|
      t.integer :drop_id
      t.string :filename
    end
  end
end
