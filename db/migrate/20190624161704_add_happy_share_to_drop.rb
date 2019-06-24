class AddHappyShareToDrop < ActiveRecord::Migration[5.1]
  def change
    add_column :drops, :happy_to_share, :boolean, default: false
  end
end
