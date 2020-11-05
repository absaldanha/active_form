# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "support/models/user"

module ActiveForm
  class AssociationWithCustomClassNameTest < Minitest::Test
    class FooForm
      include ActiveForm::Form

      has_one :owner_user, class_name: "User"
    end

    def setup
      @user = User.create
    end

    def test_association_with_custom_class_name
      form = FooForm.new(owner_user_id: @user.id)

      form_user = form.owner_user

      assert_instance_of(User, form_user)
      assert_equal(@user.id, form_user.id)
    end
  end
end
