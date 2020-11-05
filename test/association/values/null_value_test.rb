# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class Association
    module Values
      class NullValueTest < Minitest::Test
        def test_current_reader
          value = Association::Values::NullValue.new

          refute(value.current)
        end

        def test_current_writer
          value = Association::Values::NullValue.new

          value.current = "some value"

          refute(value.current)
        end

        def test_key_reader
          value = Association::Values::NullValue.new

          refute(value.key)
        end

        def test_key_writer
          value = Association::Values::NullValue.new

          value.key = 123

          refute(value.key)
        end
      end
    end
  end
end
