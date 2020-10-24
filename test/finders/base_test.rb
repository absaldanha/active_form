# frozen_string_literal: true

require "test_helper"
require "minitest/mock"
require "support/database_setup"
require "models/user"

module ActiveForm
  module Finders
    class BaseTest < Minitest::Test
      class TestFinder < Finders::Base
        def find_by_key(relation, _key)
          relation
        end
      end

      def test_finder_class
        form = Minitest::Mock.new
        finder = TestFinder.new(name: :user, form: form)

        assert_equal(User, finder.find(1))
      end

      def test_scope_relation_with_one_value
        form = Minitest::Mock.new
        finder = TestFinder.new(name: :user, form: form, scope: :foo)

        form.expect(:foo, "aaa")

        assert_match(/WHERE "users"."foo" = 'aaa'/, finder.find(1).to_sql)
      end

      def test_scope_relation_with_multiple_values
        form = Minitest::Mock.new
        finder = TestFinder.new(name: :user, form: form, scope: [:foo, :bar])

        form.expect(:foo, "aaa")
        form.expect(:bar, "bbb")

        result_relation_sql = finder.find(1).to_sql

        assert_match(/WHERE "users"."foo" = 'aaa'/, result_relation_sql)
        assert_match(/AND "users"."bar" = 'bbb'/, result_relation_sql)
      end

      def test_conditions
        form = Minitest::Mock.new
        finder = TestFinder.new(
          name: :user,
          form: form,
          conditions: -> { active }
        )

        assert_match(/WHERE "users"."active" = 1/, finder.find(1).to_sql)
      end
    end
  end
end
