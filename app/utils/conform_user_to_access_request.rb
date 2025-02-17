class ConformUserToAccessRequest
  # @param [::AccessRequest] access_request
  # @return [Boolean]
  def self.perform!(access_request)
    new(access_request).perform!
  end

  # @param [::AccessRequest] access_request
  def initialize(access_request)
    @access_request = access_request
  end

  # @return [Boolean]
  def perform!
    update_user if access_request.valid?
    access_request.errors.merge!(user)

    access_request.errors.present?
  end

  private

  attr_reader :access_request

  delegate :user, to: :access_request, private: true

  def update_user
    if access_request.approved?
      user.update(
        role: access_request.approved_role,
        unit: access_request.unit,
      )
    elsif access_request.rejected?
      user.update(
        role: nil,
        unit: nil,
      )
    end
  end
end
