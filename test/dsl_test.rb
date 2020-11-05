# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class DSLTest < Minitest::Test
    class TestClassHasOne
      include ActiveForm::DSL

      has_one :foo
    end

    def test_has_one
      test_has_one = TestClassHasOne.new

      assert_respond_to(test_has_one, :foo)
      assert_respond_to(test_has_one, :foo=)
      assert_respond_to(test_has_one, :foo_id)
      assert_respond_to(test_has_one, :foo_id=)
    end
  end
end
