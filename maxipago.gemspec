$:.push File.expand_path("../lib", __FILE__)
require "maxipago/version"

Gem::Specification.new do |spec|
  spec.name        = "maxipago"
  spec.version     = Maxipago::VERSION
  spec.authors     = ["Bruno Barros"]
  spec.email       = ["brunosoab@gmail.com"]
  spec.homepage    = "https://github.com/brunosoab/maxipago"
  spec.summary     = %q{Wrapper for the Maxipago API}
  spec.description = %q{This gem provides Maxipago API integration with Rails applications.}
  spec.required_rubygems_version = ">= 1.3.6"
  spec.rubyforge_project = "maxipago"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.0"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "fakeweb", "~> 1.3.0"
end
