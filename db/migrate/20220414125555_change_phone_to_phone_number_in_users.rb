class ChangePhoneToPhoneNumberInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :phone, :phone_number
  end
end
