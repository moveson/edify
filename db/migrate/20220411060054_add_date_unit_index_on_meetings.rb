class AddDateUnitIndexOnMeetings < ActiveRecord::Migration[7.0]
  def change
    add_index :meetings, [:date, :unit_id], unique: true
  end
end
