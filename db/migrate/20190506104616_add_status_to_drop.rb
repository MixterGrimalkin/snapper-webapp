class AddStatusToDrop < ActiveRecord::Migration[5.1]
  def change
    add_column :drops, :status, :string
  end
end
