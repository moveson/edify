# Credit to Yi Zeng, https://yizeng.me/2017/07/16/generate-rails-test-fixtures-yaml-from-database-dump/

require_relative "fixture_helper"

namespace :db do
  desc "Convert development database to Rails test fixtures"
  task to_fixtures: :environment do
    process_start_time = Time.current

    begin
      ActiveRecord::Base.establish_connection
      ActiveRecord::Base.connection.tables.each do |table_name|
        next unless table_name.to_sym.in?(FixtureHelper::FIXTURE_TABLES)

        file_path = Rails.root.join("spec/fixtures/#{table_name}.yml")
        File.open(file_path, "w") do |file|
          rows = ActiveRecord::Base.connection.select_all("SELECT * FROM #{table_name} ORDER BY id")
          data = rows.each_with_object({}) do |record, hash|
            custom_title = case table_name
                           when "units"
                             record["name"].split.first(2).join(" ").parameterize.underscore
                           when "users"
                             record["first_name"].parameterize.underscore
                           when "members"
                             record["name"].parameterize.underscore
                           end

            title = custom_title || "#{table_name.singularize}_#{record['id']}"
            FixtureHelper::ATTRIBUTES_TO_IGNORE.each { |attr| record.delete(attr.to_s) }
            hash[title] = record
          end
          puts "Writing table '#{table_name}' to '#{file_path}'"
          file.write(data.to_yaml)
        end
      end
    ensure
      ActiveRecord::Base.connection&.close
    end

    elapsed_time = Time.current - process_start_time
    puts "\nFinished creating fixtures for #{FixtureHelper::FIXTURE_TABLES.join(', ')} in #{elapsed_time} seconds"
  end

  desc "Convert Rails test fixtures to development database"
  task from_fixtures: :environment do
    process_start_time = Time.current

    begin
      ActiveRecord::Base.establish_connection
      ENV["FIXTURES_PATH"] = "spec/fixtures"
      ENV["FIXTURES"] = FixtureHelper::FIXTURE_TABLES.join(",")
      ENV["RAILS_ENV"] = "development"
      Rake::Task["db:fixtures:load"].invoke
    ensure
      ActiveRecord::Base.connection&.close
    end

    elapsed_time = Time.current - process_start_time
    puts "\nFinished creating records for #{FixtureHelper::FIXTURE_TABLES.join(', ')} in #{elapsed_time} seconds"
  end
end
