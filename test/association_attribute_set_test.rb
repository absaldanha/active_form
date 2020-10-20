# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

module ActiveForm
  class AssociationAttributeSetTest < Minitest::Test
    FakeAssociation = Struct.new(:current_value)

    def test_add_to_set
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new

      assert_equal({ foo: nil }, association_set.to_hash)
    end

    def test_read_association_value
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value")

      assert_equal("foo value", association_set.read_association_value(:foo))
    end

    def test_write_association_value
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value")

      association_set.write_association_value(:foo, "another foo value")

      assert_equal(
        "another foo value",
        association_set.read_association_value(:foo)
      )
    end

    def test_to_hash
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value")

      assert_equal({ foo: "foo value" }, association_set.to_hash)
    end
  end
end
