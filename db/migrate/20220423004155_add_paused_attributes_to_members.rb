class AddPausedAttributesToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :paused_until, :date
    add_column :members, :paused_at, :date
    add_column :members, :paused_by, :integer
  end
end
