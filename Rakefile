# encoding: utf-8

require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler."
  exit -1
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard

require "bundler/gem_tasks"

task :build_parsers do
  wd = Dir.pwd
  Dir.chdir "lib/brevity/parsing"
  parser_files = Dir.glob(["*.treetop","*.tt"])
  
  if parser_files.empty?
    puts "No parsers found"
    return
  end

  build_list = parser_files.select do |fname|
    basename = File.basename(fname, File.extname(fname))
    rb_name = "#{basename}.rb"
    !File.exists?(rb_name) || (File.mtime(fname) > File.mtime(rb_name))
  end
  
  if build_list.any?
    puts "building parsers:"
    build_list.each do |fname|
      basename = File.basename(fname, File.extname(fname))
      puts "  #{fname} -> #{basename}.rb"
      `tt -f #{fname}`
    end
  else
    puts "Parsers are up-to-date"
  end
  Dir.chdir wd
end
task :spec => :build_parsers