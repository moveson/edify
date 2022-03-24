class AddNotesToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :notes, :text
  end
end
