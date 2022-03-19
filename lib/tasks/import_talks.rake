require "csv"

namespace :temp do
  desc "Imports talks from csv format"
  task :import_talks, [:filename] => :environment do |_, args|
    Rails.application.eager_load!

    filename = args[:filename]
    table = CSV.parse(File.read(filename), headers: true)

    table.each do |row|
      row_hash = row.to_hash
      row_hash.transform_keys!(&:underscore)
      Talk.create(row_hash)
    end

    puts "Finished importing talks"
  end
end
