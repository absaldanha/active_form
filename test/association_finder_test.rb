# frozen_string_literal: true

require "test_helper"
require "minitest/mock"
require "support/database_setup"
require "models/user"

module ActiveForm
  class AssociationFinderTest < Minitest::Test
    def setup
      @user = User.create(
        first_name: "Finder",
        last_name: "Test",
        account_id: 1,
        team_id: 2
      )
    end

    def test_find_without_scope
      form = Minitest::Mock.new
      finder = AssociationFinder.new(name: :user, form: form)

      assert_instance_of(User, finder.find(id: @user.id))
    end

    def test_find_with_existing_scope
      form = Minitest::Mock.new
      finder = AssociationFinder.new(
        name: :user,
        form: form,
        scope: :account_id
      )

      form.expect(:account_id, 1)

      assert_instance_of(User, finder.find(id: @user.id))
    end

    def test_find_with_non_existing_scope
      form = Minitest::Mock.new
      finder = AssociationFinder.new(
        name: :user,
        form: form,
        scope: :account_id
      )

      form.expect(:account_id, 123)

      assert_nil(finder.find(id: @user.id))
    end

    def test_find_with_multiple_existing_scopes
      form = Minitest::Mock.new
      finder = AssociationFinder.new(
        name: :user,
        form: form,
        scope: [:account_id, :team_id]
      )

      form.expect(:account_id, 1)
      form.expect(:team_id, 2)

      assert_instance_of(User, finder.find(id: @user.id))
    end

    def test_find_with_multiple_scopes_and_one_is_invalid
      form = Minitest::Mock.new
      finder = AssociationFinder.new(
        name: :user,
        form: form,
        scope: [:account_id, :team_id]
      )

      form.expect(:account_id, 321)
      form.expect(:team_id, 2)

      assert_nil(finder.find(id: @user.id))
    end
  end
end
