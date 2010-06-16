require "rubygems"
require "fileutils"
require "yaml"
require "sequel"
require "sequel/extensions/migration"

task :default => :test

namespace :db do
  desc "Perform migration using migrations in schema/migrations"
  task :migrate do
    db = Sequel.connect("mysql://localhost/storyhub_dev?user=root")
    version = (ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    Sequel::Migrator.apply(db, "db/schema", version, nil)
  end
  
end

require 'spec/rake/spectask'
desc "Run all examples"
Spec::Rake::SpecTask.new('test') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end
