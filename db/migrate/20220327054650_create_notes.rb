class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :member, null: false, foreign_key: true
      t.date :date
      t.text :content

      t.timestamps
    end
  end
end
