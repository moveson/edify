class AddUserIdUnitIdIndexToAccessRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :access_requests, [:unit_id, :user_id], unique: true
  end
end
