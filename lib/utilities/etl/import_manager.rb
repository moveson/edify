# frozen_string_literal: true

module Etl
  class ImportManager
    def self.perform!(import_job)
      new(import_job).perform!
    end

    def initialize(import_job)
      @import_job = import_job
      @raw_member_rows = []
    end

    def perform!
      import_job.start!
      extract_member_list
      save_members if errors.empty?
      set_finish_attributes
    end

    private

    attr_reader :username, :password, :import_job
    attr_accessor :raw_member_rows

    delegate :errors, to: :import_job, private: true

    def extract_member_list
      self.raw_member_rows = ::Etl::ExtractMemberData.perform(import_job)
    end

    def save_members
      import_job.update(status: :loading, success_count: 0, failure_count: 0)

      raw_member_rows.each.with_index(1) do |raw_member_row, row_index|
        member = Member.find_or_initialize_by(name: raw_member_row.name, birthdate: raw_member_row.birthdate)
        raw_member_row.gender = raw_member_row.gender.downcase == "f" ? "female" : "male"
        member.assign_attributes(raw_member_row.to_h)

        if member.save
          import_job.increment!(:success_count)
        else
          import_job.increment!(:failure_count)
          errors.add(:base, resource_error_object(member, row_index))
        end
      rescue ActiveRecord::ActiveRecordError => e
        import_job.increment!(:failure_count)
        errors.add(:base, record_not_saved_error(e, row_index))
      ensure
        import_job.set_elapsed_time!
      end
    end

    def set_finish_attributes
      if errors.empty?
        import_job.update(status: :finished, status_text: nil)
      else
        import_job.update(status: :failed, status_text: nil, error_message: errors.full_messages.to_json)
      end
    end

    def credentials
      @credentials ||= Brigham::Credentials.new(username: username, password: password)
    end

    def resource_error_object(record, row_index)
      { title: "#{record.class} #{record} could not be saved",
        detail: { row_index: row_index, attributes: record.attributes.compact, messages: record.errors.full_messages } }
    end

    def record_not_saved_error(error, row_index)
      { title: "Record could not be saved",
        detail: { row_index: row_index, messages: ["The record could not be saved: #{error}"] } }
    end
  end
end
