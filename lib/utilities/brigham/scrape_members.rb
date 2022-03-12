# frozen_string_literal: true

module Brigham
  class ScrapeMembers
    def self.perform(username, password)
      options = Selenium::WebDriver::Chrome::Options.new(args: ["headless"])
      driver = Selenium::WebDriver.for(:chrome, capabilities: options)

      url = "https://id.churchofjesuschrist.org"
      driver.get(url)
      login_form = driver.find_element(css: "form")
      username_field = login_form.find_element(name: "username")
      username_field.send_keys(username)
      login_form.submit
      sleep 1

      password_form = driver.find_element(css: "form")
      password_field = password_form.find_element(name: "password")
      password_field.send_keys(password)
      password_form.submit
      sleep 1

      check_for_okta_push(driver)

      sleep 1

      member_url = "https://lcr.churchofjesuschrist.org/records/member-list"
      driver.get(member_url)

      check_for_okta_push(driver)

      sleep 3

      raise "Could not reach member list; stopped at #{driver.current_url}" unless driver.current_url.include?("member-list")

      5.times { scroll_to_bottom(driver) }

      member_list_element = driver.find_element(css: "table.member-list")
      member_list_rows = member_list_element.find_elements(css: "tr")
      member_list_rows.shift # Throw away the header row

      member_list_rows.map do |row|
        member_attributes = row.find_elements(css: "td")
        attr_array = member_attributes.map(&:text)

        RawMemberRow.new(attr_array[1], attr_array[3], attr_array[5], attr_array[7], attr_array[8])
      rescue => e
        puts e
        puts row.text
      end
    ensure
      driver.quit
    end

    def self.check_for_okta_push(driver)
      if driver.current_url.include?("okta/push")
        okta_form = driver.find_element(css: "form")
        okta_form.submit

        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { driver.current_url.exclude?("okta/push") }
      end
    end

    def self.scroll_to_bottom(driver)
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep 0.3
    end
  end
end
