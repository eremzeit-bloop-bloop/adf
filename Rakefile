require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc "Quickly [re]generate and view docs"
task :docs do |t|
  puts 'generating documentation ...'
  system("rake --silent doc:recreate TEMPLATE=allison")
  puts 'opening firefox ...'
  system("firefox doc/index.html &")
  puts 'done.'
end

desc 'run specs'
task :spec do
  exec 'spec spec/*'
end

namespace :doc do
  desc "Generate documentation for the application. Set custom template with TEMPLATE=/path/to/rdoc/template.rb"
  Rake::RDocTask.new("create") do |rdoc|
    rdoc.rdoc_dir = 'doc'
    rdoc.main = 'README'
    rdoc.title    = "Andale Advertising - Drivers Club Web Application"
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.options << '--charset' << 'utf-8'
    rdoc.rdoc_files.include('README','COPYING.rdoc')
    rdoc.rdoc_files.include('app/**/*.rb')
    rdoc.rdoc_files.include('lib/**/*.rb')

    # rake doc:create TEMPLATE=allison for a shortcut to using the allison template
    if ENV['TEMPLATE']
      if ENV['TEMPLATE'] == 'allison'
        allison = `gem which allison | grep -v "Can't find " | grep -v "(checking gem"`.strip.sub(/\.rb$/,'')
        rdoc.template = allison unless allison.empty?
      else
        rdoc.template = ENV['TEMPLATE']
      end
    end
  end
end
