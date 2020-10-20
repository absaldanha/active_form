# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

module ActiveForm
  class AssociationTest < Minitest::Test
    SimpleObject = Struct.new(:id, keyword_init: true)

    def test_current_value_reader_when_loaded
      finder = Minitest::Mock.new
      association = Association.new(
        finder: finder,
        current_value: "something",
        loaded: true
      )

      assert_equal("something", association.current_value)
    end

    def test_current_value_reader_when_not_loaded_and_with_id
      finder = Minitest::Mock.new
      association = Association.new(finder: finder, id: 123)

      finder.expect(:find, "some value", [{ id: 123 }])

      assert_equal("some value", association.current_value)
      finder.verify
    end

    def test_current_value_reader_when_not_loaded_and_without_id
      finder = Minitest::Mock.new
      association = Association.new(finder: finder)

      assert_nil(association.current_value)
    end

    def test_current_value_setter_with_valid_object
      simple_object = SimpleObject.new(id: 321)
      finder = Minitest::Mock.new
      association = Association.new(finder: finder)

      association.current_value = simple_object

      assert_equal(simple_object, association.current_value)
      assert_equal(321, association.id)
      assert(association.loaded)
    end

    def test_current_value_setter_with_invalid_object
      finder = Minitest::Mock.new
      association = Association.new(finder: finder)

      assert_raises("Invalid Association") do
        association.current_value = "something invalid"
      end
    end

    def test_id_setter
      finder = Minitest::Mock.new
      association = Association.new(
        finder: finder,
        id: 123,
        current_value: "a value",
        loaded: true
      )

      association.id = 321

      refute(association.loaded)
      assert_equal(321, association.id)
    end
  end
end
