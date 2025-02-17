RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, :js, type: :system) do
    driven_by :chrome_headless
    # driven_by :chrome_visible
  end

  config.after(:each, type: :job) do
    clear_enqueued_jobs
  end
end
