class CreateAccessRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :access_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.integer :approved_by
      t.datetime :approved_at

      t.timestamps
    end
  end
end
