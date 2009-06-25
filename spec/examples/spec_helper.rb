require 'rubygems'
require 'active_record'
require 'spec'
require File.join(
  File.dirname(__FILE__),
  '..', '..', 'lib',
  'polymorphic_type_restrictions'
)
require File.join(File.dirname(__FILE__), '..', '..', 'rails', 'init')

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => File.join(File.dirname(__FILE__), '..', 'test.db')
)

stdout = $stdout
$stdout = StringIO.new
ActiveRecord::Schema.define do
  create_table(:posts, :force => true) {}
  create_table(:comments, :force => true) do |t|
    t.references :commentable, :polymorphic => true
  end
  create_table(:photos, :force => true) do |t|
    t.references :attached, :polymorphic => true
  end
  create_table(:users, :force => true) {}
end
$stdout = stdout

ActiveSupport::Dependencies.load_paths <<
  File.join(File.dirname(__FILE__), '..', 'mocks')
