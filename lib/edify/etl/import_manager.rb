# frozen_string_literal: true

module Edify
  module Etl
    class ImportManager
      GENDER_MAP = {
        "f" => "female",
        "m" => "male",
      }.freeze

      def self.perform!(import_job)
        new(import_job).perform!
      end

      def initialize(import_job)
        @import_job = import_job
        @raw_member_rows = []
      end

      def perform!
        start_import_job
        extract_member_list
        save_members if errors.empty?
        set_finish_attributes
      end

      private

      attr_reader :import_job
      attr_accessor :raw_member_rows

      delegate :errors, to: :import_job, private: true

      def start_import_job
        import_job.start!
        import_job.touch
      end

      def extract_member_list
        self.raw_member_rows = ExtractMemberData.perform(import_job)
      end

      def save_members
        import_job.update(status: :loading, succeeded_count: 0, failed_count: 0)

        raw_member_rows.each.with_index(1) do |raw_member_row, row_index|
          member = ::Member.find_or_initialize_by(
            unit_id: unit.id,
            name: raw_member_row.name,
            birthdate: raw_member_row.birthdate
          )
          gender_indicator = raw_member_row.gender&.downcase&.first
          raw_member_row.gender = GENDER_MAP[gender_indicator]
          member.assign_attributes(raw_member_row.to_h)
          member.synced_on = Date.current

          if member.save
            import_job.increment!(:succeeded_count)
            import_job.log!("Saved:   #{member.name}")
          elsif ignore?(member)
            import_job.increment!(:ignored_count)
            import_job.log!("Ignored: #{member.name}")
          else
            import_job.increment!(:failed_count)
            import_job.log!("** Failed: #{member.name} **")
            errors.add(:base, resource_error_object(member, row_index))
          end
        rescue ActiveRecord::ActiveRecordError => e
          import_job.increment!(:failed_count)
          import_job.log!("** Unable to save member for row #{row_index} **")
          errors.add(:base, record_not_saved_error(e, row_index))
        ensure
          import_job.set_elapsed_time!
        end
      end

      def set_finish_attributes
        if errors.empty?
          import_job.update(status: :finished, status_text: nil)
          today = Date.current
          unit.first_synced_on ||= today
          unit.last_synced_on = today
          unit.save!
        else
          import_job.update(status: :failed, status_text: nil, error_message: errors.full_messages.to_json)
        end
      end

      def unit
        @unit ||= import_job.unit
      end

      def ignore?(member)
        member.under_age?
      end

      def resource_error_object(record, row_index)
        param_filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
        attributes = param_filter.filter(record.attributes.compact)

        { title: "#{record.class} #{record} could not be saved",
          detail: { row_index: row_index, attributes: attributes, messages: record.errors.full_messages } }
      end

      def record_not_saved_error(error, row_index)
        { title: "Record could not be saved",
          detail: { row_index: row_index, messages: ["The record could not be saved: #{error}"] } }
      end
    end
  end
end
