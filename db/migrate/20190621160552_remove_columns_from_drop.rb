class RemoveColumnsFromDrop < ActiveRecord::Migration[5.1]
  def change
    remove_column :drops, :twitter
    remove_column :drops, :share_by_twitter
    remove_column :drops, :tag_twitter_user
    remove_column :drops, :shared_at
    remove_column :drops, :primary_snap_id
  end
end
