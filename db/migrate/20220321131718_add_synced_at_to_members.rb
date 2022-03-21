class AddSyncedAtToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :synced_at, :datetime
  end
end
