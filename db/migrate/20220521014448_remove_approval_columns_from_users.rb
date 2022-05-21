class RemoveApprovalColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :approved_at, :datetime
    remove_column :users, :approved_by, :integer
  end
end
