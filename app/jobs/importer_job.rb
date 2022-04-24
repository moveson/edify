# frozen_string_literal: true

class ImporterJob < ::ApplicationJob
  queue_as :default

  def perform(*_args)
  end
end
