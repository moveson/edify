class DropImportJobsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :import_jobs do |t|
      t.bigint "user_id", null: false
      t.integer "status"
      t.string "error_message"
      t.integer "row_count"
      t.integer "success_count"
      t.integer "failure_count"
      t.datetime "started_at"
      t.integer "elapsed_time"
      t.string "status_text"

      t.timestamps
    end
  end
end
