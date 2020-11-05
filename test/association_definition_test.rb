# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class AssociationDefinitionTest < Minitest::Test
    def test_singular
      definition = AssociationDefinition.singular(name: :foo)

      assert_instance_of(AssociationDefinition, definition)
      assert_equal(:singular, definition.type)
    end

    def test_to_association
      definition = AssociationDefinition.singular(name: :foo)
      assoc = definition.to_association

      assert_instance_of(Association, assoc)
    end

    def test_dup
      original_def = AssociationDefinition.singular(
        name: :foo,
        default: -> { "value" },
        scope: [:a, :b],
        conditions: -> { "conditions" }
      )

      dupped_def = original_def.deep_dup

      assert_equal(original_def.value.call, dupped_def.value.call)
      assert_equal(
        original_def.loader_options[:scope],
        dupped_def.loader_options[:scope]
      )
      assert_equal(
        original_def.loader_options[:conditions].call,
        dupped_def.loader_options[:conditions].call
      )

      refute_equal(original_def.value.object_id, dupped_def.value.object_id)
      refute_equal(
        original_def.loader_options.object_id,
        dupped_def.loader_options.object_id
      )
    end
  end
end
