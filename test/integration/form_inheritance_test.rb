# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "support/models/user"
require "support/models/team"
require "support/models/account"

module ActiveForm
  class FormInheritanceTest < Minitest::Test
    class MainForm
      include ActiveForm::Form
    end

    class FooForm < MainForm
      has_one :user
    end

    class BarForm < MainForm
      has_one :account
    end

    class LittleFoo < FooForm
      has_one :team
    end

    def test_inheritance_across_forms
      main = MainForm.new
      foo = FooForm.new
      bar = BarForm.new
      lil_foo = LittleFoo.new

      assert_respond_to(lil_foo, :team)
      assert_respond_to(lil_foo, :user)
      refute_respond_to(lil_foo, :account)

      assert_respond_to(foo, :user)
      refute_respond_to(foo, :team)
      refute_respond_to(foo, :account)

      assert_respond_to(bar, :account)
      refute_respond_to(bar, :user)
      refute_respond_to(bar, :team)

      refute_respond_to(main, :user)
      refute_respond_to(main, :team)
      refute_respond_to(main, :account)
    end
  end
end
