class AddForeignKeysForUnits < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :meetings, :units
    add_foreign_key :members, :units
    add_foreign_key :users, :units
  end
end
