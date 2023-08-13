class AddProgramMembersToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :presider_name, :string
    add_column :meetings, :conductor_name, :string
    add_column :meetings, :chorister_name, :string
    add_column :meetings, :organist_name, :string
  end
end
