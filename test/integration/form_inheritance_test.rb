# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class FormInheritanceTest < Minitest::Test
    class MainForm
      include ActiveForm::Form
    end

    class FooForm < MainForm
      has_one :foo
    end

    class BarForm < MainForm
      has_one :bar
    end

    class LittleFoo < FooForm
      has_one :lil_foo
    end

    def test_inheritance_across_forms
      main = MainForm.new
      foo = FooForm.new
      bar = BarForm.new
      lil_foo = LittleFoo.new

      assert_respond_to(lil_foo, :lil_foo)
      assert_respond_to(lil_foo, :foo)
      refute_respond_to(lil_foo, :bar)

      assert_respond_to(foo, :foo)
      refute_respond_to(foo, :lil_foo)
      refute_respond_to(foo, :bar)

      assert_respond_to(bar, :bar)
      refute_respond_to(bar, :foo)
      refute_respond_to(bar, :lil_foo)

      refute_respond_to(main, :foo)
      refute_respond_to(main, :lil_foo)
      refute_respond_to(main, :bar)
    end
  end
end
