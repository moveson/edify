# frozen_string_literal: true

module FormatHelper
  def filtered_and_total_count(filtered_count, total_count, model_name)
    total_string = pluralize_with_delimiter(total_count, model_name)
    filtered_count == total_count ? total_string : "#{filtered_count} of #{total_string}"
  end

  def pluralize_with_delimiter(count, singular, plural = nil)
    pluralize(number_with_delimiter(count), singular, plural)
  end

  def pretty_duration(seconds)
    return "--:--" unless seconds.present?

    parse_string = seconds < 3600 ? "%M:%S" : "%H:%M:%S"
    Time.at(seconds).utc.strftime(parse_string)
  end
end
