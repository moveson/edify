class Member < ApplicationRecord
  has_many :talks
  enum gender: [:male, :female]

  validates_presence_of :name, :gender, :birthdate
  validates_uniqueness_of :name, scope: :birthdate

  def age
    (Date.current - birthdate).to_i / 365
  end
end
