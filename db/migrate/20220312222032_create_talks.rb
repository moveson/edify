class CreateTalks < ActiveRecord::Migration[7.0]
  def change
    create_table :talks do |t|
      t.references :member, null: false, foreign_key: true
      t.date :date
      t.string :purpose
      t.string :topic

      t.timestamps
    end
  end
end
