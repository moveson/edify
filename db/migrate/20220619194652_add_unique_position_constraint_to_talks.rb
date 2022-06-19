class AddUniquePositionConstraintToTalks < ActiveRecord::Migration[7.0]
  def change
    add_index :talks, [:meeting_id, :position], unique: true
  end
end
