class RemoveDateFromTalks < ActiveRecord::Migration[7.0]
  def change
    remove_column :talks, :date, :date
  end
end
