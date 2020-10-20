# frozen_string_literal: true

require "test_helper"
require "models/user"

module ActiveForm
  class AssociationAttributesTest < Minitest::Test
    class SampleClass
      include ActiveForm::AssociationAttributes

      association :user
    end

    def test_generates_association_accessors
      sample = SampleClass.new

      assert_respond_to sample, :user
      assert_respond_to sample, :user=
    end

    def test_generates_association_id_accessors
      sample = SampleClass.new

      assert_respond_to sample, :user_id
      assert_respond_to sample, :user_id=
    end
  end
end
