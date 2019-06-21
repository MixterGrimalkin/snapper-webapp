class CreateMailgunConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :mailgun_configs do |t|
      t.string :domain
      t.string :api_key

      t.timestamps
    end
  end
end
