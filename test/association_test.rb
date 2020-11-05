# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class AssociationTest < Minitest::Test
    DummyValue = Struct.new(:current, :key)

    def test_build_when_type_is_singular
      assoc = Association.build(type: :singular, name: :foo)

      assert_instance_of(Association, assoc)
    end

    def test_build_when_type_is_invalid
      assert_raises(InvalidAssociationType) do
        Association.build(type: :unknown, name: :foo)
      end
    end

    def test_loaded_when_initialized_with_truthy_value
      value = DummyValue.new("current value")

      assoc = Association.new(name: :foo, value: value)

      assert(assoc.loaded?)
    end

    def test_loaded_when_initialized_with_falsy_value
      value = DummyValue.new

      assoc = Association.new(name: :foo, value: value)

      refute(assoc.loaded?)
    end

    def test_value_writer
      value = DummyValue.new

      assoc = Association.new(name: :foo, value: value)

      assoc.value = "new value"

      assert(assoc.loaded?)
      assert_equal("new value", assoc.value)
    end

    def test_value_reader
      value = DummyValue.new("the value")

      assoc = Association.new(name: :foo, value: value)

      assert_equal("the value", assoc.value)
    end

    def test_key_writer
      value = DummyValue.new("some value", 741)

      assoc = Association.new(name: :foo, value: value)

      assoc.key = 321

      assert_equal(321, assoc.key)
      assert_nil(assoc.value)
      refute(assoc.loaded?)
    end

    def test_key_reader
      value = DummyValue.new(nil, 123)

      assoc = Association.new(name: :foo, value: value)

      assert_equal(123, assoc.key)
    end
  end
end
