class RenamePausedAtForMembers < ActiveRecord::Migration[7.0]
  def change
    rename_column :members, :paused_at, :paused_on
  end
end
