# frozen_string_literal: true

require "active_support/concern"
require "active_support/core_ext/class/attribute"

module ActiveForm
  module AssociationAttributes
    extend ActiveSupport::Concern

    included do
      class_attribute :association_set, instance_accessor: false,
        default: AssociationAttributeSet.new
    end

    class_methods do
      def association(assoc_name)
        name = assoc_name.to_sym

        build_association_attribute(name)
        define_association_methods(name)
      end

      private

      def build_association_attribute(name)
        self.association_set = association_set.deep_dup

        finder = AssociationFinder.new(name: name)
        association_set[name] = Association.new(finder: finder)
      end

      def define_association_methods(name)
        class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
          delegate :#{name}_id, :#{name}_id=, to: :#{name}

          def #{name}
            association_set.read_association("#{name}")
          end

          def #{name}=(new_assoc)
            association_set.write_association("#{name}", new_value)
          end
        RUBY
      end
    end

    attr_reader :association_set

    def initialize(*)
      @association_set = self.class.association_set.deep_dup
      super
    end
  end
end
