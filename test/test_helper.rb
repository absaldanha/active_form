# frozen_string_literal: true

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start do
    add_filter "/test/"

    minimum_coverage 100
  end
end

require "bundler/setup"
require "active_form"
require "minitest/autorun"
require "minitest/focus"
require "minitest/reporters"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
