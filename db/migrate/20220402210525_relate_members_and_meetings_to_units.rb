class RelateMembersAndMeetingsToUnits < ActiveRecord::Migration[7.0]
  def change
    add_reference :meetings, :units, optional: true
    add_reference :members, :units, optional: true
  end
end
