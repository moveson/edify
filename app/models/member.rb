class Member < ApplicationRecord
  has_many :talks
  enum gender: [:male, :female]

  validates_presence_of :name, :gender, :birthdate
end
