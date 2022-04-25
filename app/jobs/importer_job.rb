# frozen_string_literal: true

require "utilities/etl"

class ImporterJob < ::ApplicationJob
  queue_as :default

  def perform(import_job:)
    Etl::ImportManager.perform!(import_job)
  end
end
