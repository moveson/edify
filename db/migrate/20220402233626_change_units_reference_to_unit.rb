class ChangeUnitsReferenceToUnit < ActiveRecord::Migration[7.0]
  def change
    remove_reference :meetings, :units
    add_reference :meetings, :unit
    remove_reference :members, :units
    add_reference :members, :unit
    remove_reference :users, :units
    add_reference :users, :unit
  end
end
