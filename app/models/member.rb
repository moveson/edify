class Member < ApplicationRecord
  has_many :talks, dependent: :nullify
  enum gender: [:male, :female]

  validates_presence_of :name, :gender, :birthdate
  validates_uniqueness_of :name, scope: :birthdate

  scope :with_last_talk_date, -> do
    from(left_joins(:talks).select("distinct on (members.id) members.*, talks.date as last_talk_date").order("members.id, date desc"), :members)
  end

  def self.ransackable_attributes(auth_object = nil)
    super | %w(last_talk_date)
  end

  def age
    (Date.current - birthdate).to_i / 365
  end

  def bio
    "#{gender.titleize}, #{age}"
  end
end
