# frozen_string_literal: true

require "test_helper"

module ActiveForm
  module Associations
    class HasOneTest < Minitest::Test
      DummyValue = Struct.new(:id)

      def test_verifies_value_responds_to_id
        form = Object.new
        assoc = Associations::HasOne.new(name: :foo, form: form)

        assert_raises(InvalidAssociationValue) do
          assoc.value = "some value"
        end
      end

      def test_value_setter_also_sets_key
        form = Object.new
        assoc = Associations::HasOne.new(name: :foo, form: form)

        value = DummyValue.new(123)

        assoc.value = value

        assert_instance_of(DummyValue, assoc.value)
        assert_equal(123, assoc.key)
      end

      def test_key_setter_casts_to_integer
        form = Object.new
        assoc = Associations::HasOne.new(name: :foo, form: form)

        assoc.key = "123"

        assert_equal(123, assoc.key)
      end

      def test_key_setter_raises_when_invalid_value
        form = Object.new
        assoc = Associations::HasOne.new(name: :foo, form: form)

        assert_raises(InvalidAssociationKey) do
          assoc.key = "bar"
        end
      end

      def test_type
        form = Object.new
        assoc = Associations::HasOne.new(name: :foo, form: form)

        assert_equal(:has_one, assoc.type)
      end
    end
  end
end
