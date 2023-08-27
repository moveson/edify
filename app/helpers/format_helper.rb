# frozen_string_literal: true

module FormatHelper
  # @param [Meeting] meeting
  # @return [String (frozen), nil]
  def callout_class(meeting)
    return unless meeting.not_yet_occurred?

    if meeting.scheduler_id == current_user.id
      "callout callout-primary"
    elsif meeting.scheduler_id.nil? && meeting.not_fully_scheduled?
      "callout callout-warning"
    end
  end

  # @param [Integer] filtered_count
  # @param [Integer] total_count
  # @param [String] model_name
  # @return [String (frozen)]
  def filtered_and_total_count(filtered_count, total_count, model_name)
    total_string = pluralize_with_delimiter(total_count, model_name)
    filtered_count == total_count ? total_string : "#{filtered_count} of #{total_string}"
  end

  # @param [Integer] count
  # @param [String] singular
  # @param [String, nil] plural
  def pluralize_with_delimiter(count, singular, plural = nil)
    pluralize(number_with_delimiter(count), singular, plural)
  end

  # @param [Integer] seconds
  # @return [String]
  def pretty_duration(seconds)
    return "--:--" if seconds.blank?

    parse_string = seconds < 3600 ? "%M:%S" : "%H:%M:%S"
    Time.at(seconds).utc.strftime(parse_string)
  end
end
