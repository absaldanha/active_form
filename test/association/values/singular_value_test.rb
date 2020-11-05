# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

module ActiveForm
  class Association
    module Values
      class SingularValueTest < Minitest::Test
        DummyValue = Struct.new(:id)

        def test_current_writer_when_value_is_invalid
          value = Association::Values::SingularValue.new

          assert_raises InvalidAssociationValue do
            value.current = "some new value"
          end
        end

        def test_current_writer_when_value_is_valid
          value = Association::Values::SingularValue.new
          object = DummyValue.new(1)

          value.current = object

          assert_equal(value.current, object)
          assert_equal(value.key, 1)
        end

        def test_current_writer_when_value_is_nil
          value = Association::Values::SingularValue.new

          value.current = nil

          assert_nil(value.current)
        end

        def test_key_writer_when_value_is_invalid
          value = Association::Values::SingularValue.new

          assert_raises InvalidAssociationKey do
            value.key = "some new key"
          end
        end

        def test_key_writer_when_value_is_valid
          value = Association::Values::SingularValue.new

          value.key = "123"

          assert_equal(value.key, 123)
        end
      end
    end
  end
end
