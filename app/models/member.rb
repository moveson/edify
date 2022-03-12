class Member < ApplicationRecord
  has_many :talks
  enum gender: [:male, :female]
end
