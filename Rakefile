#!/usr/bin/env rake

require 'hoe'
Hoe.plugin :doofus, :git, :gemcutter

Hoe.spec 'sinatra-default_charset' do
  developer('James Tucker', 'raggi@rubyforge.org')
  extra_dev_deps << %w(hoe-doofus >=1.0.0)
  extra_dev_deps << %w(hoe-git >=1.3.0)
  extra_dev_deps << %w(hoe-gemcutter >=1.0.0)
  extra_dev_deps << %w(rack-test >=0.5.3)
  extra_deps << %w(sinatra >=1.0)
  self.extra_rdoc_files = FileList["**/*.rdoc"]
  self.history_file     = "CHANGELOG.rdoc"
  self.readme_file      = "README.rdoc"
  self.rubyforge_name   = 'libraggi'
  self.testlib          = :minitest
end
