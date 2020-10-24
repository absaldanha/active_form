# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class AssociationMethodBuilderTest < Minitest::Test
    class DummyTest; end

    def test_generate
      AssociationMethodBuilder.generate(name: :foo, klass: DummyTest)

      dummy = DummyTest.new

      assert_respond_to(dummy, :foo)
      assert_respond_to(dummy, :foo=)
      assert_respond_to(dummy, :foo_id)
      assert_respond_to(dummy, :foo_id=)
    end
  end
end
