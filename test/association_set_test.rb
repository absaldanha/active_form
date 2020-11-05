# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

module ActiveForm
  class AssociationSetTest < Minitest::Test
    DummyObject = Struct.new(:id)

    def test_add
      dummy = DummyObject.new(1)
      assoc = Association.build(
        type: :singular,
        name: :foo,
        value: dummy
      )

      set = AssociationSet.new

      set.add(assoc)

      assert_equal(dummy, set.read_value(:foo))
    end

    def test_read_value_when_loaded
      dummy = DummyObject.new
      assoc = Association.build(
        type: :singular,
        name: :foo,
        value: dummy
      )

      set = AssociationSet.new(associations: { foo: assoc })

      assert_equal(dummy, set.read_value(:foo))
    end

    def test_read_value_when_not_loaded
      loader = Minitest::Mock.new
      dummy = DummyObject.new
      assoc = Association.new(
        name: :foo,
        value: Association::Values::SingularValue.new,
        loader: loader
      )

      loader.expect(:load, dummy, [123, nil])

      set = AssociationSet.new(associations: { foo: assoc })

      set.write_key(:foo, 123)

      assert_equal(dummy, set.read_value(:foo))
    end

    def test_write_value
      dummy = DummyObject.new(1)
      other_dummy = DummyObject.new(2)

      assoc = Association.build(
        type: :singular,
        name: :foo,
        value: dummy
      )

      set = AssociationSet.new(associations: { foo: assoc })

      set.write_value(:foo, other_dummy)

      assert_equal(other_dummy, set.read_value(:foo))
    end

    def test_read_key
      dummy = DummyObject.new(321)
      assoc = Association.build(
        type: :singular,
        name: :foo,
        value: dummy
      )

      set = AssociationSet.new(associations: { foo: assoc })

      assert_equal(321, set.read_key(:foo))
    end

    def test_write_key
      dummy = DummyObject.new
      assoc = Association.build(
        type: :singular,
        name: :foo,
        value: dummy
      )

      set = AssociationSet.new(associations: { foo: assoc })

      set.write_key(:foo, 951)

      assert_equal(951, set.read_key(:foo))
    end
  end
end
