class CreateImportJobsAgain < ActiveRecord::Migration[7.0]
  def change
    create_table :import_jobs do |t|
      t.references :unit, null: false, foreign_key: true
      t.integer :status
      t.string :status_text
      t.integer :row_count
      t.integer :succeeded_count
      t.integer :failed_count
      t.integer :ignored_count
      t.datetime :started_at
      t.integer :elapsed_seconds
      t.string :error_message
      t.string :log

      t.timestamps
    end
  end
end
