class AddSpeakerNameToTalks < ActiveRecord::Migration[7.0]
  def change
    add_column :talks, :speaker_name, :string
  end
end
