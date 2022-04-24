class CreateImportJobsAgain < ActiveRecord::Migration[7.0]
  def change
    create_table :import_jobs do |t|
      t.references :unit, null: false, foreign_key: true
      t.integer :status
      t.string :status_text
      t.string :error_message
      t.integer :row_count
      t.integer :success_count
      t.integer :failure_count
      t.datetime :started_at
      t.integer :elapsed_seconds

      t.timestamps
    end
  end
end
