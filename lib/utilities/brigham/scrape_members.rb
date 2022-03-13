# frozen_string_literal: true

module Brigham
  class ScrapeMembers
    def self.perform(username:, password:, import_job:)
      new(username: username, password: password, import_job: import_job).perform
    end

    def initialize(username:, password:, import_job:)
      @username = username
      @password = password
      @import_job = import_job
      @raw_member_rows = []
    end

    def perform
      perform_authorization
      scrape_members if errors.empty?

      raw_member_rows
    ensure
      driver.quit
    end

    private

    attr_reader :username, :password, :import_job, :raw_member_rows
    delegate :errors, to: :import_job, private: true

    def perform_authorization
      import_job.authorizing!
      import_job.set_elapsed_time!

      import_job.update(status_text: "Providing username")
      url = "https://id.churchofjesuschrist.org"
      driver.get(url)
      login_form = driver.find_element(css: "form")
      username_field = login_form.find_element(name: "username")
      username_field.send_keys(username)
      login_form.submit
      import_job.set_elapsed_time!
      sleep 1

      import_job.set_elapsed_time!
      import_job.update(status_text: "Providing password")
      password_form = driver.find_element(css: "form")
      password_field = password_form.find_element(name: "password")
      password_field.send_keys(password)
      password_form.submit
      import_job.set_elapsed_time!
      sleep 1

      check_for_okta_push

      sleep 1

      import_job.set_elapsed_time!
      import_job.update(status: :extracting, status_text: "Requesting member list")
      member_url = "https://lcr.churchofjesuschrist.org/records/member-list"
      driver.get(member_url)

      check_for_okta_push

      sleep 3

      import_job.set_elapsed_time!
      unless driver.current_url.include?("member-list")
        errors.add(:base, "Could not reach member list; ended on #{driver.current_url}")
      end
    rescue Selenium::WebDriver::Error::TimeoutError => e
      errors.add(:base, e)
    end

    def scrape_members
      scroll_to_bottom

      import_job.update(status_text: "Parsing member list")
      member_list_element = driver.find_element(css: "table.member-list")
      member_list_rows = member_list_element.find_elements(css: "tr")
      member_list_rows.shift # Throw away the header row

      import_job.update(row_count: member_list_rows.size)
      member_list_rows.each.with_index(1) do |row, row_index|
        member_attributes = row.find_elements(css: "td")
        attr_array = member_attributes.map(&:text)

        raw_member_row = RawMemberRow.new(attr_array[1], attr_array[3], attr_array[5], attr_array[7])
        raw_member_rows << raw_member_row
        import_job.increment!(:success_count)
      rescue => e
        errors.add(:base, "#{e}: #{row_index}")
        import_job.increment!(:failed_count)
      ensure
        import_job.set_elapsed_time!
      end
    end

    def driver
      @driver ||=
        Selenium::WebDriver.for(:chrome, capabilities: driver_options)
    end

    def driver_options
      chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)

      chrome_options = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}
      options = { args: ["headless"] }.merge(chrome_options)
      Selenium::WebDriver::Chrome::Options.new(**options)
    end

    def check_for_okta_push
      import_job.set_elapsed_time!

      if driver.current_url.include?("okta/push")
        import_job.update(status_text: "Requesting Okta push")
        okta_form = driver.find_element(css: "form")
        okta_form.submit

        import_job.update(status_text: "Waiting for Okta response")
        wait = Selenium::WebDriver::Wait.new(:timeout => 30)
        wait.until { driver.current_url.exclude?("okta/push") }
      end
    end

    def scroll_to_bottom
      5.times do
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        sleep 0.3
      end
    end
  end
end
