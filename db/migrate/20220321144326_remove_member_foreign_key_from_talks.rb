class RemoveMemberForeignKeyFromTalks < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :talks, :members
  end
end
