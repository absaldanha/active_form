# frozen_string_literal: true

require "test_helper"
require "minitest/mock"
require "support/database_setup"
require "models/user"

module ActiveForm
  module Finders
    class HasOneTest < Minitest::Test
      def setup
        @user = User.create
      end

      def test_find_by_key_returns_one_value_when_it_finds
        form = Minitest::Mock.new
        finder = Finders::HasOne.new(name: :user, form: form)

        assert_instance_of(User, finder.find(@user.id))
      end
    end
  end
end
