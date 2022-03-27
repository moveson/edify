class RemoveNotesFromMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :notes, :text
  end
end
