# frozen_string_literal: true

module ActiveForm
  module Associations
    class HasOne < Base
      def type
        :has_one
      end

      private

      def verify_value(value)
        raise InvalidAssociationValue unless value.respond_to?(:id)
      end

      def assign_value(value)
        self.key = value.id
        @value = value
      end

      def assign_key(key)
        @key = Integer(key)
      rescue ArgumentError
        raise InvalidAssociationKey
      end

      def finder_class
        Finders::HasOne
      end
    end
  end
end
