# Copyright 2012 Bonera Software e Participações S/A.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


$:.push File.expand_path("../lib", __FILE__)
require "maxipago/version"

Gem::Specification.new do |s|
  s.name        = "maxipago"
  s.version     = Maxipago::VERSION
  s.authors     = ["Bonera"]
  s.email       = ["bruno@bonera.com.br"]
  s.homepage    = "https://github.com/bonera/maxipago"
  s.summary     = %q{Use Maxipago with Rails}
  s.description = %q{This gem provides Maxipago API integration with Rails 3 application.}

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "maxipago"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "nokogiri", "~> 1.5.2"
end
