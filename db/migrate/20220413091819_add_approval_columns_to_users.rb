class AddApprovalColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :approved_at, :datetime
    add_column :users, :approved_by, :integer
  end
end
