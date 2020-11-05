# frozen_string_literal: true

require "test_helper"

module ActiveForm
  class AssociationDefinitionSetTest < Minitest::Test
    def test_add
      set = AssociationDefinitionSet.new

      definition = AssociationDefinition.singular(name: :foo)

      set.add(definition)

      assert_includes(set.definitions, definition)
    end

    def test_to_association_set
      definition = AssociationDefinition.singular(name: :foo)

      def_set = AssociationDefinitionSet.new(definitions: [definition])

      assoc_set = def_set.to_association_set

      assert_instance_of(AssociationSet, assoc_set)
    end

    def test_dup
      definition = AssociationDefinition.singular(name: :foo)
      original_set = AssociationDefinitionSet.new(definitions: [definition])

      dupped_set = original_set.deep_dup

      assert_equal(1, dupped_set.definitions.size)
      assert_equal(:foo, dupped_set.definitions.first.name)

      refute_equal(definition.object_id, dupped_set.definitions.first.object_id)
    end
  end
end
