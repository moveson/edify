# frozen_string_literal: true

module IconHelper
  def status_icon(status)
    case status
    when :ok
      fa_icon("check-circle", type: :regular, class: "text-success")
    when :empty
      fa_icon("dot-circle", type: :regular, class: "text-danger")
    when :questionable
      fa_icon("dot-circle", type: :regular, class: "text-secondary")
    else
      raise ArgumentError, "Unknown status: #{status}"
    end
  end
end
