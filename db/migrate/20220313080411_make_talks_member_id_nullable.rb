class MakeTalksMemberIdNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :talks, :member_id, true
  end
end
