class AddForeignKeyForMeetings < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :talks, :meetings
  end
end
