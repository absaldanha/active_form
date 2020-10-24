# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

module ActiveForm
  module Associations
    class BaseTest < Minitest::Test
      DummyValue = Struct.new(:id)

      class DummyFinder
        def initialize(*); end

        def find(*); "found you!"; end
      end

      class TestWithAssign < Associations::Base
        def assign_value(value)
          @value = value
        end

        def assign_key(key)
          @key = key
        end
      end

      class TestWithVerify < Associations::Base
        def verify_value(value)
          value.verified!
        end
      end

      class TestWithFinder < Associations::Base
        def assign_value(value)
          @value = value
        end

        def finder_class
          DummyFinder
        end
      end

      def test_initialize_with_proc_value
        proc_value = -> { DummyValue.new(1) }
        form = Minitest::Mock.new

        assoc = TestWithAssign.new(name: :foo, form: form, value: proc_value)

        assert_instance_of(DummyValue, assoc.value)
        assert(assoc.loaded?)
      end

      def test_initialize_without_a_proc_value
        form = Minitest::Mock.new

        assert_raises(ActiveForm::InvalidAssociationDefault) do
          TestWithAssign.new(name: :foo, form: form, value: "value")
        end
      end

      def test_value_setter_verifies_new_value
        form = Minitest::Mock.new
        value = Minitest::Mock.new

        assoc = TestWithVerify.new(name: :foo, form: form)

        value.expect(:verified!, nil)

        assoc.value = value

        value.verify
      end

      def test_value_getter_doesnt_fetch_if_not_loaded
        form = Minitest::Mock.new
        proc_value = -> { DummyValue.new(1) }

        assoc = TestWithFinder.new(name: :foo, form: form, value: proc_value)

        assert_instance_of(DummyValue, assoc.value)
      end

      def test_value_getter_fetches_when_not_loaded
        form = Minitest::Mock.new

        assoc = TestWithFinder.new(name: :foo, form: form)

        refute(assoc.loaded?)
        assert_equal("found you!", assoc.value)
        assert(assoc.loaded?)
      end

      def test_key_setter
        form = Minitest::Mock.new

        assoc = TestWithAssign.new(name: :foo, form: form)

        assoc.key = "some key"

        assert_equal("some key", assoc.key)
      end

      def test_type
        form = Minitest::Mock.new

        assoc = TestWithAssign.new(name: :foo, form: form)

        assert_equal(:base, assoc.type)
      end
    end
  end
end
