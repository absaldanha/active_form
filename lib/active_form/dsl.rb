# frozen_string_literal: true

module ActiveForm
  module DSL
    extend ActiveSupport::Concern

    included do
      class_attribute :assoc_definition_set, instance_accessor: false,
        default: AssociationDefinitionSet.new
    end

    class_methods do
      def has_one(assoc_name, **options)
        self.assoc_definition_set = assoc_definition_set.deep_dup

        assoc_definition_set.add(
          AssociationDefinition.singular(name: assoc_name, **options)
        )

        generate_accessors(assoc_name, :singular)
      end

      private

      def generate_accessors(assoc_name, _type)
        class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
          def #{assoc_name}
            association_set.read_value(:#{assoc_name})
          end

          def #{assoc_name}=(new_value)
            association_set.write_value(:#{assoc_name}, new_value)
          end

          def #{assoc_name}_id
            association_set.read_key(:#{assoc_name})
          end

          def #{assoc_name}_id=(new_key)
            association_set.write_key(:#{assoc_name}, new_key)
          end
        RUBY
      end
    end

    attr_reader :association_set

    def initialize(*)
      @association_set = self.class.assoc_definition_set.to_association_set
      @association_set.form = self

      super
    end
  end
end
