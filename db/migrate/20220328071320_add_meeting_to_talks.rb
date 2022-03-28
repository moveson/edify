class AddMeetingToTalks < ActiveRecord::Migration[7.0]
  def change
    add_reference :talks, :meeting, optional: true
  end
end
