module FixtureHelper
  FIXTURE_TABLES = [
    :access_requests,
    :import_jobs,
    :meetings,
    :members,
    :notes,
    :songs,
    :talks,
    :units,
    :users,
  ].freeze

  ATTRIBUTES_TO_IGNORE = [
    :created_at,
    :confirmation_sent_at,
    :confirmation_token,
    :remember_created_at,
    :reset_password_token,
    :reset_password_sent_at,
    :updated_at,
  ].freeze
end
