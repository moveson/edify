class AddNotificationPreferencesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :notification_preference_email, :boolean
    add_column :users, :notification_preference_sms, :boolean
  end
end
