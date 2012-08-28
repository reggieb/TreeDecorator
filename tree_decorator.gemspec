require 'rake/gempackagetask'

Gem::Specification.new do |s|
  s.name = 'tree_decorator'
  s.version = '0.1.2'
  s.authors = ['Rob Nichols']
  s.date = %q{2012-08-28}
  s.description = "A tool that walks through a hash or nested object and applies code to containers and elements based on user defined rules."
  s.summary = "Tree Decorator decorates trees or nested sets of data"
  s.email = 'rob@undervale.co.uk'
  s.homepage = 'https://github.com/reggieb/TreeDecorator'
  s.files = ['README.md', 'LICENSE', FileList['lib/**/*.rb']].flatten
  s.require_path = "lib"
end