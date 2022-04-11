# frozen_string_literal: true

module Madmin
  class ActiveStorage::BlobsController < Madmin::ResourceController
    def new
      super
      @record.assign_attributes(filename: "")
    end
  end
end
