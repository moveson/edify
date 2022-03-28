class Meeting < ApplicationRecord
  has_many :talks, dependent: :nullify
  enum meeting_type: {
    sacrament: 0,
    testimony: 1,
    ward_conference: 2,
    stake_conference: 3,
    general_conference: 4,
    primary_program: 5,
    musical_testimony: 6,
  }

  validates_presence_of :meeting_type, :date
  validates_uniqueness_of :date
end
