# encoding: utf-8

Gem::Specification.new do |gem|

  gem.name        = 'neo4jrb-paperclip'
  gem.version     = '0.0.1'
  gem.platform    = "jruby"
  gem.authors     = 'Leo Lou'
  gem.email       = 'louyuhong@gmail.com'
  gem.homepage    = 'https://github.com/l4u/neo4jrb-paperclip'
  gem.summary     = 'Neo4jrb::Paperclip enables you to use Paperclip with Neo4j.rb'
  gem.description = 'Neo4jrb::Paperclip enables you to use Paperclip with Neo4j.rb'

  gem.files         = %x[git ls-files].split("\n")
  gem.test_files    = %x[git ls-files -- {spec}/*].split("\n")
  gem.require_path  = 'lib'

  gem.add_dependency 'paperclip', ['~> 2.3.6']

end
