# frozen_string_literal: true

require "test_helper"
require "minitest/mock"
require "support/database_setup"
require "support/models/user"

module ActiveForm
  class Association
    module Loaders
      class BaseTest < Minitest::Test
        class TestLoader < Association::Loaders::Base
          def find_by_key(relation, _key)
            relation
          end
        end

        def test_load_finds_on_correct_class
          loader = TestLoader.new(name: :user)

          assert_equal(User, loader.load(123, Object.new))
        end

        def test_load_with_scope_on_one_value
          form = Minitest::Mock.new
          loader = TestLoader.new(name: :user, scope: :foo)

          form.expect(:foo, "aaa")

          assert_match(
            /WHERE "users"."foo" = 'aaa'/,
            loader.load(123, form).to_sql
          )
        end

        def test_load_with_scope_on_multiple_values
          form = Minitest::Mock.new
          loader = TestLoader.new(name: :user, scope: [:foo, :bar])

          form.expect(:foo, "aaa")
          form.expect(:bar, "bbb")

          result_sql = loader.load(123, form).to_sql

          assert_match(/WHERE "users"."foo" = 'aaa'/, result_sql)
          assert_match(/AND "users"."bar" = 'bbb'/, result_sql)
        end

        def test_load_with_conditions
          loader = TestLoader.new(name: :user, conditions: -> { active })

          assert_match(
            /WHERE "users"."active" = 1/,
            loader.load(123, Object.new).to_sql
          )
        end
      end
    end
  end
end
