class AddStatusTextToImportJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :import_jobs, :status_text, :string
  end
end
