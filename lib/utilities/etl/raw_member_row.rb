# frozen_string_literal: true

module Etl
  RawMemberRow = Struct.new(:name, :gender, :birthdate, :phone_number, :email, keyword_init: true)
end
