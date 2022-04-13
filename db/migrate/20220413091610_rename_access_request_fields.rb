class RenameAccessRequestFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :access_requests, :approved_at, :rejected_at
    rename_column :access_requests, :approved_by, :rejected_by
  end
end
