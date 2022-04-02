class AddUnitReferenceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :units, optional: true
  end
end
