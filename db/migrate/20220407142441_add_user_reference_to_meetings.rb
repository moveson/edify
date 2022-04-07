class AddUserReferenceToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_reference :meetings, :user, optional: true, foreign_key: true
  end
end
