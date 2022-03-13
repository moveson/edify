class Talk < ApplicationRecord
  belongs_to :member, optional: true

  def member_name
    member&.name
  end

  def topic_truncated
    return unless topic.present?
    return topic if topic.length <= 50
    "#{topic.first(50)}..."
  end
end
