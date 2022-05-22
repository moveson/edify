class ChangeApprovedRoleFromIntegerToString < ActiveRecord::Migration[7.0]
  def up
    change_column :access_requests, :approved_role, :string
  end

  def down
    change_column :access_requests, :approved_role, :integer, using: "approved_role::integer"
  end
end
