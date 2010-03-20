require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "bouncy_bots"
    gem.summary = %Q{Simple negative captcha for Rails}
    gem.description = %Q{Simple negative captcha for Rails}
    gem.homepage = "http://github.com/leshill/bouncy_bots"
    gem.email = "leshill@gmail.com"
    gem.authors = ["Les Hill, Desi McAdam"]
    gem.add_development_dependency "rspec", "= 1.3.0"
    gem.add_development_dependency "activesupport", ">= 2.2"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_opts = ['--options', "#{File.expand_path(File.dirname(__FILE__))}/spec/spec.opts"]
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.spec_opts = ['--options', "#{File.expand_path(File.dirname(__FILE__))}/spec/spec.opts"]
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bouncy_bots #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
