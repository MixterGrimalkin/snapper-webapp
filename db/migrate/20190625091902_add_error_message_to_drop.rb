class AddErrorMessageToDrop < ActiveRecord::Migration[5.1]
  def change
    add_column :drops, :email_error, :string
  end
end
