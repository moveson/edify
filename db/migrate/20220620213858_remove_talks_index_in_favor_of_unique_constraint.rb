class RemoveTalksIndexInFavorOfUniqueConstraint < ActiveRecord::Migration[7.0]
  def up
    remove_index :talks, [:meeting_id, :position]

    execute <<~SQL
      alter table talks add constraint unique_meeting_id_position unique (meeting_id, position) deferrable initially deferred;
    SQL
  end

  def down
    execute <<~SQL
      alter table talks drop constraint unique_meeting_id_position
    SQL

    add_index :talks, [:meeting_id, :position], unique: true
  end
end
