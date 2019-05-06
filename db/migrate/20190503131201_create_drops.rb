class CreateDrops < ActiveRecord::Migration[5.1]
  def change
    create_table :drops do |t|
      t.string :image_location
      t.string :name
      t.string :email
      t.string :twitter
      t.string :gdpr_text
      t.boolean :gdpr_consent
      t.boolean :send_by_email
      t.timestamp :sent_at
      t.boolean :share_by_twitter
      t.boolean :tag_twitter_user
      t.timestamp :shared_at

      t.timestamps
    end
  end
end
