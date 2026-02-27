module CoreExt
  module String
    def numeric?
      true if Float(self)
    rescue StandardError
      false
    end
  end
end

# rubocop:disable Style/OneClassPerFile
class String
  include CoreExt::String
end
# rubocop:enable Style/OneClassPerFile
