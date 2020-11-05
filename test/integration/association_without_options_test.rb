# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "support/models/user"

module ActiveForm
  class AssociationWithoutOptionsTest < Minitest::Test
    class TestForm
      include ActiveForm::Form

      has_one :user
    end

    def test_generates_association_accessors
      form = TestForm.new

      assert_respond_to form, :user
      assert_respond_to form, :user=
    end

    def test_generates_association_id_accessors
      form = TestForm.new

      assert_respond_to form, :user_id
      assert_respond_to form, :user_id=
    end
  end
end
