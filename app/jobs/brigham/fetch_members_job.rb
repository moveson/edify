# frozen_string_literal: true

require "utilities/brigham"

module Brigham
  class FetchMembersJob < ApplicationJob
    self.log_arguments = false

    def perform(args)
      username = args[:username]
      password = args[:password]
      import_job_id = args[:import_job_id]
      errors = []

      import_job = ImportJob.find(import_job_id)

      errors << "Username was not provided" if username.blank?
      errors << "Password was not provided" if password.blank?

      if errors.present?
        import_job.update(error_message: errors.to_json)
        import_job.failed!
        return
      end

      ImportManager.perform!(username: username, password: password, import_job: import_job)
  end
  end
end
