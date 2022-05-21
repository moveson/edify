class AddApprovalColumnsToAccessRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :access_requests, :approved_at, :datetime
    add_column :access_requests, :approved_by, :integer
    add_column :access_requests, :approved_role, :integer
  end
end
