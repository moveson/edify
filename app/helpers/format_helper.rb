# frozen_string_literal: true

module FormatHelper
  def pretty_duration(seconds)
    return "--:--" unless seconds.present?

    parse_string = seconds < 3600 ? "%M:%S" : "%H:%M:%S"
    Time.at(seconds).utc.strftime(parse_string)
  end
end