# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "support/models/user"

module ActiveForm
  class Association
    module Loaders
      class SingularLoaderTest < Minitest::Test
        def setup
          @user = User.create
          @another_user = User.create
        end

        def test_load_returns_a_single_record
          loader = Association::Loaders::SingularLoader.new(name: :user)

          assert_instance_of(User, loader.load(@user.id, Object.new))
        end
      end
    end
  end
end
