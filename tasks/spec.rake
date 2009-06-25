require 'spec/rake/spectask'

desc 'run specs'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList[File.join(File.dirname(__FILE__), '..', 'spec', 'examples', '**', '*_spec.rb')]
  t.spec_opts = ['--color']
end
