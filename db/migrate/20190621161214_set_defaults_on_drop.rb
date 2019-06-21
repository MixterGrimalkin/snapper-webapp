class SetDefaultsOnDrop < ActiveRecord::Migration[5.1]
  def up
    change_column_default :drops, :status, 'PENDING'
  end

  def down
    change_column_default :drops, :status, nil
  end
end
