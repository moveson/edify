# frozen_string_literal: true

module Edify
  module Etl
    RawMemberRow = Struct.new(:name, :gender, :birthdate, :phone_number, :email)
  end
end
