class ChangePhoneToPhoneNumberInMembers < ActiveRecord::Migration[7.0]
  def change
    rename_column :members, :phone, :phone_number
  end
end
