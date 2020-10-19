# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "active_form/version"

Gem::Specification.new do |spec|
  spec.name          = "active_form"
  spec.version       = ActiveForm::Version::STRING
  spec.authors       = ["Alexandre Saldanha"]
  spec.email         = ["absaldanha@protonmail.com"]
  spec.summary       = "Yet another form object implementation, using ActiveModel's functionality"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata = {
    "source_code_uri" => "https://github.com/absaldanha/active_form"
  }

  spec.files = Dir["lib/**/*"]

  spec.require_path = "lib"

  spec.add_dependency "activerecord", ">= 5.2", "<= 6.0"

  spec.add_development_dependency "minitest", "~> 5.14"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
  spec.add_development_dependency "pry-byebug", "~> 3.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "0.82.0"
  spec.add_development_dependency "simplecov", "~> 0.18.5"
end
