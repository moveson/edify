require "edify/etl"

class ImporterJob < ::ApplicationJob
  queue_as :default

  def perform(import_job:)
    ::Edify::Etl::ImportManager.perform!(import_job)
  end
end
