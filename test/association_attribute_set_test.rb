# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

module ActiveForm
  class AssociationAttributeSetTest < Minitest::Test
    FakeAssociation = Struct.new(:current_value, :id)

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

    def test_read_association_id
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value", 123)

      assert_equal(123, association_set.read_association_id(:foo))
    end

    def test_write_association_id
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value", 123)

      association_set.write_association_id(:foo, 321)

      assert_equal(321, association_set.read_association_id(:foo))
    end

    def test_to_hash
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value")

      assert_equal({ foo: "foo value" }, association_set.to_hash)
    end

    def test_deep_dup
      association_set = AssociationAttributeSet.new

      association_set[:foo] = FakeAssociation.new("foo value")

      dupped_set = association_set.deep_dup

      original_assocs = association_set.instance_variable_get(:@associations)
      dupped_assocs = dupped_set.instance_variable_get(:@associations)

      refute_equal(association_set.object_id, dupped_set.object_id)
      refute_equal(original_assocs.object_id, dupped_assocs.object_id)
      refute_equal(
        original_assocs[:foo].object_id,
        dupped_assocs[:foo].object_id
      )
    end
  end
end
