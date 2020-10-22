# frozen_string_literal: true

module ActiveForm
  module AssociationAttributes
    extend ActiveSupport::Concern

    included do
      class_attribute :associations, instance_accessor: false,
        default: {}
    end

    class_methods do
      def association(assoc_name, **options)
        name = assoc_name.to_sym

        build_association_attribute(name, options)
        define_association_methods(name)
      end

      private

      def build_association_attribute(name, options)
        self.associations = associations.deep_dup

        associations[name] = options.merge(name: name)
      end

      def define_association_methods(name)
        class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
          def #{name}
            association_set.read_association_value(:#{name})
          end

          def #{name}=(new_assoc)
            association_set.write_association_value(:#{name}, new_value)
          end

          def #{name}_id
            association_set.read_association_id(:#{name})
          end

          def #{name}_id=(new_id)
            association_set.write_association_id(:#{name}, new_id)
          end
        RUBY
      end
    end

    attr_reader :association_set

    def initialize(*)
      @association_set = AssociationAttributeSet.build(
        associations: self.class.associations.deep_dup,
        form: self
      )

      super
    end
  end
end
