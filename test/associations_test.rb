# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class AssociationsTest < Minitest::Test
    def test_build_from_options
      form = Object.new
      options = {
        user: { name: :user, type: :has_one, scope: :foo },
        account: { name: :account, type: :has_one, scope: :bar }
      }

      result = Associations.build_from_options(options: options, form: form)

      assert_kind_of(Hash, result)
      assert_equal(2, result.size)
      assert_instance_of(Associations::HasOne, result[:user])
      assert_instance_of(Associations::HasOne, result[:account])
    end

    def test_build_when_type_is_has_one
      form = Object.new
      assoc = Associations.build(name: :foo, type: :has_one, form: form)

      assert_instance_of(Associations::HasOne, assoc)
    end

    def test_has_one
      form = Object.new
      assoc = Associations.has_one(name: :foo, form: form)

      assert_instance_of(Associations::HasOne, assoc)
    end
  end
end
