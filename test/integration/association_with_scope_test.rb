# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "models/account"
require "models/user"

module ActiveForm
  class AssociationWithScopeTest < Minitest::Test
    class SampleWithAttribute
      include ActiveForm::Form

      association :user, scope: :account_id

      attribute :account_id, :integer
    end

    class SampleWithAssociation
      include ActiveForm::Form

      association :user, scope: :account_id
      association :account
    end

    def setup
      @account = Account.create(name: "SomeAccount")
      @user = User.create(
        first_name: "Alexandre",
        last_name: "Saldanha",
        account: @account
      )
    end

    def test_association_with_scope_on_attribute
      sample = SampleWithAttribute.new(
        account_id: @account.id,
        user_id: @user.id
      )

      form_user = sample.user

      assert_instance_of(User, form_user)
      assert_equal(@user.id, form_user.id)
    end

    def test_association_with_scope_on_other_association
      sample = SampleWithAssociation.new(
        account_id: @account.id,
        user_id: @user.id
      )

      form_user = sample.user

      assert_instance_of(User, form_user)
      assert_equal(@user.id, form_user.id)
    end

    def test_association_with_scope_when_id_doesnt_exist
      sample = SampleWithAssociation.new(
        account_id: @account.id,
        user_id: @user.id + rand(100)
      )

      assert_nil(sample.user)
    end

    def test_association_with_scope_when_scoped_value_doesnt_exist
      sample = SampleWithAssociation.new(
        account_id: @account.id + rand(100),
        user_id: @user.id
      )

      assert_nil(sample.user)
    end
  end
end
