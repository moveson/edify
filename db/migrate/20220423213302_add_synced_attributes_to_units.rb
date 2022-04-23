class AddSyncedAttributesToUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :units, :first_synced_on, :date
    add_column :units, :last_synced_on, :date
  end
end
