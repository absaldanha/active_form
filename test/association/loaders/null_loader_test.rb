# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class Association
    module Loaders
      class NullLoaderTest < Minitest::Test
        def test_load
          loader = Association::Loaders::NullLoader.new

          refute(loader.load(123, Object.new))
        end
      end
    end
  end
end
