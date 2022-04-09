class RenameUserIdForMeetings < ActiveRecord::Migration[7.0]
  def change
    rename_column :meetings, :user_id, :scheduler_id
  end
end
