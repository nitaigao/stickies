require "rubygems"
require "fileutils"
require "yaml"
require "sequel"
require "sequel/extensions/migration"

task :default => :test

DB = Sequel.connect("mysql://localhost/stickies_dev?user=root")

namespace :db do
  desc "Perform migration using migrations in schema/migrations"
  task :migrate do
    version = (ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    Sequel::Migrator.apply(DB, "db/schema", version, nil)
  end
  
end

require 'spec/rake/spectask'
desc "Run all examples"
Spec::Rake::SpecTask.new('test') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end
