# frozen_string_literal: true

module ActiveForm
  module AssociationAttributes
    extend ActiveSupport::Concern

    included do
      class_attribute :association_options, instance_accessor: false,
        default: {}
    end

    class_methods do
      def has_one(assoc_name, **options)
        options = options.merge(name: assoc_name, type: :has_one)

        store_association(name: assoc_name, options: options)
        build_association_methods(name: assoc_name, type: :has_one)
      end

      private

      def store_association(name:, options:)
        self.association_options = association_options.deep_dup
        association_options[name] = options
      end

      def build_association_methods(name:, type:)
        AssociationMethodBuilder.generate(name: name, klass: self)
      end
    end

    attr_reader :associations

    def initialize(*)
      @associations = Associations.build_from_options(
        options: self.class.association_options.deep_dup,
        form: self
      )

      super
    end
  end
end
