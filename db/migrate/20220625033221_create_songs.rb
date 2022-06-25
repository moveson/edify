class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.references :meeting, null: false, foreign_key: true
      t.string :title
      t.integer :song_type

      t.timestamps
    end
  end
end
