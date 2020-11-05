# frozen_string_literal: true

module ActiveForm
  class AssociationDefinitionSet
    attr_reader :definitions

    def initialize(definitions: [])
      @definitions = definitions
    end

    def add(definition)
      definitions.push(definition)
    end

    def to_association_set
      AssociationSet.new.tap do |assoc_set|
        definitions.each do |definition|
          assoc_set.add(definition.to_association)
        end
      end
    end

    def initialize_dup(*)
      @definitions = @definitions.deep_dup

      super
    end
  end
end
