begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'polymorphic_type_restrictions'
    s.summary = 'Restrict polymorphic associations to a set of types'
    s.email = 'mat@patch.com'
    s.homepage = 'http://github.com/outoftime/polymorphic_type_restrictions'
    s.description = 'Restrict polymorphic associations to a set of types'
    s.authors = ['Mat Brown']
    s.files = FileList['[A-Z]*',
                       '{lib,tasks}/**/*',
                       'MIT-LICENSE',
                       'rails/*',
                       'spec/**/*.rb']
    s.add_dependency 'activerecord', '~> 2.1'
    s.add_development_dependency 'rspec', '~> 1.2'
    s.add_development_dependency 'technicalpickles-jeweler', '~> 1.0'
  end
end
