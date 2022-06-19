class AddPositionToTalks < ActiveRecord::Migration[7.0]
  def change
    add_column :talks, :position, :integer
  end
end
