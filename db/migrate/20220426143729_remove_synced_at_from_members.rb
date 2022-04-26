class RemoveSyncedAtFromMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :synced_at, :datetime
  end
end
