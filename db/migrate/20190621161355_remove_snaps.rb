class RemoveSnaps < ActiveRecord::Migration[5.1]
  def change
    drop_table :snaps
  end
end
