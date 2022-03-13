require "csv"

namespace :temp do
  desc "Imports talks from csv format"
  task :import_talks, [:filename] => :environment do |_, args|
    Rails.application.eager_load!

    filename = args[:filename]
    table = CSV.parse(File.read(filename), headers: true)

    table.each do |row|
      row_hash = row.to_hash
      row_hash.transform_keys! { |key| key.underscore.to_sym }
      name = row_hash[:speaker_name]
      row_hash[:member_id] = Member.where("name ilike ?", "#{name}%").first&.id
      Talk.create(row_hash)
    end

    puts "Finished importing talks"
  end
end