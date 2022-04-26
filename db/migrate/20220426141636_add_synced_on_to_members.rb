class AddSyncedOnToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :synced_on, :date
  end
end
