class AddNameBirthdateIndexOnMembers < ActiveRecord::Migration[7.0]
  def change
    add_index :members, [:name, :birthdate], unique: true
  end
end
