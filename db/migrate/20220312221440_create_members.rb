class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.integer :gender
      t.date :birthdate
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
