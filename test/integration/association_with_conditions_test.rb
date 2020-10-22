# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "models/user"

module ActiveForm
  class AssociationWithConditionsTest < Minitest::Test
    class FormUserActive
      include ActiveForm::Form

      association :user, conditions: -> { active }
    end

    class FormUserInactive
      include ActiveForm::Form

      association :user, conditions: -> { where(active: false) }
    end

    def setup
      @user = User.create(first_name: "Alexandre", last_name: "Saldanha")
      @other_user = User.create(
        first_name: "Nathália",
        last_name: "Oliveira",
        active: false
      )
    end

    def test_association_with_met_conditions
      form = FormUserActive.new(user_id: @user.id)

      form_user = form.user

      assert_instance_of(User, form_user)
      assert_equal(@user.id, form_user.id)
    end

    def test_association_with_not_met_conditions
      form = FormUserInactive.new(user_id: @user.id)

      assert_nil(form.user)
    end

    def test_association_with_met_conditions_not_scope
      form = FormUserInactive.new(user_id: @other_user.id)

      form_user = form.user

      assert_instance_of(User, form_user)
      assert_equal(@other_user.id, form_user.id)
    end
  end
end
