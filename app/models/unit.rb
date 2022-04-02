# frozen_string_literal: true

class Unit < ApplicationRecord
  has_many :meetings
  has_many :members
  has_many :users
end
