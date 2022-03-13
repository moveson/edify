class Talk < ApplicationRecord
  belongs_to :member, optional: true

  def member_name
    member&.name
  end
end
