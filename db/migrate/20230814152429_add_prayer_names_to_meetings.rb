class AddPrayerNamesToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :opening_prayer_name, :string
    add_column :meetings, :closing_prayer_name, :string
  end
end
